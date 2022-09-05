#!/bin/sh

set -x
find ${1:-.} -type f -size +1400c \
    -regex ".*\.\(css\|html\|js\|json\|svg\|xml\|map\)$" \
    -exec brotli -f --best {} \+ \
    -exec gzip -f --best -k {} \+
