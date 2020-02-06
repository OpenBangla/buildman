#!/usr/bin/env bash
export DIST=$1
export RELPACK=$2
export RELVER=$3
export DEPLOY=$4
dnf install -y --allowerasing @buildsys-build cmake ibus-devel qt5-qtdeclarative-devel rust cargo ninja-build
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git /src
git -C /src submodule update --init --recursive
cmake -H/src -B/build -GNinja -DCPACK_GENERATOR=RPM
ninja package -C /build
if [ $DEPLOY == true ]; then
    mkdir $GITHUB_WORKSPACE/artifact
    mv /build/*.rpm $GITHUB_WORKSPACE/artifact/
fi
