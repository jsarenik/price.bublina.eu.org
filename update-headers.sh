#!/bin/sh

genone() {
  cat <<EOF
/${1%.html}
  Onion-Location: http://76fzz7gro2z6so3uadhyaxtijhdna3uuxyr3tsa7at33jvk343kq7cqd.onion/$1

EOF
}

# One for root with no file
genone

cd public
for f in *.html
do
  genone "$f"
done
