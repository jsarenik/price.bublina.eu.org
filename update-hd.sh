#!/bin/sh

./update-all.sh
rsync -a --delete . hd4:web/price/
