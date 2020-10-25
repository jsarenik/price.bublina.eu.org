#!/bin/sh

DNS=pr.bublina.eu.org
OLDREF=$(./dnslink.sh $DNS)
NEWREF=$(ipfs add -Qr public)
ipfs pin rm $OLDREF
ssh random ipfs pin add $NEWREF
ssh random2 ipfs pin add $NEWREF
ssh random ipfs pin rm $OLDREF
ssh random2 ipfs pin rm $OLDREF
./dnslink-set.sh $DNS $NEWREF
