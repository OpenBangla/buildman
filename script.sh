#! /bin/bash

makeDeb() {
    docker exec build apt-get update
    docker exec build apt-get -y install git
    docker exec build git clone https://github.com/OpenBangla/buildman.git /ci
    docker exec build chmod +x /ci/makedeb.sh
    docker exec build /ci/makedeb.sh $DIST
}

if [[ $DIST = "ubuntu17.10" ]]; then
    docker pull ubuntu:17.10
    docker run -itd --name build ubuntu:17.10
    makeDeb
elif [[ $DIST = "ubuntu16.04" ]]; then
    docker pull ubuntu:16.04
    docker run -itd --name build ubuntu:16.04
    makeDeb
elif [[ $DIST = "fedora27" ]]; then
    docker pull fedora:27
    docker run -itd --name build fedora:27 bash
    docker exec build dnf install git
    docker exec build git clone https://github.com/OpenBangla/buildman.git /ci
    docker exec build chmod +x /ci/makerpm.sh
    docker exec build /ci/makerpm.sh $DIST
fi
