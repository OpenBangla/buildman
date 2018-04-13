#!/usr/bin/env bash
export DIST=$1
if [[ $DIST = "ubuntu16.04" ]]; then
    # Install Qt 5.9 for Ubuntu 16.04
    apt-get -y install software-properties-common
    add-apt-repository ppa:beineri/opt-qt591-xenial
    apt-get update -qq
    apt-get -y install qt59base qt59declarative
    source /opt/qt59/bin/qt59-env.sh
elif [[ $DIST = "ubuntu17.10" ]]; then
    apt-get update -qq
    apt-get -y install qt5-default qtdeclarative5-dev
fi
apt-get -y install build-essential cmake libibus-1.0-dev ninja-build
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git /repo
cmake -H/repo -B/build -GNinja -DCPACK_GENERATOR=DEB
ninja package -C build
