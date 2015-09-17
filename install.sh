#!/usr/bin/env bash

## Inspired from (among others):
# https://github.com/zhimsel/dotfiles/blob/master/install.sh

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export BACKUP_FOLDER
BACKUP_FOLDER=backupFolder
export BACKUP_TBZ
BACKUP_TBZ=$BACKUP_FOLDER-`date +%Y-%m-%d`.tbz

echo "Working into '$DOTFILES_DIR'."

# Update dotfiles itself first

# [ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# List of dotfiles
dfiles=(\
    vimrc \
    tcshrc \
    complete.tcsh \
)

install_links () {
    for file in "${dfiles[@]}"
    do
        backup_and_link "$file"
    done
    pack_backup_folder
}

backup_and_link () {
    local newFile=$1
    local currentFile
    currentFile="$HOME/.$1"

    cd $DOTFILES_DIR

    # Check if source dotfile exists
    if [[ ! -e "$newFile" ]]; then
        echo "Error: $newFile doesn't exist."
        return
    fi

    echo "Backing up $currentFile."
    if [[ -e "$currentFile" ]] && [[ ! -L "$currentFile" ]]; then
        mv $currentFile $BACKUP_FOLDER
    fi

    echo "Copying new $currentFile."
    cp $newFile $currentFile

    echo ""
}

pack_backup_folder () {
    tar jcf $BACKUP_TBZ -C $DOTFILES_DIR $BACKUP_FOLDER
    rm -rf $BACKUP_FOLDER
}

check_scenario () {
    if [[ -e $DOTFILES_DIR/$BACKUP_FOLDER ]]; then
        print_error_msg "Backup folder already exists. Cannot move forward."
        exit 2
    fi
    if [[ -e "$BACKUP_TBZ" ]]; then
        print_error_msg "Backup tbz already exists. Check manually."
        exit 2
    fi
    mkdir $DOTFILES_DIR/$BACKUP_FOLDER
}

print_error_msg () {
    echo ""
    echo " *** ERROR: $1"
    echo ""
}

echo ""
echo "For every file in this repo:"
echo " - we'll backup your current version;"
echo " - update it with what is here right now."
echo ""
check_scenario
install_links
