#!/bin/sh

test -n "$DEBUG" && set -x

SPFTRC=$HOME/.spf-toolsrc
# Read PINATA
test -r $SPFTRC && . $SPFTRC
test -n "$PINATA" || { echo "$0: PINATA not set in $SPFTRC! Exiting." >&2; exit 1; }

apicmd() {
  APIURL="https://api.pinata.cloud"
  CMD=${1:-'GET'}
  test -n "$1" && shift
  REST=${1:-'/zones'}
  test -n "$1" && shift
  curl -X $CMD ${APIURL}${REST} \
    -s \
    -H "Authorization: Bearer $PINATA" \
    "$@"
}

pinatapin() {
  test "$PINATA" = "" && return
  printf "Pinata: pinning $1... "
  echo "{ \"hashToPin\": \"$1\" }" \
    | apicmd POST /pinning/pinByHash \
        --data-binary @- \
        -H "Content-Type: application/json" \
    | grep -q prechecking \
    && echo "OK" || echo "error"
}

pinataunpin() {
  test "$PINATA" = "" && return
  printf "Pinata: unpining $1... "
  apicmd DELETE /pinning/unpin/$1 && echo
}

pinatatotal() {
  apicmd GET /data/userPinnedDataTotal
}

pinatapin $1
pinataunpin $2
