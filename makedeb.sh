#! /bin/bash
apt-get update
apt-get -y install git build-essential cmake libibus-1.0-dev qt5-default qtdeclarative5-dev ninja-build
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git /repo
cmake -H/repo -B/build -GNinja -DCPACK_GENERATOR=DEB
ninja package -C build
