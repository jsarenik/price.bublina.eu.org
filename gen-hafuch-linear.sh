#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

printf "Generating inline hafuch-linear.html... "
{
cat html/hafuch-linear/00*
cat html/hafuch/02*
cat html/03*
cat datapoints | ./hafuch.sh
cat html/hafuch-linear/90*
cat html/91*
cat html/hafuch-linear/99*
} > public/hafuch-linear.html \
  && echo OK
