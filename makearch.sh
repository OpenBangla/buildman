#!/usr/bin/env bash
export DIST=archlinux
export RELPACK=$2
export RELVER=$3
export DEPLOY=$4
# pin package extension
export PKGEXT=".pkg.tar.xz"
pacman -S --noconfirm --needed base-devel cmake libibus qt5-base rust curl
mkdir /build
echo -e "pkgver=\"$RELVER\"\n$(cat /ci/PKGBUILD.stub)" > /build/PKGBUILD
useradd -m builder
chown -R builder:builder /build
cd /build
sudo -u builder makepkg -fd --skipinteg
mv openbangla-keyboard-*${PKGEXT} ${RELPACK}${DIST}${PKGEXT}
if [ $DEPLOY == 1 ]; then
    echo "Deploying artifacts to transfer.sh"
    curl --upload-file ${RELPACK}${DIST}${PKGEXT} https://transfer.sh/
fi
