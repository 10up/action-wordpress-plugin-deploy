FROM debian:stable-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
	&& apt-get install -y subversion rsync git zip \
	&& apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
