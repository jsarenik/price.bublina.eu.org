#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

printf "Generating inline loglog.html... "
{
cat html/loglog/00*
cat datapoints-blocks | ./mkcsv-inline.sh
cat html/loglog/99*
} > public/loglog.html \
  && echo OK
