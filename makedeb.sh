#!/usr/bin/env bash
RELEASE_STUB=$1
RELEASE_FILENAME="${RELEASE_STUB}${DIST}.deb"
apt-get -y install build-essential cmake libibus-1.0-dev qt5-default rustc cargo ninja-build curl
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git /src
git -C /src submodule update --init --recursive
cmake -H/src -B/build -GNinja -DCPACK_GENERATOR=DEB
ninja package -C /build
if [ $DEPLOY == true ]; then
    mv /build/${RELEASE_FILENAME} ${DEPLOY_PATH}/
fi

