#!/bin/sh

type bc >/dev/null 2>&1 && BC=bc || {
  test -x $PWD/busybox-x86_64 || {
    wget --quiet \
      https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64
    chmod a+x busybox-x86_64
  }
  BC="$PWD/busybox-x86_64 bc"
}

{
{ 
./mkcsv.sh | cut -d, -f1 > /tmp/dates$$
{
  echo "scale=8;"
  ./mkcsv.sh | cut -d, -f2 | while read line
  do
    echo "a=$line; 1000/a;"
  done
} | $BC | while read line;
  do printf "%.8f\n" $line; done \
    | paste -d, /tmp/dates$$ -
rm /tmp/dates$$
} | tr -d '[ a-zA-Z"\[()\]]'; } \
  | sed 's/$/\\n/' | tr -d '\n' | sed 's/.*/"&"/;s/\\n"$/"/'
echo ,
