#!/usr/bin/env bash
export DIST=$1
export RELPACK=$2
export RELVER=$3
export DEPLOY=$4
dnf install -y --allowerasing @buildsys-build cmake ibus-devel qt5-qtdeclarative-devel rust cargo ninja-build
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git /repo
git -C /repo submodule update --init --recursive
cmake -H/repo -B/build -GNinja -DCPACK_GENERATOR=RPM
ninja package -C /build
if [ $DEPLOY == 1 ]; then
    echo "Deploying artifacts to transfer.sh"
    curl --upload-file /build/${RELPACK}${DIST}.rpm https://transfer.sh/
fi
