#!/bin/sh

./update.sh
git gc
rsync -av --delete . hd:web/price/
