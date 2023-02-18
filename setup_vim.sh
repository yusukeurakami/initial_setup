!#/bin/bash
set -e -x

# Yusuke Urakami

sudo apt update
sudo apt install git
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
cd ~/.vim_runtime && sh install_awesome_vimrc.sh

echo "set number" >> ~/.vim_runtime/vimrcs/basic.vim

exit 0

