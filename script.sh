#! /bin/bash

if [[ $DIST = "ubuntu17.10" ]]; then
    docker pull ubuntu:17.10
    docker run -itd --name build ubuntu:17.10
    echo "ubuntu17.10"
elif [[ $DIST = "ubuntu16.04" ]]; then
    docker pull ubuntu:16.04
    docker run -itd --name build ubuntu:16.04
    echo "ubuntu16.04"
fi

docker exec build apt-get update
docker exec build apt-get -y install git
docker exec build git clone https://github.com/OpenBangla/buildman.git /ci
docker exec build /ci/makedeb.sh
