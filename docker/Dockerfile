FROM debian:stretch
LABEL maintainer="DFTz Developers <dev@dftz.org>"
LABEL description="Dockerised DFTzCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
