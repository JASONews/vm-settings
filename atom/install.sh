#!/bin/bash

if test ! -d ~/.atom; then
	mkdir ~/.atom
fi

cp -r ./atom/* ~/.atom
