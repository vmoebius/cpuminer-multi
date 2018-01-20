#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#

FROM ubuntu:16.04
MAINTAINER	Volker Moebius <vmoebius@gmail.com>

RUN	apt-get update -qq

RUN	apt-get install -qqy automake
RUN	apt-get install -qqy libcurl4-openssl-dev
RUN	apt-get install -qqy libssl-dev
RUN	apt-get install -qqy gcc
RUN	apt-get install -qqy make

RUN mkdir -p /usr/src/miner
COPY . /usr/src/miner
WORKDIR /usr/src/miner
RUN ./autogen.sh
RUN ./configure CFLAGS="-O3"
RUN make

ENTRYPOINT	["/usr/src/miner/minerd"]
