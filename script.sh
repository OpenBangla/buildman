#! /bin/bash

# Always change this on every release
# export RELVER=$(cat `dirname $0`/trigger.txt)
export RELPACK="OpenBangla-Keyboard_1.4.0-"

makeDeb() {
    docker exec build apt-get -qq update
    docker exec build apt-get -y install git
    docker exec build git clone https://github.com/OpenBangla/buildman.git /ci
    docker exec build chmod +x /ci/makedeb.sh
    docker exec build /ci/makedeb.sh $DIST $RELPACK
}

if [[ $DIST = "ubuntu17.10" ]]; then
    docker pull ubuntu:17.10
    docker run -itd --name build ubuntu:17.10
    makeDeb
elif [[ $DIST = "ubuntu16.04" ]]; then
    docker pull ubuntu:16.04
    docker run -itd --name build ubuntu:16.04
    makeDeb
elif [[ $DIST = "ubuntu18.04" ]]; then
    docker pull ubuntu:18.04
    docker run -itd --name build ubuntu:18.04
    makeDeb
elif [[ $DIST = "fedora27" ]]; then
    docker pull fedora:27
    docker run -itd --name build fedora:27 /bin/bash
    docker exec build dnf -y install git
    docker exec build git clone https://github.com/OpenBangla/buildman.git /ci
    docker exec build chmod +x /ci/makerpm.sh
    docker exec build /ci/makerpm.sh $DIST $RELPACK
elif [[ $DIST = "archlinux" ]]; then
    docker pull archlinux/base
    docker run -itd --name build archlinux/base
    docker exec build pacman -Syyu --noconfirm --needed
    docker exec build pacman -S --noconfirm --needed base git
    # TODO: replace URL before PR
    docker exec build git clone https://github.com/smsrkr/obkb-buildman.git /ci
    docker exec build chmod +x /ci/makearch.sh
    docker exec build /ci/makearch.sh $DIST $RELPACK
fi

