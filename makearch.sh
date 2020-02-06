#!/usr/bin/env bash
export DIST=archlinux
export RELPACK=$2
export RELVER=$3
export DEPLOY=$4
# pin package extension
export PKGEXT=".pkg.tar.xz"
pacman -S --noconfirm --needed base-devel cmake libibus qt5-base rust curl
mkdir /build
echo -e "pkgver=\"$RELVER\"\n$(cat PKGBUILD.stub)" > /build/PKGBUILD
useradd -m builder
chown -R builder:builder /build
cd /build
sudo -u builder makepkg -fd --skipinteg
mv openbangla-keyboard-*${PKGEXT} ${RELPACK}${DIST}${PKGEXT}
if [ $DEPLOY == true ]; then
    mkdir $GITHUB_WORKSPACE/artifact
    mv *${PKGEXT} $GITHUB_WORKSPACE/artifact/
fi
