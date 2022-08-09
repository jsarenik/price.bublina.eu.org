#!/bin/sh
#
# This script compares the lynx dump of the original
# (bitcoin.zorinaq.com/price) text with the text on
# price.bublina.eu.org

lynx -dump price.bublina.eu.org | diff -u contrib/lynx-dump - \
  | ${PAGER:-less}
