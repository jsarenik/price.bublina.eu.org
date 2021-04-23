#!/bin/sh

./update-datapoints.sh
./gen-inline.sh
./gen-hafuch.sh
rsync -a --delete . hd4:web/price/
