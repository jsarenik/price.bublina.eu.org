#!/bin/sh

last=$(tail -1 datapoints | grep -Eo '[0-9]+\-[0-9]{2}\-[0-9]{2}')
start=$(date -d "$last + 1 day" +%Y-%m-%d)
today=$(date +%Y-%m-%d)
TMP=$(mktemp)

wget -q -O - "https://api.coindesk.com/v1/bpi/historical/close.json\
?start=$start&end=$today" > $TMP

jq -r '.bpi | keys_unsorted[]' $TMP | while read date
do
  PRICE=$(jq ".bpi[\"$date\"]" $TMP)
  PRICE=$(printf "%.6f" $PRICE)
  echo "[new Date(\"$date\"), $PRICE],"
done | tee -a datapoints

rm $TMP

printf "Geterating price.html... "
cat html/00* datapoints html/99* > dist/price.html && echo OK
