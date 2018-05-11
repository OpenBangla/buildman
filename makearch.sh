#!/usr/bin/env bash
export DIST=$1
export RELPACK=$2
# export RELVER=$3
pacman -S --noconfirm --needed base-devel cmake libibus qt5-base curl
mkdir /build
cd /build
RELVER=$(echo $RELPACK | sed -r 's/^.*_(.+)-/\1/g')
echo -e "pkgver=\"$RELVER\"\n$(cat /ci/PKGBUILD.stub)" > PKGBUILD
# makepkg does not run as root
chown nobody:nobody /build
sudo -u nobody makepkg -fd --skipinteg
mv openbangla-keyboard-*.pkg.tar.xz ${RELPACK}${DIST}.tar.xz
curl --upload-file ${RELPACK}${DIST}.tar.xz https://transfer.sh/${RELPACK}${DIST}.tar.xz
