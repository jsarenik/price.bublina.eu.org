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

The script `./update-datapoints.sh` updates `datapoints` and
should be run before anything else in order to use current data.


`./gen-inline.sh` generates a static `public/index.html`
file which contains all the space-efficient CSV values
inside itself.

`./gen-hafuch.sh` generates the reversed chart which shows
how much BTC can be bought by USD.
