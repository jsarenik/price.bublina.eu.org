#!/bin/sh

genone() {
  cat <<EOF
/${1%.html}
  Onion-Location: http://http.price.bublina.eu.org/$1

EOF
}

# One for root with no file
genone

cd public
for f in *.html
do
  genone "$f"
done
