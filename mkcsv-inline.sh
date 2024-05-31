#!/bin/sh

{ ./mkcsv.sh | tr -d '[ a-zA-Z"\[()\]]'; } \
  | sed 's/$/\\n/' | tr -d '\n' | sed 's/.*/"&"/;s/\n"$/"/'
echo ,
