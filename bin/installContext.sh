#!/usr/bin/bash

### TODO: avoid not DRY code
# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Strip the last directory (this script resides in bin)
# DOTFILES_DIR="$( realpath ${DOTFILES_DIR}/.. )"
DOTFILES_DIR="$( readlink -f ${DOTFILES_DIR}/.. )"

if [[ ! -z $1 ]] ; then
    if [[ $1 == 'hadoop' ]] ; then
        thisAliasFile="$HOME/.bash_aliases.local"
        hadoopAliasFile="$DOTFILES_DIR/context/bash_aliases_hadoop"
        echo $thisAliasFile
        echo $hadoopAliasFile
        if [[ ! -e $hadoopAliasFile ]]; then
            echo "No file for hadoop."
            exit 2
        fi
        if [[ -e "$thisAliasFile" ]]; then
            echo "Alias file already exists. Exit."
            exit 3
        fi
        ln -s $hadoopAliasFile $thisAliasFile
    fi
fi
