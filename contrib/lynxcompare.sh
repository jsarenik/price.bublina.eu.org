#!/bin/sh
#
# This script compares the lynx dump of the original
# (bitcoin.zorinaq.com/price) text with the text on
# price.bublina.eu.org

type lynx || exit 1
lynx -dump https://bitcoin.zorinaq.com/price/ > contrib/lynx-dump
lynx -dump pricey.pages.dev | diff -u contrib/lynx-dump -
