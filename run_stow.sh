#!/usr/bin/env bash

DETECTED_OSTYPE="linux"
if [[ $OSTYPE == 'darwin'* ]]; then
    DETECTED_OSTYPE="darwin"
fi

stow -v vim nvim ghostty tmux

./bin/s03_install_vim_plugins.sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

if [[ $DETECTED_OSTYPE == "darwin" ]]; then
    stow --no -v hammerspoon
fi
