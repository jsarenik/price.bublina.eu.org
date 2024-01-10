#!/bin/sh
#
# This script compares the datapoints at upstream bitcoin.zorinaq.com/price
# with datapoints kept in this git repository

cat <<EOF
[new Date("2009-01-03"), 0.000001],
[new Date("2009-10-04"), 0.000001],
EOF
wget -qO - bitcoin.zorinaq.com/price \
  | sed -n '/^\[new/,/^\],/p' | sed '$d' \
  | tr '/' '-'
