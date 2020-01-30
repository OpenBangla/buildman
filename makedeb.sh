#!/usr/bin/env bash
export DIST=$1
export RELPACK=$2
export RELVER=$3
export DEPLOY=$4
apt-get -y install build-essential cmake libibus-1.0-dev qt5-default rustc cargo ninja-build curl
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git /src
git -C /src submodule update --init --recursive
cmake -H/src -B/build -GNinja -DCPACK_GENERATOR=DEB
ninja package -C /build
if [ $DEPLOY == true ]; then
    echo "Deploying artifacts to transfer.sh"
    curl --upload-file /build/${RELPACK}${DIST}.deb https://transfer.sh/
fi
