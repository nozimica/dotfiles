#!/usr/bin/env bash

## Inspired from (among others):
# https://github.com/zhimsel/dotfiles/blob/master/install.sh


# List of dotfiles
dfiles=(\
    vimrc \
    vimrc-plug \
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
    ["gitconfig"]="gitconfigfunc" \
    ["vimrc-plug"]="bin/s03_install_vim_plugins.sh" \
)
function gitconfigfunc() {
    read -p 'Ingrese su email para git: ' gitemail
    git config --global user.email "${gitemail}"
}

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
        print_error_msg "$DOTFILES_DIR/$thisFile doesn't exist."
        exit 2
    fi

    # test if target file exists and is a directory (link or not)
    if [[ -d "$localDotFile" ]]; then
        print_error_msg "$localDotFile is a directory."
        exit 2
    fi

    # test if target file exists
    if [[ -e "$localDotFile" ]]; then
        if [[ -L "$localDotFile" ]]; then
            echo "Link for $localDotFile already exists."
        else
            echo "A regular file called $localDotFile already exists."
        fi
        echo "Backing up $localDotFile."
        cp $localDotFile $localDotFile.origBeforeUpdateDotFiles
        cp $localDotFile $BACKUP_FOLDER
        rm -f $localDotFile
    fi

    # test if target file does not exist yet
    if [[ ! -e "$localDotFile" ]]; then
        echo "Creating new $localDotFile as a link."
        ln -s $DOTFILES_DIR/$thisFile $localDotFile
    fi

    if [[ ${commfiles["$thisFile"]} ]]; then
        echo "Executing post command for $localDotFile:"
        echo "    ${commfiles[""$thisFile""]}"
        eval ${commfiles["$thisFile"]}
    fi

    echo ""
}

pack_backup_folder () {
    echo "Pack and backup folder"
    tar jcf $BACKUP_TBZ -C $DOTFILES_DIR $BACKUP_FOLDER
    rm -rf $BACKUP_FOLDER
}

check_scenario () {
    if [[ -e $DOTFILES_DIR/$BACKUP_FOLDER ]]; then
        print_error_msg "Backup folder already exists. Cannot move forward."
        exit 2
    fi
    echo ""
    print_msg "Backup folder: $BACKUP_TBZ"
    mkdir $DOTFILES_DIR/$BACKUP_FOLDER
    echo ""
}

print_error_msg () {
    echo ""
    echo -e "$(tput setaf 1)$(tput bold) *** ERROR: $1$(tput sgr0)"
    echo ""
}

print_title () {
    echo -e "$(tput setaf 2)$(tput bold)############################################################$(tput sgr0)"
    echo -e "$(tput setaf 2)$(tput bold)#   File: $1$(tput sgr0)"
    echo ""
}

print_msg () {
    echo -e "$(tput setaf 4)$(tput bold)$1$(tput sgr0)"
}

check_reqs () {
    # Check bzip2
    check_onereq "bzip2"
    check_onereq "curl"
}

check_onereq () {
    command -v $1 >/dev/null 2>&1 || { echo >&2 "Program '$1' not found; but it's required. Aborting."; exit 2; }
}

main () {
    # Check for needed programs
    check_reqs

    # Get current dir (so run this script from anywhere)
    export DOTFILES_DIR
    DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    # Strip the last directory (this script resides in bin)
    # DOTFILES_DIR="$( realpath ${DOTFILES_DIR}/.. )"
    DOTFILES_DIR="$(dirname "$DOTFILES_DIR")"
    echo ${DOTFILES_DIR}

    export BACKUP_FOLDER
    BACKUP_FOLDER=backupFolder
    export BACKUP_TBZ
    THISDATE=`date +%Y-%m-%d`
    BACKUP_TBZ=${DOTFILES_DIR}/${BACKUP_FOLDER}-${THISDATE}.tbz

    # if [[ -e "$BACKUP_TBZ" ]]; then
    #     print_error_msg "Backup file '$BACKUP_TBZ' already exists. Check manually."
    #     exit 2
    # fi

    BACKUP_INDEX=0
    while [[ -f $BACKUP_TBZ ]]; do
        print_error_msg "Backup file '$BACKUP_TBZ' already exists. Checking alternative name."
        BACKUP_INDEX=$((BACKUP_INDEX + 1))
        BACKUP_TBZ=${DOTFILES_DIR}/${BACKUP_FOLDER}-${THISDATE}-v${BACKUP_INDEX}.tbz
        echo "Backup: $BACKUP_TBZ"
    done

    echo ""
    echo "For every file in this repo:"
    echo " - we'll backup your current version;"
    echo " - update it with what is here right now."
    echo ""

    print_msg "Working into '$DOTFILES_DIR'."
    echo ""
    print_msg "Update dotfiles itself first."

    [ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

    check_scenario
    install_links
}

main
