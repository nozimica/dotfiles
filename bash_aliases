###########################################################################
# aliases

alias ?='history'
alias ls='ls -lF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias m=more
alias w='w | more'
function _newcd() { builtin cd "$@" ; echo $PWD ;}
alias cd=_newcd;
alias ..='cd ..'
alias motd='cat /etc/motd'
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
alias psnoz="ps -U ${USER}"
alias tmp='cd /tmp'
alias vtmp='cd /var/tmp'
alias dukk='dukk | more'
alias vi='vim'
alias timefmt='\time -f "Elapsed time: %E \t Max resident memory: %MK"'

alias ipp='/sbin/ifconfig | grep -e "inet:" -e "addr:" | grep -v "inet6" | grep -v "127.0.0.1" | head -n 1 | awk '"'"'{print $2}'"'"' | cut -c6-'

alias removeSpaces="rename -v 's/\ /\_/g' *"

alias xtxt='xterm -geometry 116x66+1000+0 & ; xterm -geometry 116x66+2000+0 &;'
alias freemem='ps -e -orss=,args= | sort -b -k1,1n'
alias cal='cal -m'
alias gcal='gcal -s 1'

alias listFailedPasswords="sudo zgrep -h 'Failed password' /var/log/auth.* | grep sshd | awk '{print $1,$2}' | sort -k 1,1M -k 2n | uniq -c"

alias GG='git dog -11'

## For Terminator
setWindowTitle() {
    echo -ne "\033]0; ${1} \007"
}

## Sets window title related to a ssh alias.
##
## The title will have a prefix and a number (taken from tty to avoid collisions).
##
## @param sshAlias      An ssh alias or a ssh server.
## @param sshPrefix     The text that will be displayed at title bar (with a counter).
sshSetTitle() {
    local sshAlias=${1:?"ssh alias must be given. Aborting."}
    local sshPrefix=${2:?"prefix must be given. Aborting."}
    local thisTty=$(tty)
    thisTty=$(printf '%02d' ${thisTty##*/})
    setWindowTitle "${sshPrefix}${thisTty}"
    ssh ${sshAlias}
    setWindowTitle $(printf '%s%02d' $(hostname) ${thisTty})
}
