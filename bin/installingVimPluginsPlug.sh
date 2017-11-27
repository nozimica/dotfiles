#!/bin/bash

########################################################
## Setup powerline-fonts
## Ref: https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation
[ ! -d ~/var/install/fonts ] && mkdir -p ~/var/install/fonts
[ ! -d ~/.config/fontconfig/conf.d ] && mkdir -p ~/.config/fontconfig/conf.d
[ ! -d ~/.fonts ] && mkdir -p ~/.fonts

cd ~/var/install/fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

########################################################
## Install vim-plug
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
