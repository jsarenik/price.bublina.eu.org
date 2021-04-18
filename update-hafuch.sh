#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR

./update.sh
printf "Generating inline hafuch.html... "
{
cat html/hafuch/00*
./hafuch.sh
cat html/hafuch/99*
} > public/hafuch.html \
  && echo OK
