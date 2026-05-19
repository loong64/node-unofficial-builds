FROM ubuntu:24.04

ARG GID=1000
ARG UID=1000

RUN groupadd --gid $GID node \
    && useradd --gid $GID --uid $UID --create-home --shell /bin/bash node

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y \
         git \
         g++-13 \
         curl \
         make \
         python3.10 \
         ccache \
         xz-utils

RUN rm -f /usr/bin/python3
RUN ln -s /usr/bin/python3.10 /usr/bin/python3

RUN mkdir -p /opt/x-tools \
    && curl -L https://github.com/loong64/cross-tools/releases/download/20260519/x86_64-cross-tools-loongarch64-unknown-linux-musl-stable.tar.xz | tar xJf - -C /opt/x-tools

COPY --chown=node:node run.sh /home/node/run.sh

VOLUME /home/node/.ccache
VOLUME /out
VOLUME /home/node/node.tar.xz

USER node

ENTRYPOINT [ "/home/node/run.sh" ]
