#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

printf "Generating inline index.html... "
{
cat html/00*
./mkcsv-inline.sh
cat html/99*
} > public/index.html \
  && echo OK
