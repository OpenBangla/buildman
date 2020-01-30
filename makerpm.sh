#!/usr/bin/env bash
export DIST=$1
export RELPACK=$2
export DEPLOY=$3
dnf install -y @buildsys-build cmake qt5-qtdeclarative-devel ibus-devel ninja-build
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git /repo
cmake -H/repo -B/build -GNinja -DCPACK_GENERATOR=RPM
ninja package -C build
if [ $DEPLOY == 1 ]; then
    echo "Deploying artifacts to transfer.sh"
    curl --upload-file build/${RELPACK}${DIST}.rpm https://transfer.sh/${RELPACK}${DIST}.rpm
fi
