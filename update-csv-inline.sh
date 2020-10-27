#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR

./update.sh >/dev/null
./mkcsv-inline.sh
printf "Generating index.html... "
cat html/00* datapoints-inline.csv html/99* > public/index.html \
  && echo OK
