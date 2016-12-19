set prompt = "[%n@%m:%~/]% "

set history=150
set histdup=prev
set autologout
set echo_style both
#limit coredumpsize 0k
#limit core 0k
set correct=''
set inputmode
set listlinks
set matchbeep
set autolist
# set ignoreeof
set bindkey -v

export TEXLIVE_HOME=$HOME/opt/TexLive
export PATH=$HOME/bin:$PATH
export PATH=$TEXLIVE_HOME/bin/x86_64-linux:$PATH
export PATH=$HOME/usr/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export MANPATH=/usr/share/man:/usr/local/man:/usr/local/share/man:$TEXLIVE_HOME/texmf/doc/man
#export INFOPATH=$TEXLIVE_HOME/texmf/doc/info:$INFOPATH
export PDFVIEWER_texdoc=evince

# JAVA
if [ -d $HOME/opt/jdk ]; then
    export JAVA_HOME=$HOME/opt/jdk
    export PATH=$JAVA_HOME/bin:$PATH
    export CLASSPATH=.:$JAVA_HOME/jre/lib/ext:$JAVA_HOME/lib/tools.jar
fi

# GEMS
if [ -d $HOME/.gem/ruby/1.9.1 ]; then
    export PATH=$HOME/.gem/ruby/1.9.1/bin:$PATH
fi
# JDK
if [ -d $HOME/opt/jdk ]; then
    export JAVA_HOME=$HOME/opt/jdk
    export PATH=$JAVA_HOME/bin:$PATH
    #if [ -z "$LD_LIBRARY_PATH" ]; then
    #    export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server
    #else
    #    export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server:$LD_LIBRARY_PATH
    #fi
fi
# Cabal
if [ -d $HOME/.cabal ]; then
    export PATH=$HOME/.cabal/bin:$PATH
fi

alias ?='history'
alias ls='ls -lF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias m=more
alias w='w | more'
#alias cd='cd \!*;echo $cwd'
alias ..='cd ..'
alias pwd='echo $cwd'
alias who='who | sort | more'
alias wget2='wget -r -nH --cut-dirs=1 -b -t 0 -c -i'
alias wgetcompl='wget -E -H -k -K -p -nH'
alias l='ls -l --color | more'
alias lt='ls -lt --color | more'
alias lat='ls -lat --color | more'
alias lsz='ls -la | sort -k 5 -nr | more'
alias lsnoz='ls -la | sort -k 3 | grep nozimica'
alias d='ls -lA --color | more'
alias dl='ls -lA --color --group-directories-first | more'
alias ll='ls | more'
alias c='clear'
alias ddd='ls | more'
alias bello='telnet Biblios.dic.uchile.cl'
alias duk='du -k | sort -nr | more'
alias mp3p='rm -f /tmp/mplayerfifo; mkfifo /tmp/mplayerfifo; mplayer -input file=/tmp/mplayerfifo *.mp3'
alias infomp3='mp3info -x -r a *.mp3'
alias dt='ls -lt | more'
alias lspdf='ls *.pdf | more'
alias psnoz='ps -U nozimica'
alias tmp='cd /tmp'
alias vtmp='cd /var/tmp'
alias dukk='dukk | more'

alias ipp='/sbin/ifconfig | grep -e "inet:" -e "addr:" | grep -v "inet6" | grep -v "127.0.0.1" | head -n 1 | awk '"'"'{print $2}'"'"' | cut -c6-'

alias removeSpaces="rename -v 's/\ /\_/g' *"

# http://unix.stackexchange.com/q/32017/6803
#source ~/.complete.tcsh

alias xtxt='xterm -geometry 116x66+1000+0 & ; xterm -geometry 116x66+2000+0 &;'
alias freemem='ps -e -orss=,args= | sort -b -k1,1n'
alias gcal='gcal -s 1'

case "$TERM" in
"xterm*")
        alias precmd='echo -n "\033]0;${HOST}:$cwd\007"'
        ;;
esac

# export LC_TIME="es_CL.UTF-8"
# export LC_PAPER="es_CL.UTF-8"
# export LC_MEASUREMENT="es_CL.UTF-8"

#export LD_LIBRARY_PATH=$HOME/opt/postgres-xl/lib:$HOME/opt/postgresql/lib
#export PATH=$HOME/opt/postgresql/bin:$PATH
#export PATH=$HOME/opt/postgres-xl/bin:$HOME/opt/postgresql/bin:$PATH

if [ -f $HOME/.aliases ]; then
    source $HOME/.aliases
fi

