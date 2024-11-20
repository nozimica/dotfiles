###########################################################################
# shell special variables

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# ignore both duplicate lines or lines starting with space in the history,
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# turn off suspend and resume CTRL-s
stty -ixon

# set vim as the editor
export EDITOR=vim

# set vi bindings for command line editing
set -o vi

# # for tmux
# force_color_prompt=yes

###########################################################################
# Miscelanneous
C_CLEAR="\033c"                       # Clear screen
C_BOLD="\e[1m"                        # Bold
C_DEFAULT="\e[0m"                     # Return to default

# Colors
C_FG_BLUE="\e[38;05;25m"              # Blue
C_FG_WHITE="\e[38;05;255m"            # White
C_FG_RED="\e[38;05;196m"              # Red
C_FG_ORANGE="\e[38;05;208m"
C_FG_BRIGHT_RED="\e[38;05;009m"
C_FG_GREEN="\e[38;05;34m"

C_FG_YELLOW="\e[38;05;100m"           # Yellow fg
C_BG_YELLOW="\e[48;05;100;255m"       # Yellow bg, white fg

# Corners
#C_TL="\x1b(0\x6c\x1b(B"               # Top left corner      (
C_TL="\U256D"               # Top left corner      (
#C_TR="\x1b(0\x6b\x1b(B"               # Top right corner     )
C_TR="\U256E"               # Top right corner     )
#C_BL="\x1b(0\x6d\x1b(B"               # Bottom left corner   {
C_BL="\U2570"               # Bottom left corner   {
#C_BR="\x1b(0\x6a\x1b(B"               # Bottom right corner  }
C_BR="\U256F"               # Bottom right corner  }

# Lines
#C_HR="\x1b(0\x71\x1b(B"               # Horizontal line      -
C_HR="\U2500"               # Horizontal line      -
#C_VR="\x1b(0\x78\x1b(B"               # Vertical line        |
C_VR="\U2502"               # Vertical line        |

# Connectors
#C_C1="\x1b(0\x74\x1b(B"               # Connector |-         <
C_C1="\U251C"               # Connector |-         <
#C_C2="\x1b(0\x75\x1b(B"               # Connector -|         >
C_C2="\U2524"               # Connector -|         >
#C_C3="\x1b(0\x6e\x1b(B"               # Connector +          +
C_C3="\U253C"               # Connector +          +
#C_C4="\x1b(0\x77\x1b(B"               # Connector T          T
C_C4="\U252C"               # Connector T          T
#C_C5="\x1b(0\x76\x1b(B"               # Connector flipped T  t
C_C5="\U2534"               # Connector flipped T  t

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Customize prompt: set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# 2. alias for known hosts
if [[ ${HOSTNAME} == "some known host" ]]; then
    PSHOSTLOCAL="hostname"
else
    PSHOSTLOCAL=${HOSTNAME}
fi

get_current_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/\* \(.*\)/\1/'
}
enclose_current_git_branch() {
    local CURRENT_BRANCH=$(get_current_git_branch)
    local ENCLOSED_CURRENT_BRANCH="(${CURRENT_BRANCH})"
    echo ${CURRENT_BRANCH:+$ENCLOSED_CURRENT_BRANCH}
}

# 3. set prompt
function set_prompt_with_host() {
    local PSHOSTLOCAL=$1
    export PS1="[\[${C_BOLD}\]\u@${PSHOSTLOCAL}\[${C_DEFAULT}\] \[${C_FG_GREEN}\]\w\[${C_DEFAULT}\] \[${C_FG_BRIGHT_RED}\]\$(enclose_current_git_branch)\[${C_DEFAULT}\]]$ "
}

if [ "$color_prompt" = yes ]; then
    set_prompt_with_host ${PSHOSTLOCAL}
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     # PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     PS1='${debian_chroot:+($debian_chroot)}[\u@\h:\w/]\$ '
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

###########################################################################
# export custom env vars

export PATH=$HOME/bin:$PATH
export PATH=$HOME/usr/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

###########################################################################
# environment variables for specific applications and packages

# VIM
if [ -d $HOME/opt/vim/bin ]; then
    export PATH=$HOME/opt/vim/bin:$PATH
fi

# TexLive
if [ -d $HOME/opt/TexLive ]; then
    export TEXLIVE_HOME=$HOME/opt/TexLive
    export PATH=$TEXLIVE_HOME/bin/x86_64-linux:$PATH
    export MANPATH=$TEXLIVE_HOME/texmf-dist/doc/man:/usr/share/man:/usr/local/man:/usr/local/share/man:$MANPATH
    export INFOPATH=$TEXLIVE_HOME/texmf-dist/doc/info:$INFOPATH
    export PDFVIEWER_texdoc=evince
fi

