#!/bin/sh
#
# Usage example: ./grepdate.sh 2009-01-04

# Setting TZ because the Coindesk BPI data are
# are updated on the local midnight there.
export TZ=America/Los_Angeles
SECS=$(date +%s -d "$1")

getit() {
  curl -sSL "https://blockchain.info/blocks/${SECS}000?format=json" \
    | jq ".[] | (select(.time <= $SECS)) | .height" | head -1
}

getit $SECS | grep .
