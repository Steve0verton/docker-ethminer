FROM nvidia/cuda:11.4.2-runtime-ubuntu20.04

WORKDIR /tmp

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y wget software-properties-common

RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apt-get update
RUN apt-get install -y ethereum

RUN rm -rf /tmp/*
RUN useradd -ms /bin/bash ethminer
USER ethminer

WORKDIR /home/ethminer

RUN wget -O ethminer.tar.gz https://github.com/ethereum-mining/ethminer/releases/download/v0.18.0/ethminer-0.18.0-cuda-9-linux-x86_64.tar.gz
RUN tar xzf ethminer.tar.gz
RUN rm ethminer.tar.gz

ENV PATH="/home/ethminer/bin:${PATH}"
