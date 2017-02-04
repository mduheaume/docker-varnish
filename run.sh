#!/bin/bash

echo "vcl 4.0;

# Default backend definition. Set this to point to your content server.
backend default {
    .host = \"`getent hosts ${VARNISH_BACKEND_HOST} | awk '{ print $1 }'`\";
    .port = \"${VARNISH_BACKEND_PORT}\";
}
" > /etc/varnish/default.vcl

varnishd -F -f /etc/varnish/default.vcl -s malloc,100M -a 0.0.0.0:${VARNISH_PORT}
