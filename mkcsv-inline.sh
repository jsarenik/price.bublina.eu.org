#!/bin/sh

{
printf '"Date,value in USD\\n" +'
cat datapoints | tr -d '[ a-zA-Z"\[()\]' | sed 's/,$//;s/.*/"&\\n" +/'
} | sed '$s/\\n\" +$/\"/' | tr -d '\n' | sed 's/\" +\"//g'; echo ,;
