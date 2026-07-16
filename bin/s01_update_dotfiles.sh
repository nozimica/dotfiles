#!/usr/bin/env bash

## Inspired from (among others):
# https://github.com/zhimsel/dotfiles/blob/main/install.sh

# List of dotfiles
DOTFILES=(
# dfiles=(\
    vimrc            .vimrc
    vimrc-plug       .vimrc-plug
    tcshrc           .tcshrc
    complete.tcsh    .complete.tcsh
    Xresources       .Xresources
    bashrc           .bashrc
    bash_aliases     .bash_aliases
    gitconfig        .gitconfig
    tmux.conf        .tmux.conf
    ghostty.conf     .config/ghostty/config
)

# List of commands for each file
declare -A commfiles=(\
    ["Xresources"]="xrdb -merge ~/.Xresources" \
    ["gitconfig"]="gitconfigfunc" \
    ["vimrc-plug"]="bin/s03_install_vim_plugins.sh" \
)
function gitconfigfunc() {
    read -p 'Ingrese su email para git: ' gitemail
    git config --file ~/.gitconfig.local user.email "${gitemail}"
}

install_links () {
    for (( i=0; i<$(( ${#DOTFILES[@]} / 2 )); i++ )); do
        local source_dotfile=${DOTFILES[$(( ${i} * 2 ))]}
        local target_dotfile=${DOTFILES[$(( ${i} * 2 + 1 ))]}
        print_title "${source_dotfile}"
        backup_and_link "${source_dotfile}" "${target_dotfile}"
    done

    pack_backup_folder
    echo ""
}

backup_and_link () {
    local source_dotfile=$1
    local target_dotfile="$HOME/$2"

    print_msg "Trying to copy source: '${source_dotfile}' into '${target_dotfile}'"

    cd $DOTFILES_DIR

    # Check if source dotfile exists
    if [[ ! -e "$DOTFILES_DIR/$source_dotfile" ]]; then
        print_error_msg "$DOTFILES_DIR/$source_dotfile doesn't exist."
        exit 2
    fi

    # test if target file exists and is a directory (link or not)
    if [[ -d "$target_dotfile" ]]; then
        print_error_msg "$target_dotfile is a directory."
        exit 2
    fi

    # test if target file exists
    if [[ -e "$target_dotfile" ]]; then
        if [[ -L "$target_dotfile" ]]; then
            echo "Link for $target_dotfile already exists."
        else
            echo "A regular file called $target_dotfile already exists."
        fi
        echo "Backing up $target_dotfile."
        cp -rp $target_dotfile ${target_dotfile}.origBeforeUpdateDotFiles
        cp -rp $target_dotfile $BACKUP_FOLDER
        rm -rf $target_dotfile
    fi

    # test if target file does not exist yet
    if [[ ! -e "$target_dotfile" ]]; then
        echo "Creating new $target_dotfile as a link."
        ln -s $DOTFILES_DIR/$source_dotfile $target_dotfile
    fi

    # execute post command for this file, if any
    if [[ ${commfiles["$source_dotfile"]} ]]; then
        echo "Executing post command for $target_dotfile:"
        echo "    ${commfiles[""$source_dotfile""]}"
        eval ${commfiles["$source_dotfile"]}
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

    [ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin main

    check_scenario
    install_links

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    # tmux source ~/.tmux.conf
}

main
