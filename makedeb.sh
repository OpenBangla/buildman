#!/usr/bin/env bash
RELEASE_STUB=$1
RELEASE_FILENAME="${RELEASE_STUB}${DIST}.deb"
apt-get -y install build-essential cmake libibus-1.0-dev qt5-default rustc cargo ninja-build curl
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git -b 1.5.1 /src
git -C /src submodule update --init --recursive
sed -i '/_SHLIBDEPS/a set(CPACK_DEBIAN_PACKAGE_SECTION "utils")' /src/CMakeLists.txt
sed -i '/PACKAGE_VENDOR/c set(CPACK_PACKAGE_VENDOR "OpenBangla")' /src/CMakeLists.txt
sed -i '/PACKAGE_MAINTAINER/c set(CPACK_DEBIAN_PACKAGE_MAINTAINER "OpenBangla <openbanglateam@gmail.com>")' /src/CMakeLists.txt
cmake -H/src -B/build -GNinja -DCPACK_GENERATOR=DEB
ninja package -C /build
if [ $DEPLOY == true ]; then
    mv /build/${RELEASE_FILENAME} ${DEPLOY_PATH}/
fi

