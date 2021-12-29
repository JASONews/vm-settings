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
    set -e
    sudo apt update
    sudo apt install clangd
    set +e
}

echo "Installing neovim..."
install_neovim

( install_clangd ) || echo "[Optional] Failed at installing Clangd. You may need to install it manually"

which git > /dev/null
test $? -eq 0 || (echo "Please install Git first" && exit 1) || exit 1

which nvim > /dev/null
test $? -eq 0 || (echo "please install neovim first" && exit 1) || exit 1

which clangd > /dev/null
test $? -eq 0 || (echo "please install clangd first" && exit 1) || exit 1

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install init.vim and create a symbol link at the home directory
NVIMPATH=~/.config/nvim
mkdir -p $NVIMPATH
cp ./init.vim $NVIMPATH/
ln -s $NVIMPATH/init.vim $HOME/.init.vim
echo "init.vim done, will run 'PlugInstall' in neovim"
nvim --headless -c PlugInstall -c q -c q
echo "Neovim Plugins Installed!"

