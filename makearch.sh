#!/usr/bin/env bash
DIST=archlinux
RELEASE_STUB=$1
RELEASE_VERSION=$2
# pin package extension
PKGEXT=".pkg.tar.xz"
RELEASE_FILENAME="${RELEASE_STUB}${DIST}${PKGEXT}"
pacman -S --noconfirm --needed base-devel cmake libibus qt5-base rust curl
mkdir /build
sed -i "/pkgname=/a pkgver=\"${RELEASE_VERSION}\"" PKGBUILD.stub
cp PKGBUILD.stub /build/PKGBUILD
useradd -m builder
chown -R builder:builder /build
cd /build
sudo -u builder makepkg -fd --skipinteg
mv openbangla-keyboard-*${PKGEXT} ${RELEASE_FILENAME}
if [ $DEPLOY == true ]; then
    mv ${RELEASE_FILENAME} ${DEPLOY_PATH}/
fi
