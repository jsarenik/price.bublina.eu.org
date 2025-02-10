#!/bin/sh
#
# This script compares the lynx dump of the original
# (bitcoin.zorinaq.com/price) text with the text on
# price.bublina.eu.org

myproc() {
  sed '1,/^This is/d;s/<[^>]\+>//g' \
    | cat -s
}

llynx() {
  wget -qO - $1 | myproc
}

llynx https://bitcoin.zorinaq.com/price/ > contrib/wget-dump
cat public/index.html | myproc | diff -u contrib/wget-dump -
