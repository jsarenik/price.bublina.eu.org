#!/bin/sh

safecat() (
  tmp=$(mktemp)
  cat > $tmp
  chmod a+r $tmp
  test -s $tmp && cp -u $tmp ${1:-/dev/null}
  rm -f $tmp
)

curl -s \
  "https://pricey.pages.dev/days.json" \
  | safecat public/days.json
