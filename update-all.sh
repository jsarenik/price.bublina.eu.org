#!/bin/sh
#
# Meant to be run by crontab: 10 5 * * * ssh host
# where ~/.ssh/authorized_keys on host contain something like
# command="~/web/bitcoin.zorinaq.com/update-all.sh" ssh-ed25519 AAAAC3Nz...

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit
date
mkdir public
cp -a public-populate/* public/
./days.sh # updates public/dates.json if non-empty result
./update-datapoints.sh
#./contrib/dataget.sh > datapoints; sed -i '$d' datapoints
./update-blockdata.sh
./gen-inline.sh
./gen-inline-loglog.sh
./gen-hafuch.sh
./gen-hafuch-linear.sh
./gen-variant.sh monthly
./gen-variant.sh yearly
./gen-variant.sh yearly-low
cp public/yearly-low.html public/low.html
./gen-variant.sh monthly-low
./gen-linear.sh
#./update-headers.sh > public/_headers
./contrib/datacompare.sh > public/datacompare.txt
./contrib/wgetcompare.sh > public/wgetcompare.txt
cp datapoints public/datapoints.txt
cp datapoints-blocks public/datapoints-blocks.txt

test "$RUN_BROTLI" = "1" && {
  echo Running brotli
  which brotli
  ./brotli-it.sh public
} || echo "Brotli not run"
