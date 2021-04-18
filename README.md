# [price.bublina.eu.org](https://price.bublina.eu.org)
The most comprehensive all-time Bitcoin price history chart.

Originally from https://bitcoin.zorinaq.com/price/

Accessible via [Tor](https://torproject.org) from
http://yjeajli4dzdwm2lu32rkruj5safydu2utx22trkdszwulegookfvj3qd.onion/

## Requirements

 * [jq](https://stedolan.github.io/jq/)
 * coreutils and bash will do,
   but [busybox](https://busybox.net/) is enough

## How it works

The script `./update.sh` generates a static `public/index.html`
file which resembles the original.

The script `./update-csv-inline.sh` is the latest addition.
It generates the `public/index.html` which is smaller compared
to the one generated using the original way.
