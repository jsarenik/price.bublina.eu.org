# price.bublina.eu.org
The most comprehensive all-time Bitcoin price history chart.
Originally from https://bitcoin.zorinaq.com/price/

## Requirements

 * [jq](https://stedolan.github.io/jq/)
 * coreutils and bash will do,
   but [busybox](https://busybox.net/) is enough
 * `update-ipfs.sh` script requires
   [dig](https://bind.isc.org/doc/arm/9.11/man.dig.html)

## How it works

The script `./update.sh` generates a static `public/index.html`
file which resembles the original.

The script `./update-csv-inline.sh` is the latest addition.
It generates the `public/index.html` which is smaller compared
to the one generated using the original way.

To update IPFS, `./update-ipfs.sh` script can be used.

### IPFS deployment details

Just a note that current price.bublina.eu.org is implemented
thanks to Cloudflare's IPFS nodes, so the domain is `CNAME`d
to `cloudflare-ipfs.com` and the `TXT` record
`_dnslink.price.bublina.eu.org` is kept up to date by a cron job:

```
10 9 * * * $HOME/web/bitcoin.zorinaq.com/update-all.sh
```
