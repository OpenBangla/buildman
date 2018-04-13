#! /bin/bash

makeDeb() {
        docker exec build apt-get update
        docker exec build apt-get -y install git build-essential cmake libibus-1.0-dev qt5-default qtdeclarative5-dev ninja-build
        docker exec build git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git /repo
        
        docker exec build cmake -H/repo -B/build -GNinja -DCPACK_GENERATOR=DEB
        docker exec build ninja package -C build
}

if [[ $DIST = "ubuntu17.10" ]]; then
        docker pull ubuntu:17.10
        docker run -itd --name build ubuntu:17.10
        echo "ubuntu17.10"
        makeDeb
elif [[ $DIST = "ubuntu16.04" ]]; then
        docker pull ubuntu:16.04
        docker run -itd --name build ubuntu:16.04
        echo "ubuntu16.04"
        makeDeb
fi