#!/bin/sh

export TZ=UTC
a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR
last=$(tail -1 datapoints | grep -Eo '[0-9]+\-[0-9]{2}\-[0-9]{2}')
today=$(date +%Y-%m-%d)
TMP=$(mktemp)
lines=$(wc -l datapoints-blocks | cut -d" " -f1)

wget -q -O - "https://api.coindesk.com/v1/bpi/historical/close.json\
?start=$last&end=$today" > $TMP

echo "Updating datapoints..."
jq -r '.bpi | keys_unsorted[]' $TMP | while read date
do
  PRICE=$(jq ".bpi[\"$date\"]" $TMP)
  PRICE=$(printf "%.6f" $PRICE)
  echo "[new Date(\"$date\"), $PRICE],"
done | sed 1d \
  | tee -a datapoints \
  | grep . && echo ...datapoints update done. || EXIT=1

echo "Updating datapoints-blocks..."
sed -n "$lines,\$p" datapoints | sed 1d | ./mkcsv-datapoints.sh \
  | tee -a datapoints-blocks | grep . && echo ...datapoints-blocks updated.

rm $TMP
test "$EXIT" = "1" && { echo No new data found. Exiting.; exit 1; }
