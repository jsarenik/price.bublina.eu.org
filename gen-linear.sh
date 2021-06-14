#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

VARIANT=linear
test -d html/$VARIANT || exit 1
printf "Generating inline $VARIANT.html... "
{
cat html/$VARIANT/00*
./mkcsv-inline.sh
cat html/$VARIANT/99*
} > public/$VARIANT.html \
  && echo OK