# JAVA
if [ -d $HOME/opt/jdk ]; then
    export JAVA_HOME=$HOME/opt/jdk
    export PATH=$JAVA_HOME/bin:$PATH
    export CLASSPATH=.:$JAVA_HOME/jre/lib/ext:$JAVA_HOME/lib/tools.jar
    #if [ -z "$LD_LIBRARY_PATH" ]; then
    #    export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server
    #else
    #    export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server:$LD_LIBRARY_PATH
    #fi
fi

# Anaconda paths
function loadAnaconda {
    if [ -d $HOME/opt/anaconda3/bin ]; then
        initializeAnaconda $HOME/opt/anaconda3
    elif [ -d $HOME/work/opt/miniconda3/bin ]; then
        # initializeAnaconda $HOME/work/opt/miniconda3
        export PATH=$HOME/work/opt/miniconda3/bin:$PATH
        source $HOME/work/opt/miniconda3/bin/activate
    elif [ -d $HOME/opt/anaconda2/bin ]; then
        initializeAnaconda $HOME/opt/anaconda2
    elif [ -d $HOME/opt/miniconda3/bin ]; then
        initializeAnaconda $HOME/opt/miniconda3
    elif [ -d $HOME/opt/miniconda2/bin ]; then
        initializeAnaconda $HOME/opt/miniconda2
    elif [ -d $HOME/.local/bin ]; then
        export PATH=$HOME/.local/bin:$PATH
    fi
}

function initializeAnaconda {
    export PYTHONNOUSERSITE=True
    # >>> conda initialize >>>
    # $1 is the path to conda directory
    #
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup=$("${1}/bin/conda" 'shell.bash' 'hook' 2> /dev/null)
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "${1}/etc/profile.d/conda.sh" ]; then
            . "${1}/etc/profile.d/conda.sh"
        else
            export PATH="${1}/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # disable init of env "base"
    if command -v conda &>/dev/null; then
        conda config --set auto_activate_base false
    fi
    # <<< conda initialize <<<
}

# GEMS
if [ -d $HOME/.gem/ruby/2.3.0 ]; then
    export PATH=$HOME/.gem/ruby/2.3.0/bin:$PATH
fi

# Cabal
if [ -d $HOME/.cabal ]; then
    export PATH=$HOME/.cabal/bin:$PATH
fi

# Pandoc standalone
if [ -d $HOME/opt/pandoc ]; then
    export PATH=$HOME/opt/pandoc/bin:$PATH
fi

# Nodejs
if [ -d $HOME/opt/nodejs ]; then
    export PATH=$HOME/opt/nodejs/bin:$PATH
fi

# some terminal customization
if [[ $DETECTED_OSTYPE == "darwin" ]]; then
    export LSCOLORS=ExFxBxDxCxegedabagacad
    export CLICOLOR=1
elif [[ $DETECTED_OSTYPE == "linux" ]]; then
    export LS_COLORS=${LS_COLORS}:"*.py=01;33"
fi


# export LC_TIME="es_CL.UTF-8"
# export LC_PAPER="es_CL.UTF-8"
# export LC_MEASUREMENT="es_CL.UTF-8"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi

if [ -f ~/.bash_aliases.context ]; then
    . ~/.bash_aliases.context
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Makefile autocomplete
complete -W "\`if [ -f Makefile ]; then grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_-]*$//'; elif [ -f makefile ]; then grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' makefile | sed 's/[^a-zA-Z0-9_-]*$//'; fi \`" make

