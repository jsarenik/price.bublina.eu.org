#!/bin/sh

./update.sh
./update-csv-inline.sh
git gc
rsync -av --delete . hd4:web/price/
