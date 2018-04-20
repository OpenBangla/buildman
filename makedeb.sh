#!/usr/bin/env bash
export DIST=$1
export RELPACK=$2
apt-get -y install build-essential cmake libibus-1.0-dev ninja-build curl qt5-default
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git /repo
cmake -H/repo -B/build -GNinja -DCPACK_GENERATOR=DEB
ninja package -C build
#curl --upload-file build/${RELPACK}${DIST}.deb https://transfer.sh/${RELPACK}${DIST}.deb
