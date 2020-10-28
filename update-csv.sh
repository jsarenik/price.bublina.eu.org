#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR

./update.sh >/dev/null
./mkcsv.sh >public/datapoints.csv
printf "Generating index.html... "
cat html/00* html/3* html/99* > public/index.html \
  && echo OK
