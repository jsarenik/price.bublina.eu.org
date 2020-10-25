#!/bin/sh
#
# ipfs daemon should be running on the machine
# where this script is run

DNS=pr.bublina.eu.org

updateremote() {
  ssh $1 ipfs pin add $2
  ssh $1 ipfs pin rm $3
}

OLDREF=$(./dnslink.sh $DNS | cut -d/ -f3-)
NEWREF=$(ipfs add -Qr public)
test "$OLDREF" = "$NEWREF" && { echo "No change"; exit 1; }

ipfs pin rm $OLDREF
for i in $(seq 3)
do
  updateremote random$i $NEWREF $OLDREF
done
./dnslink-set.sh $DNS $NEWREF
