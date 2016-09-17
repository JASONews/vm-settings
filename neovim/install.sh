#!/bin/bash 

which git > /dev/null
test $? -eq 0 || (echo "Please install Git first" && exit 1)

which nvim > /dev/null
test $? -eq 0 || (echo "please install neovim first" && exit 2)

NVIMPATH=~/.config/nvim
mkdir -p $NVIMPATH
git clone https://github.com/VundleVim/Vundle.vim.git $NVIMPATH/bundle/Vundle.vim
cp ./init.vim $NVIMPATH/ 

echo "init.vim done, please run 'PluginInstall' in neovim"
