#!/bin/bash
set -e -x

source setup_utils.sh

if ! command -v python &> /dev/null
then
    echo "python not exists"
    sudo ln -s /usr/bin/python3 /usr/bin/python
else
    echo "python found"
fi

sudo apt update && sudo apt install -y\
    git\
    meld\
    build-essential\
    locales\
    net-tools\
    ssh\
    openssh-server\
    openssl\
    libssl-dev\
    lsb-release\
    python3-pip\
    software-properties-common\
    tmux\
    htop\
    rviz\
    python3-ipdb\
    --no-install-recommends
sudo apt autoremove -y

pip install jupyterlab matplotlib IPython

exit 0
