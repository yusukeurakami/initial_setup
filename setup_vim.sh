#!/bin/bash -eux

source setup_utils.sh

sudo apt-get update
sudo apt-get install software-properties-common

# install Node.js
curl -sL install-node.now.sh/lts | sudo bash

# install neovim
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
sudo apt-get install silversearcher-ag

# neovim setting
mkdir -p ${HOME}/.config/nvim/colors

cp ./nvim_configs/init.vim ~/.config/nvim/init.vim
cp ./nvim_configs/coc-settings.json ~/.config/nvim/coc-settings.json
cp ./nvim_configs/hybrid.vim ~/.config/nvim/colors/hybrid.vim

# install neovim library
pip install -U neovim
