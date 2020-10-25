#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR
FILE=datapoints.csv
last=$(tail -1 $FILE | grep -Eo '[0-9]+\-[0-9]{2}\-[0-9]{2}')
start=$(date -d "$last + 1 day" +%Y-%m-%d)
today=$(date +%Y-%m-%d)
TMP=$(mktemp)

wget -q -O - "https://api.coindesk.com/v1/bpi/historical/close.json\
?start=$start&end=$today" > $TMP

test -r $FILE || echo "Date, value in USD" > $FILE

jq -r '.bpi | keys_unsorted[]' $TMP | while read date
do
  PRICE=$(jq ".bpi[\"$date\"]" $TMP)
  PRICE=$(printf "%.6f" $PRICE)
  echo "$date, $PRICE"
done | tee -a $FILE

rm $TMP

printf "Geterating index.html... "
cat html/00* html/3* html/99* > public/index.html && cp $FILE public && echo OK
