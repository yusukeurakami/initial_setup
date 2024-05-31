#!/bin/bash
set -e -x

source setup_utils.sh

# install zsh and oh-my-zsh
sudo apt install zsh curl git -y

if [ -d "~/.oh-my-zsh" ]; then
    echo "oh-my-zsh is found"
else
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "oh-my-zsh is found"
fi
source ~/.zshrc

exit 0

