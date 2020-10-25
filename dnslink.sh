#!/bin/sh

NS=$(dig -t NS +short $1)
dig +short TXT _dnslink.$1 @$NS \
  | sed -E 's/"dnslink=(.*)"/\1/g'
