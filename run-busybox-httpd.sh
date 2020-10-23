#!/bin/sh

PORT=${1:-"8080"}
echo Starting to serve at http://localhost:$PORT
/busybox/httpd -f -p $PORT -h $PWD/public
