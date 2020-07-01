#!/bin/sh

./update.sh
git gc
rsync -av --delete . hd4:web/price/
