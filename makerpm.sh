#!/usr/bin/env bash
RELEASE_STUB=$1
RELEASE_FILENAME="${RELEASE_STUB}${DIST}.rpm"
dnf install -y --allowerasing @buildsys-build cmake ibus-devel qt5-qtdeclarative-devel rust cargo ninja-build
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git -b 1.5.1 /src
git -C /src submodule update --init --recursive
sed -i '/PACKAGE_VENDOR/c set(CPACK_PACKAGE_VENDOR "OpenBangla")' /src/CMakeLists.txt
cmake -H/src -B/build -GNinja -DCPACK_GENERATOR=RPM
ninja package -C /build
if [ $DEPLOY == true ]; then
    mv /build/${RELEASE_FILENAME} ${DEPLOY_PATH}/
fi

