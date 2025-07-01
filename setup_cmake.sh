#!/bin/bash
set -e -x

source setup_utils.sh

VERSION="3.25.2"

sudo apt purge cmake -y

sudo apt install wget curl openssl libssl-dev -y
cd ~/Downloads
wget https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}.tar.gz
tar -xvf cmake-${VERSION}.tar.gz
cd cmake-${VERSION}
./bootstrap
make
sudo make install

exit 0
