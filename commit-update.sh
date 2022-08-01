#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || true; pwd)
cd $BINDIR
git pull
./update-all.sh
git commit -m "Update datapoints" datapoints*
git push
