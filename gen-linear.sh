#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

VARIANT=linear
test -d html/$VARIANT || exit 1
printf "Generating inline $VARIANT.html... "
{
cat html/$VARIANT/00*
cat html/02* html/03*
cat datapoints | ./mkcsv-inline.sh
cat html/$VARIANT/90*
cat html/91*
cat html/$VARIANT/99*
} > public/$VARIANT.html \
  && echo OK
