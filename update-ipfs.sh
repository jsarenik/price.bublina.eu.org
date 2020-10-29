#!/bin/sh
#
# ipfs daemon should be running on the machine
# where this script is run

DNS=price.bublina.eu.org

updateremote() {
  ssh $1 "ipfs pin add $2 && ipfs pin rm $3"
}

OLDREF=$(./dnslink.sh $DNS)
NEWREF=$(ipfs add -Qr public)
test "${OLDREF##*/}" = "$NEWREF" && { echo "No change"; exit 1; }

ipfs pin rm $OLDREF
for i in $(seq 3)
do
  updateremote node$i $NEWREF $OLDREF
done
./dnslink-set.sh $DNS /ipfs/$NEWREF
