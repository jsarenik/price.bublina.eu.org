#!/bin/sh

genone() {
  cat <<EOF
/$1
  Onion-Location: http://yjeajli4dzdwm2lu32rkruj5safydu2utx22trkdszwulegookfvj3qd.onion/$1

EOF
}

# One for root with no file
genone

cd public
for f in *.html
do
  genone "${f%.html}"
done
