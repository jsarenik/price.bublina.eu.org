#!/bin/sh

{ ./mkcsv.sh | head -1; ./mkcsv.sh | sed '1d' | tr -d '[ a-zA-Z"\[()\]'; } \
  | sed 's/$/\\n/' | tr -d '\n' | sed 's/.*/"&"/;s/\\n"$/"/'
echo ,
