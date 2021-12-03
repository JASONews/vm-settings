#!/bin/bash

install_app () {
    echo "installing $1..."
    sudo apt-get install "$1"
}

sudo apt-get update
for i in `cat apps.list`; do
    install_app $i
done
