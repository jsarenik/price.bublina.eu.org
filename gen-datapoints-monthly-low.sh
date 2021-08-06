#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

YEARNOW=$(date +%Y)
for year in $(seq 2009 $YEARNOW)
do
for month in $(seq -w 01 12)
do
  grep -- "$year-$month-..\"" datapoints | sort -rn -t',' -k2 | tail -1
done
done
