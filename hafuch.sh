#!/bin/sh

{
{ 
./mkcsv.sh | cut -d, -f1 > /tmp/dates$$
{
  echo "scale=8;"
  ./mkcsv.sh | cut -d, -f2 | while read line
  do
    echo "a=$line; 1000/a;"
  done
} | bc | while read line;
  do printf "%.8f\n" $line; done \
    | paste -d, /tmp/dates$$ -
rm /tmp/dates$$
} | tr -d '[ a-zA-Z"\[()\]]'; } \
  | sed 's/$/\\n/' | tr -d '\n' | sed 's/.*/"&"/;s/\\n"$/"/'
echo ,
