#!/bin/bash 

install_neovim () {
    set -e
    binDir=$HOME/.local/bin
    [[ ! -e $binDir ]] && mkdir -p $binDir
    which wget
    wget https://github.com/neovim/neovim/releases/download/v0.6.0/nvim.appimage > $binDir/nvim
    chmod u+x $binDir/nvim
    echo "Add $binDir to PATH by appending the following line to your .bashrc"
    echo "export PATH=\"$binDir:$PATH\""
    set +e
}

install_clangd () {
    sudo apt update
    sudo apt install clangd
}


which git > /dev/null
test $? -eq 0 || (echo "Please install Git first" && exit 1)

which nvim > /dev/null
test $? -eq 0 || (echo "please install neovim first" && exit 1)

which clangd /dev/null
test $? -eq 0 || (echo "please install clangd irst" && exit 1)

NVIMPATH=~/.config/nvim
mkdir -p $NVIMPATH
git clone https://github.com/VundleVim/Vundle.vim.git $NVIMPATH/bundle/Vundle.vim
cp ./init.vim $NVIMPATH/
ln -s $NVIMPATH/init.vim $HOME/.init.vim

echo "init.vim done, please run 'PluginInstall' in neovim"
