#!/bin/sh

{ ./mkcsv.sh "$1" | tr -d '[ a-zA-Z"\[()\]]'; } \
  | sed 's/$/\\n/' | tr -d '\n' | sed 's/.*/"&"/;s/\\n"$/"/'
echo ,
