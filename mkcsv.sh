#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

FILE=${1:-datapoints}
cat "$FILE" | tr -d '[a-zA-Z"\[()\]' | cut -d, -f1-2 | cut -b2-
