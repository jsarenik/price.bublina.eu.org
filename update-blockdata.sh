#!/bin/sh

export TZ=UTC
a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR
lines=$(wc -l datapoints-blocks | cut -d" " -f1)

echo "Updating datapoints-blocks..."
sed -n "$lines,\$p" datapoints | sed 1d | ./mkcsv-datapoints.sh | sed '$d' \
  | tee -a datapoints-blocks | grep . && echo ...datapoints-blocks updated.

# Check if there are more than one lines in datapoints-blocks
# starting with "^1,"
LINES=$(grep -c '^1,' datapoints-blocks)
test "$LINES" = "1" || {
  # reset last additions
  git checkout datapoints datapoints-blocks
}
