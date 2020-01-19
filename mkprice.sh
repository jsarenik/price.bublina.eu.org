#!/bin/sh

printf "Geterating price.html... "
cat html/00* datapoints html/99* > price.html && echo OK
