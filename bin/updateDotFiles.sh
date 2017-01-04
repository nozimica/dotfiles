#!/usr/bin/env bash

## Inspired from (among others):
# https://github.com/zhimsel/dotfiles/blob/master/install.sh

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Strip the last directory (this script resides in bin)
DOTFILES_DIR="$( realpath ${DOTFILES_DIR}/.. )"

export BACKUP_FOLDER
BACKUP_FOLDER=backupFolder
export BACKUP_TBZ
BACKUP_TBZ=$BACKUP_FOLDER-`date +%Y-%m-%d`.tbz

echo "Working into '$DOTFILES_DIR'."

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# List of dotfiles
dfiles=(\
    vimrc \
    tcshrc \
    complete.tcsh \
    Xresources \
    bashrc \
    bash_aliases
    gitconfig \
)

# List of commands for each file
declare -A commfiles=(\
    ["Xresources"]="xrdb -merge ~/.Xresources" \
)

install_links () {
    for file in "${dfiles[@]}"
    do
        print_title "$file"
        backup_and_link "$file"
    done
    pack_backup_folder
    echo ""
}

backup_and_link () {
    local thisFile=$1
    local localDotFile
    localDotFile="$HOME/.$1"

    cd $DOTFILES_DIR

    # Check if source dotfile exists
    if [[ ! -e "$DOTFILES_DIR/$thisFile" ]]; then
        print_error_msg "$thisFile doesn't exist."
        exit 2
    fi

    # test if target file exists and is a directory (link or not)
    if [[ -d "$localDotFile" ]]; then
        print_error_msg "$localDotFile is a directory."
        exit 2
    fi

    # test if target file exists and is not a link
    if [[ -e "$localDotFile" ]] && [[ ! -L "$localDotFile" ]]; then
        echo "Link for $localDotFile already exists."
        echo "Backing up $localDotFile."
        cp $localDotFile $localDotFile.origBeforeUpdateDotFiles
        mv $localDotFile $BACKUP_FOLDER
    fi

    # test if target file does not exist yet
    if [[ ! -e "$localDotFile" ]]; then
        echo "Creating new $localDotFile as a link."
        ln -s $DOTFILES_DIR/$thisFile $localDotFile
    fi

    echo ""

    if [[ ${commfiles["$thisFile"]} ]]; then
        echo "Executing post command for $localDotFile:"
        echo "    ${commfiles[""$thisFile""]}"
        eval ${commfiles["$thisFile"]}
    fi
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

print_title () {
    echo "############################################################"
    echo "#   File: $1"
    echo ""
}

echo ""
echo "For every file in this repo:"
echo " - we'll backup your current version;"
echo " - update it with what is here right now."
echo ""
check_scenario
install_links
