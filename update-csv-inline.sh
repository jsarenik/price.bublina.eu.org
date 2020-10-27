#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR

./update.sh >/dev/null
printf "Generating index.html... "
{
cat html/00*
./mkcsv-inline.sh
cat html/99*
} > public/index.html \
  && echo OK
