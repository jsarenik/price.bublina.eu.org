#!/bin/sh
#
# Meant to be run by crontab: 10 5 * * * ssh host
# where ~/.ssh/authorized_keys on host contain something like
# command="~/web/bitcoin.zorinaq.com/update-all.sh" ssh-ed25519 AAAAC3Nz...

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit
./update-datapoints.sh
./gen-inline.sh
./gen-hafuch.sh
./gen-variant.sh monthly
./gen-variant.sh yearly
