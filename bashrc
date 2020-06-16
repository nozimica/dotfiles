###########################################################################
# shell special variables

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

# set vi bindings for command line editing
set -o vi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    # PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1='${debian_chroot:+($debian_chroot)}[\u@\h:\w/]\$ '
    ;;
*)
    ;;
esac

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

export TEXLIVE_HOME=$HOME/opt/TexLive
export PATH=$HOME/bin:$PATH
export PATH=$TEXLIVE_HOME/bin/x86_64-linux:$PATH
export PATH=$HOME/usr/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export MANPATH=/usr/share/man:/usr/local/man:/usr/local/share/man:$TEXLIVE_HOME/texmf/doc/man
#export INFOPATH=$TEXLIVE_HOME/texmf/doc/info:$INFOPATH
export PDFVIEWER_texdoc=evince

###########################################################################
# environment variables for specific applications and packages

# VIM
if [ -d $HOME/opt/vim/bin ]; then
    export PATH=$HOME/opt/vim/bin:$PATH
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
        export PYTHONNOUSERSITE=True
        # export PATH=$HOME/opt/anaconda3/bin:$PATH
        initializeAnaconda $HOME/opt/anaconda3
    elif [ -d $HOME/opt/anaconda2/bin ]; then
        export PYTHONNOUSERSITE=True
        # export PATH=$HOME/opt/anaconda2/bin:$PATH
        initializeAnaconda $HOME/opt/anaconda2
    elif [ -d $HOME/.local/bin ]; then
        export PATH=$HOME/.local/bin:$PATH
    fi
}

function initializeAnaconda {
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
    # <<< conda initialize <<<
}

# Miniconda paths
function loadMiniconda {
    if [ -d $HOME/opt/miniconda3/bin ]; then
        export PYTHONNOUSERSITE=True
        export PATH=$HOME/opt/miniconda3/bin:$PATH
        #source $HOME/opt/miniconda3/etc/profile.d/conda.sh
    elif [ -d $HOME/opt/miniconda2/bin ]; then
        export PYTHONNOUSERSITE=True
        export PATH=$HOME/opt/miniconda2/bin:$PATH
    elif [ -d $HOME/.local/bin ]; then
        export PATH=$HOME/.local/bin:$PATH
    fi
}

# GEMS
if [ -d $HOME/.gem/ruby/1.9.1 ]; then
    export PATH=$HOME/.gem/ruby/1.9.1/bin:$PATH
fi

# Cabal
if [ -d $HOME/.cabal ]; then
    export PATH=$HOME/.cabal/bin:$PATH
fi

# Nodejs
if [ -d $HOME/opt/nodejs ]; then
    export PATH=$HOME/opt/nodejs/bin:$PATH
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

###########################################################################
# directory changer
#
function cds() {
    if [ -f $HOME/.bash_workingdirs ] ; then
        mapfile -t dirsArr < $HOME/.bash_workingdirs
        local dirsArrLen=${#dirsArr[@]}

        echo "     ---------------------------------------------------------------------------"
        echo "     Working directories:"
        echo ""
        local specialLine="·································································"
        for (( i=1; i<${dirsArrLen}+1; i++ )); do
            local thisDir=${dirsArr[$i-1]}
            printf "     %2d %s %s %2d\n" ${i} "${thisDir}" "${specialLine:${#thisDir}}" ${i}
        done
        echo ""
        echo -n "     Select dir index: "
        read dirFromUser
        echo ""
        # echo "..${dirsArr[${dirFromUser}-1]}.."
        cd "${dirsArr[${dirFromUser}-1]}"
    fi
}
