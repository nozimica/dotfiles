#!/bin/bash

# Install Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install Repeat
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-repeat.git

# Install Fugitive
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-fugitive.git
vim -u NONE -c "helptags vim-fugitive/doc" -c q

# Install Surround
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-surround.git

# Install Commentary
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-commentary.git

# Install Characterize
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-characterize.git

# Install SpeedDating
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-speeddating.git

# Install Gundo
cd ~/.vim/bundle
git clone http://github.com/sjl/gundo.vim.git ~/.vim/bundle/gundo
# add a mapping to ~/.vimrc
# nnoremap <F5> :GundoToggle<CR>

# Install Dispatch
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-dispatch.git

# Install SnipMate
cd ~/.vim/bundle
git clone https://github.com/tomtom/tlib_vim.git
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
git clone https://github.com/garbas/vim-snipmate.git
# Optional:
git clone https://github.com/honza/vim-snippets.git

# # Install flake8
# easy_install --user flake8
# cd ~/.vim/bundle
# git clone https://github.com/nvie/vim-flake8

# Install vim-json
cd ~/.vim/bundle
git clone git://github.com/elzr/vim-json.git

########################################################
## Tab completion

# Install SuperTab
cd ~/.vim/bundle
git clone https://github.com/ervandew/supertab.git

# # Install jedi-vim (for Python)
# cd ~/.vim/bundle
# git clone --recursive https://github.com/davidhalter/jedi-vim.git

########################################################
## Colors

# Create colors folder if does not exists yet.
cd ~/.vim
[ ! -d colors ] && mkdir colors

# Install Sandydune
cd ~/.vim/colors
git clone https://github.com/idbrii/vim-sandydune
