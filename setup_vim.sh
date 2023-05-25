!#/bin/bash
set -e -x

# Yusuke Urakami

sudo apt update
sudo apt install -y vim neovim yarn

# copy the coc setting from https://github.com/rstacruz/vim-coc-settings to local config dir.
mkdir -p ${HOME}/.config/nvim
cp -r ./nvim_configs/* ${HOME}/.config/nvim

# install vim-plug to manage the plugins
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


# install Coc following the instruction from https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    curl --fail -LSs https://install-node.now.sh/latest | sudo bash
    export PATH="/usr/local/bin/:$PATH"
    # Or use package manager, e.g.
    # sudo apt-get install nodejs
fi

# Use package feature to install coc.nvim

# for vim8
#mkdir -p ~/.vim/pack/coc/start
#cd ~/.vim/pack/coc/start
#curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -

# for neovim
mkdir -p ${HOME}/.local/share/nvim/site/pack/coc/start
cd ${HOME}/.local/share/nvim/site/pack/coc/start
curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -

# Install extensions
mkdir -p ${HOME}/.config/coc/extensions
cd ${HOME}/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
npm install coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

#Run the follow in neovim to check if the service is running.
# :checkhealth
#Run the follow to install the python3 support
# :CocInstall coc-pyright


exit 0

