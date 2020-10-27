#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR

./update.sh >/dev/null
./mkcsv.sh
printf "Geterating index.html... "
cat html/00* html/3* html/99* > public/index.html \
  && cp datapoints.csv public \
  && echo OK
