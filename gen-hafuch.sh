#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

printf "Generating inline hafuch.html... "
{
cat html/hafuch/0*
cat html/03*
cat datapoints | ./hafuch.sh
cat html/hafuch/90*
cat html/91*
cat html/hafuch/99*
} > public/hafuch.html \
  && echo OK
