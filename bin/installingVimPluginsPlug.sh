#!/bin/bash

# Install vim-plug
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.vim/plugged

########################################################
## Colors

# Create colors folder if does not exists yet.
[ ! -d ~/.vim/colors ] && mkdir ~/.vim/colors

# Update plugins through vim-plug
vim +PlugUpdate
