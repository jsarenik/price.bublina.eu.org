#!/bin/sh

./update-csv-inline.sh
./update-hafuch.sh
rsync -a --delete . hd4:web/price/
