#!/bin/sh

./update-all.sh
git commit -m "Update datapoints" datapoints*
git push
