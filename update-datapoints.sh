#!/bin/sh

export TZ=UTC
a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR
last=$(tail -1 datapoints | grep -Eo '[0-9]+\-[0-9]{2}\-[0-9]{2}')
start=2022-01-01
today=$(date +%Y-%m-%d)
TMP=$(mktemp)
lines=$(wc -l datapoints-blocks | cut -d" " -f1)

fresh() {
cat > datapoints <<EOF
[new Date("2009-01-03"), 0.000001],
[new Date("2009-10-04"), 0.000001],
EOF
}

wget -q -O - "https://production.api.coindesk.com/v2/price/values/BTC\
?start_date=${start}T00:00&end_date=${today}T00:00&ohlc=false" > $TMP

echo "Updating datapoints..."
{ jq -r '.data.entries[]' $TMP \
  | tr -d '\n' \
  | tr '\[' '\n' \
  | tr -d '[,\]]'; } | sed 1d | while read ts price
do
  date=$(date +%Y-%m-%d -d "@${ts%%000}")
  echo "[new Date(\"${date}\"), $(echo $price | sed -E 's/^([0-9]+\.[0-9]{6}).*/\1/')],"
done | sed 1d \
  | grep . > /tmp/datapoints-$$ && echo ...datapoints update done. || EXIT=1

rm $TMP

sed -n "/^\[new Date(\"$last.*/,\$p" /tmp/datapoints-$$ \
  | sed 1d | tee -a datapoints
rm /tmp/datapoints-$$

test "$EXIT" = "1" && { echo No new data found. Exiting.; exit 1; }

echo "Updating datapoints-blocks..."
sed -n "$lines,\$p" datapoints | sed 1d | ./mkcsv-datapoints.sh \
  | tee -a datapoints-blocks | grep . && echo ...datapoints-blocks updated.
