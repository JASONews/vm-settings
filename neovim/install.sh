#!/bin/bash 

which git
test -eq $? 0 || echo "Please install Git first" && return 1

which nvim
test -eq $? 0 || echo "please install neovim first" && return 2

NVIMPATH=~/.config/nvim
mkdir -p $NVIMPATH
git clone https://github.com/VundleVim/Vundle.vim.git $NVIMPATH/bundle/Vundle.vim
cp ./init.vim $NVIMPATH/ 

echo "init.vim done, please run 'PluginInstall' in neovim"
