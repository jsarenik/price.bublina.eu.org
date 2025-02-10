#!/bin/sh
#
# This script compares the lynx dump of the original
# (bitcoin.zorinaq.com/price) text with the text on
# price.bublina.eu.org

llynx() {
  wget -qO - $1 \
    | sed '1,/^This is/d;s/<[^>]\+>//g' \
    | cat -s
}

llynx https://bitcoin.zorinaq.com/price/ > contrib/wget-dump
llynx https://pricey.pages.dev | diff -u contrib/wget-dump -
