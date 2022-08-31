#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

tr -d '[,a-zA-Z"\[()\]' | cut -d, -f1-2 | cut -b2- \
  | while read date price
do
  BLOCK=$(./grepdate.sh "$date") \
    && printf "%s, %s\n" "${BLOCK:-900000}" "$price"
done
