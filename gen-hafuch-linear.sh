#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

printf "Generating inline hafuch-linear.html... "
{
cat html/hafuch-linear/00*
cat datapoints | ./hafuch.sh
cat html/hafuch-linear/99*
} > public/hafuch-linear.html \
  && echo OK
