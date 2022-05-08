#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

tr -d '[a-zA-Z"\[()\]' | cut -d, -f1-2 | sed 's/^\s\+//'
