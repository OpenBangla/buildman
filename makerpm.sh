#!/usr/bin/env bash
export DIST=$1
dnf install -y @buildsys-build cmake qt5-qtdeclarative-devel ibus-devel ninja-build
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git /repo
cmake -H/repo -B/build -GNinja -DCPACK_GENERATOR=RPM
ninja package -C build