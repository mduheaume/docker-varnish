#!/bin/bash

echo "vcl 4.0;

backend default {
    .host = \"`getent hosts ${VARNISH_BACKEND_HOST} | awk '{ print $1 }'`\";
    .port = \"${VARNISH_BACKEND_PORT}\";
    .first_byte_timeout = 300s;
}

sub vcl_recv {
     unset req.http.Cookie;
}

sub vcl_deliver {
         if ( obj.hits > 0 )
        {
                set resp.http.X-Cache = \"HIT\";
        }
        else
        {
                set resp.http.X-Cache = \"MISS\";
        }
        set resp.http.X-Cache-Hits = obj.hits;
}

" > /etc/varnish/default.vcl

varnishd -F -f /etc/varnish/default.vcl -s malloc,100M -a 0.0.0.0:${VARNISH_PORT}
