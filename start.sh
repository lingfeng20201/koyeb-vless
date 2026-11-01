#!/bin/sh
set -e
echo "[start] launching xray on 127.0.0.1:10000"
/usr/local/bin/xray -c /etc/xray/config.json &
sleep 1
nginx -c /etc/nginx/nginx.conf -g "daemon off;"
