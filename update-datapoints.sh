#!/bin/sh

export TZ=UTC
a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR
last=$(tail -1 datapoints | grep -Eo '[0-9]+\-[0-9]{2}\-[0-9]{2}')
start=2022-05-17
today=$(date +%Y-%m-%d)
TMP=$(mktemp)
lines=$(wc -l datapoints-blocks | cut -d" " -f1)

fresh() {
cat > datapoints <<EOF
[new Date("2009-01-03"), 0.000001],
[new Date("2009-10-04"), 0.000001],
EOF
}

URL="https://www.coindesk.com/pf/api/v3/content/fetch/chart-api"
query=$({
cat <<EOF
{\
"end_date":"${today}T00:00",\
"iso":"BTC",\
"ohlc":false,\
"start_date":"${start}T00:00"\
}
EOF
} | tr -d "\n" | jq -sRr @uri)
end="&_website=coindesk"

busybox wget -q -O - "${URL}?query=${query}${end}" > $TMP

echo "Updating datapoints..."
{ jq -r '.entries[] | (.[0] | tostring) + " " + (.[1] | tostring)' $TMP; } \
  | while read ts price
do
  date=$(date +%Y-%m-%d -d "@${ts%%???}")
  printf '[new Date("%s"), %.6f],\n' $date $price
done \
  | grep . > /tmp/datapoints-$$ && echo ...datapoints update done. || EXIT=1

rm $TMP

sed -n "/^\[new Date(\"$last.*/,\$p" /tmp/datapoints-$$ \
  | sed 1d | tee -a datapoints
rm /tmp/datapoints-$$

test "$EXIT" = "1" && { echo No new data found. Exiting.; exit 1; }

echo "Updating datapoints-blocks..."
sed -n "$lines,\$p" datapoints | sed 1d | ./mkcsv-datapoints.sh \
  | tee -a $dpf | grep . && echo ...datapoints-blocks updated.

# Check if there are more than one lines in datapoints-blocks
# starting with "^1,"
LINES=$(grep -c '^1,' datapoints-blocks)
test "$LINES" = "1" || {
  # reset last additions
  git checkout datapoints datapoints-blocks
}
