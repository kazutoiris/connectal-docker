FROM ubuntu:22.04

LABEL maintainer="kazutoiris<78157415+kazutoiris@users.noreply.github.com>"

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -y tzdata vim curl wget git iverilog tcl-dev libgmp10 strace \
    build-essential jq python3 python3-ply python3-gevent

WORKDIR /root

# download latest release from https://github.com/B-Lang-org/bsc/releases
ENV BSC_VERSION=2023.01

RUN wget https://github.com/B-Lang-org/bsc/releases/download/${BSC_VERSION}/bsc-${BSC_VERSION}-ubuntu-22.04.tar.gz && \
    tar -xzf bsc-${BSC_VERSION}-ubuntu-22.04.tar.gz && \
    mv bsc-${BSC_VERSION}-ubuntu-22.04 /opt/bsc && \
    rm bsc-${BSC_VERSION}-ubuntu-22.04.tar.gz

ENV PATH="${PATH}:/opt/bsc/bin"
ENV BLUESPECDIR="/opt/bsc/lib"

RUN echo "export PATH=${PATH}" >> ~/.bashrc && \
    echo "export BLUESPECDIR=${BLUESPECDIR}" >> ~/.bashrc

# install bsc-contrib
RUN git clone --recursive https://github.com/B-Lang-org/bsc-contrib /tmp/bsc-contrib && \
    cd /tmp/bsc-contrib && \
    make PREFIX=/opt/bsc install && \
    rm -rf /tmp/bsc-contrib

# install connectal
RUN git clone --recursive https://github.com/cambridgehackers/connectal /opt/connectal && \
    cd /opt/connectal && \
    sed -i 's/python-ply python-gevent//g' Makefile && \
    sed -i 's/char fname\[128\]/char fname\[512\]/g' /opt/connectal/cpp/portal.c && \
    make install-dependences

# install bsvbuild.sh
RUN wget https://github.com/WangXuan95/BSV_Tutorial_cn/raw/main/bsvbuild.sh && \
    chmod +x bsvbuild.sh && \
    mv bsvbuild.sh /opt/bsc/bin

RUN useradd -ms /bin/bash ubuntu
USER ubuntu

CMD [ "bash" ]
