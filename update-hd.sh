#!/bin/sh

./update-csv-inline.sh
rsync -a --delete . hd4:web/price/
