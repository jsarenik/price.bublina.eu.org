#!/bin/sh

{
echo "\"Date, value in USD\\\n\""
cat datapoints | tr -d '[a-zA-Z"\[()\]' | cut -d, -f1-2 | cut -b2- \
  | while read line; do echo "\"$line\\\n\""; done
} > datapoints-inline.csv
