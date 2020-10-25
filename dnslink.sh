#!/bin/sh

dig +short TXT _dnslink.${1:-"bublina.eu.org"} | sed -E 's/"dnslink=(.*)"/\1/g'

