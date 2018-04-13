#! /bin/bash

if [[ $DIST = "ubuntu17.10" ]]; then
    docker pull ubuntu:17.10
    docker run -itd --name build ubuntu:17.10
    echo "ubuntu17.10"
    docker exec build sh -C makedeb.sh
elif [[ $DIST = "ubuntu16.04" ]]; then
    docker pull ubuntu:16.04
    docker run -itd --name build ubuntu:16.04
    echo "ubuntu16.04"
    docker exec build sh -C makedeb.sh
fi