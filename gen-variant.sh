#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

VARIANT=${1:-"yearly"}
test -d html/$VARIANT || exit 1
printf "Generating inline $VARIANT.html... "
"./gen-datapoints-$VARIANT.sh"
{
cat html/$VARIANT/00*
./mkcsv-inline.sh "datapoints-$VARIANT"
cat html/$VARIANT/99*
} > public/$VARIANT.html \
  && echo OK
