#!/bin/sh

./update-all.sh
rsync -a --delete . singer:web/price/
