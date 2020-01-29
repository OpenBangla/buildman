#! /bin/bash
# Always change this on every release
export RELVER=$(cat "`dirname $0`/version.txt")
export RELPACK="OpenBangla-Keyboard_$RELVER-"
# Check if we want to deploy build artifacts
string='deploy+'
export DEPLOY=$(git log -1 --pretty=%B | grep "$string" -q  && echo 1 || echo 0)

export REPO=${TRAVIS_PULL_REQUEST_SLUG:-$TRAVIS_REPO_SLUG}
export BRANCH=${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}

docker pull $DIST
docker run -itd --name build $DIST /bin/bash
if [[ $DIST =~ ^ubuntu ]]; then
    docker exec build apt-get -qq update
    docker exec build apt-get -y install git
    BUILDERSCRIPT=makedeb
elif [[ $DIST =~ ^fedora ]]; then
    docker exec build dnf -y --allowerasing distro-sync
    docker exec build dnf -y install git
    BUILDERSCRIPT=makerpm
elif [[ $DIST =~ ^archlinux ]]; then
    docker exec build pacman -Syyu --noconfirm --needed
    docker exec build pacman -S --noconfirm --needed base git
    BUILDERSCRIPT=makearch
fi
docker exec build git clone https://github.com/$REPO.git -b $BRANCH /ci
docker exec build /ci/$BUILDERSCRIPT.sh $DIST $RELPACK $RELVER $DEPLOY
