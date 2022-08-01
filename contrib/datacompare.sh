#!/bin/sh
#
# This script compares the datapoints at upstream bitcoin.zorinaq.com/price
# with datapoints kept in this git repository

wget -qO - bitcoin.zorinaq.com/price \
  | sed -n '/^\[new/,/^\],/p' | sed '$d' \
  | tr '/' '-' | diff -u - datapoints
