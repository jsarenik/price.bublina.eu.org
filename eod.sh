instr=BTIUSF-USD
marke=cdifti

safecat() (
  tmp=$(mktemp)
  cat > $tmp
  chmod a+r $tmp
  test -s $tmp && cp -u $tmp ${1:-/dev/null}
  rm -f $tmp
)

grep -v "^#" eod-pairs.txt | while read marke instr rest
do
curl -s "https://data-api.cryptocompare.com/index/cc/v1/historical/days/eod?market=$marke&instrument=$instr&limit=50&aggregate=1&fill=true&apply_mapping=true&response_format=JSON" \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en-US,en;q=0.9,sk;q=0.8,cs;q=0.7' \
  -H 'Authorization: Bearer undefined' \
  -H 'Connection: keep-alive' \
  -H 'DNT: 1' \
  -H 'Origin: https://indices.coindesk.com' \
  -H 'Referer: https://indices.coindesk.com/' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: cross-site' \
  -H 'User-Agent: Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua: "Not/A)Brand";v="8", "Chromium";v="126"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Chromium OS"' \
  | safecat /tmp/$instr
  echo /tmp/$instr
done