###########################################################################
# directory changer
#
function cds {
    local source_file="${HOME}/.bash_workingdirs"
    if [[ -f ${source_file} ]] ; then
        local user_selection
        local dirsArr
        read_options_from_file ${source_file} dirsArr
        local dirsArrLen=${#dirsArr[@]}
        if [[ $# == 1 ]] ; then
            user_selection=$1
        else
            selection_picker "Working directories" dirsArr user_selection
        fi

        if [[ -n ${user_selection} ]]; then
            echo "    Changing directory to: '${user_selection}'"
            cd -- "${user_selection/#~/$HOME}"
            # local destinationDir="${dirsArr[${user_selection}-1]/#~/$HOME}"
        fi
    fi
}

# Offers a simple command picker, customized for common git commands
GIT_COMMANDS=(
    "git pull && git push"
    "git pull origin mainline:mainline"
    ""
    "git add -u && git commit"
    "git add -u && git commit --amend"
    ""
    "git show --pretty=%gd --stat"
    "git diff --check"
    ""
    "git rebase -i mainline"
    "git rebase --onto \$(get_current_git_branch) rde~1 rde"
    ""
    "git reset --soft HEAD~1"
    ""
    "git {}"
)

function G {
    command_picker "GIT commands" "Running" GIT_COMMANDS $@
}

function command_picker {
    local user_selection
    if [[ $# == 4 ]] ; then
        user_selection=$4
    else
        selection_picker "${1}" "${3}" user_selection
    fi
    if [[ -n ${user_selection} ]]; then
        if [ -z "${user_selection##* \{\}}" ]; then
            read -e -p"${2}: " -i"${user_selection% \{\}} " user_selection
            echo ${user_selection}
        else
            echo "  ${2}: '${user_selection}'"
            echo ""
        fi
        history -s "${user_selection}"
        eval "${user_selection}"
    fi
}

function selection_picker {
    if [[ $# -lt 3 ]] || [[ $# -gt 4 ]] ; then
        return
    fi
    local sel_title=" ${1}:"
    local -n sel_options=$2
    local -n user_selection_inner=$3
    if [[ $# == 4 ]] ; then
        local -n index_user_selection=$4
    else
        local index_user_selection=0
    fi

    local length_numbers=2
    local length_left_margin=2
    local length_lines=92
    local length_total=$(( length_left_margin + 1 + length_lines + 1 ))
    if [[ ${COLUMNS} -lt ${length_total} ]] ; then
        length_lines=$(( length_lines - length_total + COLUMNS + 1 ))
        length_left_margin=1
    fi

    local FMT_digits=`printf -- "${C_FG_GREEN}%%%dd${C_DEFAULT}" ${length_numbers}`
    local blank_instead_of_digits=`printf -- ' %.0s' $(seq 1 ${length_numbers})`
    local option_max_length=$(( length_lines - 1 - length_numbers - 2 - length_numbers - 1 ))

    local horiz_separator=`printf -- "${C_HR}%.0s" $(seq 1 ${length_lines})`
    local left_margin=`printf -- ' %.0s' $(seq 1 ${length_left_margin})`
    local space_after_title=`printf -- ' %.0s' $(seq 1 ${length_lines})`
    local dotted_line=" `printf -- '·%.0s' $(seq 1 ${option_max_length})`"
    printf -- "${left_margin}${C_TL}${horiz_separator}${C_TR}\n"
    printf -- "${left_margin}${C_VR}${C_BOLD}${sel_title}${C_DEFAULT}${space_after_title:${#sel_title}}${C_VR}\n"
    printf -- "${left_margin}${C_C1}${horiz_separator}${C_C2}\n"
    local j=0
    local actual_indexes=()
    local actual_elements=()
    for (( i=1; i<${#sel_options[@]}+1; i++ )); do
        local option_i=${sel_options[$i-1]}
        if [[ -z ${option_i} || ${option_i} == "---" ]]; then
            printf -- "${left_margin}${C_C1}${horiz_separator}${C_C2}\n"
        else
            j=$(( j + 1 ))
            if [[ ${#option_i} -gt $((${option_max_length} )) ]]; then
                printf -- "${left_margin}${C_VR} ${FMT_digits} %s ${blank_instead_of_digits} ${C_VR}\n" ${j} "${option_i:0:${option_max_length}}"
                local opt_idx_bgn=${option_max_length}
                while [ $(( ${opt_idx_bgn} + ${option_max_length} )) -lt ${#option_i} ]; do
                    printf -- "${left_margin}${C_VR} ${blank_instead_of_digits} %s ${blank_instead_of_digits} ${C_VR}\n" "${option_i:${opt_idx_bgn}:${option_max_length}}"
                    opt_idx_bgn=$(( ${opt_idx_bgn} + ${option_max_length} ))
                done
                local dotted_length_j=$(( ${option_max_length} - ${#option_i} + ${opt_idx_bgn} ))
                printf -- "${left_margin}${C_VR} ${blank_instead_of_digits} %s%s ${FMT_digits} ${C_VR}\n" "${option_i:${opt_idx_bgn}}" "${dotted_line:0:${dotted_length_j}}" ${j}
            else
                local dotted_length_j=$(( ${option_max_length} - ${#option_i} ))
                printf -- "${left_margin}${C_VR} ${FMT_digits} %s%s ${FMT_digits} ${C_VR}\n" ${j} "${option_i}" "${dotted_line:0:${dotted_length_j}}" ${j}
            fi
            actual_indexes+=($i)
            actual_elements+=("${j} ${option_i}")
        fi
    done
    printf -- "${left_margin}${C_BL}${horiz_separator}${C_BR}\n\n"

    read -p "${left_margin}Select index, or '.' for fuzzy finder: " user_selection
    if [[ ${user_selection} == "." ]] ; then
        user_selection=$(printf "%s\n" "${actual_elements[@]}" | fzf --delimiter=" " --nth 2.. --no-sort --cycle --height=20 --border=rounded | awk '{print $1}')
    fi
    if [[ ${user_selection} -ge 1 ]] && [[ ${user_selection} -le ${j} ]] ; then
        user_selection=${actual_indexes[${user_selection}-1]}
        index_user_selection=${user_selection}
        user_selection_inner=${sel_options[${user_selection}-1]}
        return 0
    elif [[ -z ${user_selection} ]]; then
        echo "Operation aborted."
        return 1
    fi
    echo "Wrong index."
    user_selection_inner=""
    return 2
}

function read_options_from_file() {
    local this_file=$1
    local -n arr=$2
    if [[ -f ${this_file} ]] ; then
        mapfile -t arr < ${this_file}
    fi
}
