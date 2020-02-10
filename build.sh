#! /bin/bash
RELEASE_VERSION=$(cat "`dirname $0`/version.txt")
# follow cmake PACKAGE_FILE_NAME directive in main repo
RELEASE_STUB="OpenBangla-Keyboard_${RELEASE_VERSION}-"
if [[ $DIST =~ ^(ubuntu|debian) ]]; then
    apt-get -qq update
    apt-get -y install git
    # this is to read distro codename from filename during deployment
    CODENAME=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d= -f2)
    DIST="${DIST}-${CODENAME}"
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
if [ $DEPLOY == true ]; then
    export DEPLOY_PATH="${GITHUB_WORKSPACE}/artifact"
    mkdir "$DEPLOY_PATH"
fi
DIST=${DIST/:/}
./${BUILDSCRIPT}.sh $RELEASE_STUB $RELEASE_VERSION
