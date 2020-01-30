#! /bin/bash
# Always change this on every release
export RELVER=$(cat "`dirname $0`/version.txt")
export RELPACK="OpenBangla-Keyboard_$RELVER-"
if [[ $DIST =~ ^ubuntu ]]; then
    apt-get -qq update
    apt-get -y install git
    BUILDSCRIPT=makedeb
elif [[ $DIST =~ ^fedora ]]; then
    dnf -y --allowerasing distro-sync
    dnf -y install git
    BUILDSCRIPT=makerpm
elif [[ $DIST =~ ^archlinux ]]; then
    pacman -Syyu --noconfirm --needed
    pacman -S --noconfirm --needed base git
    BUILDSCRIPT=makearch
fi
./$BUILDSCRIPT.sh $DIST $RELPACK $RELVER $DEPLOY
