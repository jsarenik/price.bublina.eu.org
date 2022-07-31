#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

printf "Generating inline index.html... "
{
cat html/00*
cat html/02* html/03*
cat datapoints | ./mkcsv-inline.sh
cat html/9*
} > public/index.html \
  && echo OK
