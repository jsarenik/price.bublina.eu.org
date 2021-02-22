#!/bin/sh
#
# ipfs daemon should be running on the machine
# where this script is run

test -n "$DEBUG" && set -x

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
URC=$BINDIR/update-ipfs.conf

# Default values
PUBLICDIR=public
NUMNODES=3
test -r $URC && . $URC
test -n "$DNS" || { echo "DNS not set in $URC! Exiting." >&2; exit 1; }

SPFTRC=$HOME/.spf-toolsrc
# Read TOKEN
test -r $SPFTRC && . $SPFTRC
test -n "$TOKEN" || { echo "TOKEN not set in $SPFTRC! Exiting." >&2; exit 1; }

idsfile=$(mktemp /tmp/cloudflare-ids-XXXXXX)
zonefile=$(mktemp /tmp/cloudflare-zone-XXXX)

trap "rm -f $idsfile $zonefile $zonefile-data" EXIT
for cmd in jq grep
do
  type $cmd >&2 || exit 1
done

ipfsdo() {
  ssh $1 "ipfs pin $2 $3"
}

nodesdo() {
  RET=0
  for i in $(seq $NUMNODES)
  do
    ipfsdo node$i $1 $2 || RET=1
  done
  return $RET
}

dnslinkget() {
  PARENT=${2:-${1#*.}}
  NS=$(dig -t NS +short $PARENT)
  dig +short TXT _dnslink.$1 @$NS \
    | sed -E 's/"dnslink=(.*)"/\1/g'
}

apicmd() {
  CMD=${1:-'GET'}
  test -n "$1" && shift
  REST=${1:-'/zones'}
  test -n "$1" && shift
  curl -X $CMD ${APIURL}${REST} \
    -s \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type:application/json" \
    "$@"
}

dnslinkset() {
  name=_dnslink.$1
  content="dnslink=$2"

  APIURL="https://api.cloudflare.com/client/v4"

  DOMAIN_ID=$(apicmd GET /zones | jq -r '.result | .[] | .name + ":" + .id' \
      | grep $DOMAIN) \
    || exit 1
  DOMAIN_ID=$(echo $DOMAIN_ID | cut -d: -f2)

  apicmd GET "/zones/$DOMAIN_ID/dns_records?type=TXT&name=$name&per_page=100" \
    | jq -r '.result | .[] | .name + ":" + .id' > $idsfile

  grep $name $idsfile || exit 1
  id_to_change=$(grep "^$name" $idsfile | cut -d: -f2)

  echo -n "Changing $name with id $id_to_change... "
  cat > $zonefile-data <<EOF
{"type":"TXT","name":"$name","content":"$content"}
EOF
  test -n "$DEBUG" && cat $zonefile-data

  apicmd PUT "/zones/$DOMAIN_ID/dns_records/$id_to_change" \
    --data @${zonefile}-data | jq .success | grep -q true \
    && echo OK || { echo error; return 1; }
}

NEWREF=$(ipfs add -Qr $PUBLICDIR) \
  && echo "pinned $NEWREF recursively (local)" \
  || exit 1
OLDREF=$(dnslinkget $DNS)
test "${OLDREF##*/}" = "$NEWREF" && { echo "No change"; exit 1; }

nodesdo add $NEWREF || exit 1
./update-pinata.sh $NEWREF ${OLDREF##*/}
dnslinkset $DNS /ipfs/$NEWREF || exit 1
ipfs pin rm $OLDREF
nodesdo rm $OLDREF
