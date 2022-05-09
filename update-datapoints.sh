#!/bin/sh

export TZ=UTC
a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR
last=$(tail -1 datapoints | grep -Eo '[0-9]+\-[0-9]{2}\-[0-9]{2}')
start=$(date -d "$last + 1 day" +%Y-%m-%d)
today=$(date +%Y-%m-%d)
TMP=$(mktemp)

wget -q -O - "https://api.coindesk.com/v1/bpi/historical/close.json\
?start=$start&end=$today" > $TMP

echo "Updating datapoints..."
jq -r '.bpi | keys_unsorted[]' $TMP | while read date
do
  PRICE=$(jq ".bpi[\"$date\"]" $TMP)
  PRICE=$(printf "%.6f" $PRICE)
  echo "[new Date(\"$date\"), $PRICE],"
done | tee -a datapoints | grep . && echo ...datapoints update done. || EXIT=1

echo "Updating datapoints-blocks..."
N=$(sed -n "/$start/=" datapoints)
sed -n "$N,\$p" datapoints | ./mkcsv-datapoints.sh \
  | tee -a datapoints-blocks | grep . && echo ...datapoints-blocks updated. \
  || EXIT=1

rm $TMP
test "$EXIT" = "1" && { echo No new data found. Exiting.; exit 1; }
