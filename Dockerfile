FROM ubuntu:16.04

MAINTAINER Mike du Heaume <mduheaume@strathcom.com>

RUN apt-get update && DEBIAN_FRONTEND='noninteractive' apt-get install -y \
        varnish \
    && rm -rf /var/lib/apt/lists/*

ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "sh", "-c", "/run.sh" ]