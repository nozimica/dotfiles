#!/bin/bash

# Install vim-plug
[ ! -d ~/.vim/autoload ] && mkdir -p ~/.vim/autoload

if [[ ! -e ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    mkdir -p ~/.vim/plugged
fi

########################################################
## Colors

# Create colors folder if does not exists yet.
[ ! -d ~/.vim/colors ] && mkdir ~/.vim/colors

# Update plugins through vim-plug
vim +PlugUpdate
