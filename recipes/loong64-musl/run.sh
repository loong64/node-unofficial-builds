#!/usr/bin/env bash

set -e
set -x

release_urlbase="$1"
disttype="$2"
customtag="$3"
datestring="$4"
commit="$5"
fullversion="$6"
source_url="$7"
source_urlbase="$8"
config_flags="--openssl-no-asm --partly-static"

cd /home/node

tar -xf node.tar.xz
cd "node-${fullversion}"

export CCACHE_BASEDIR="$PWD"
export CC_host="ccache gcc-13"
export CXX_host="ccache g++-13"
export CC="ccache /opt/x-tools/loongarch64-unknown-linux-musl/bin/loongarch64-unknown-linux-musl-gcc"
export CXX="ccache /opt/x-tools/loongarch64-unknown-linux-musl/bin/loongarch64-unknown-linux-musl-g++"
export CXXFLAGS="-DHWY_BROKEN_EMU128=0"

make -j$(getconf _NPROCESSORS_ONLN) binary V= \
  DESTCPU="loong64" \
  ARCH="loong64" \
  VARIATION="musl" \
  DISTTYPE="$disttype" \
  CUSTOMTAG="$customtag" \
  DATESTRING="$datestring" \
  COMMIT="$commit" \
  RELEASE_URLBASE="$release_urlbase" \
  CONFIG_FLAGS="$config_flags"

mv node-*.tar.?z /out/
