# https://qiita.com/keach/items/35b2bc9ce14484609f50

FROM ubuntu:16.04

RUN mkdir /home/bitcoind

RUN apt-get update
RUN apt-get -y install git-all
RUN apt-get -y install autoconf build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
RUN apt-get -y install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
RUN apt-get install --yes software-properties-common
RUN add-apt-repository --yes ppa:bitcoin/bitcoin
RUN apt-get -y update

RUN apt-get -y install libdb4.8-dev libdb4.8++-dev
RUN apt-get -y install libminiupnpc-dev
RUN apt-get -y install libzmq3-dev

WORKDIR /home/bitcoind/


RUN git clone https://github.com/bitcoin/bitcoin.git
WORKDIR /home/bitcoind/bitcoin
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

ADD startup.sh home/bitcoind

CMD ["sh", "/home/bitcoind/startup.sh"]
