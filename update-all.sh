#!/bin/sh
#
# Meant to be run by crontab: 10 5 * * * ssh host
# where ~/.ssh/authorized_keys on host contain something like
# command="~/web/bitcoin.zorinaq.com/update-all.sh" ssh-ed25519 AAAAC3Nz...

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit
date
./update-datapoints.sh
./gen-inline.sh
./gen-inline-loglog.sh
./gen-hafuch.sh
./gen-hafuch-linear.sh
./gen-variant.sh monthly
./gen-variant.sh yearly
./gen-variant.sh yearly-low
cp public/yearly-low.html public/low.html
./gen-variant.sh monthly-low
./gen-linear.sh
./update-headers.sh > public/_headers

test "$RUN_BROTLI" = "1" && {
  echo Running brotli
  which brotli
  brotli public/*html
} || echo "Brotli not run"
