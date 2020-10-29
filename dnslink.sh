#!/bin/sh
#
# Usage: dnslink.sh <domain> [parent_in_NS]
#
# Example: dnslink.sh price.bublina.eu.org
# Example: dnslink.sh deep.sub.dom.bublina.eu.org bublina.eu.org

PARENT=${2:-${1#*.}}
NS=$(dig -t NS +short $PARENT)
dig +short TXT _dnslink.$1 @$NS \
  | sed -E 's/"dnslink=(.*)"/\1/g'
