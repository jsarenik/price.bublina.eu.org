# [price.bublina.eu.org](https://price.bublina.eu.org)
Clone of the most comprehensive all-time Bitcoin price history chart.

Derived from [Zorinaq's price chart](https://bitcoin.zorinaq.com/price/).

Accessible via [Tor](https://torproject.org) from
[http://yjea…3qd.onion/](
http://yjeajli4dzdwm2lu32rkruj5safydu2utx22trkdszwulegookfvj3qd.onion/).

## Requirements

 * [jq](https://stedolan.github.io/jq/)
 * `coreutils` and `bash` will do,
   but [`busybox`](https://busybox.net/) is enough

## How it works

The script `./update-datapoints.sh` updates `datapoints` file
and should be run before anything else in order to use
the current data.

In order to update the datapoints along with all the implemented
chart variants, simply run `./update-all.sh` and find the output
in the `public` directory.

`./gen-inline.sh` generates a static `public/index.html`
file which contains all the space-efficient CSV values
inside itself.

`./gen-hafuch.sh` generates the reversed chart which shows
how much BTC can be bought by USD.
