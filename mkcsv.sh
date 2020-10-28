#!/bin/sh

echo "Date,USD"
cat datapoints | tr -d '[a-zA-Z"\[()\]' | cut -d, -f1-2 | cut -b2-
