#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"

source /usr/share/git/completion/git-completion.bash
source ~/.git-prompt.sh
export TERM='xterm-256color'

##
# Aliases
##
alias ls='ls --color=auto'
alias ll='ls -al'
alias schedule='gcalcli calw'
alias agenda='gcalcli agenda'
alias scan='/home/mtomwing/Scripts/net-scan.pl --listen 192.168.1.13 --clx2160n --scan-dir /home/mtomwing/Pictures/scans/'
function workon() { 
  if [ -d "$HOME/.envs/$1/" ]; then
    source $HOME/.envs/$1/bin/activate;
    cd $HOME/Projects/$1;
  fi
}
function vpn() { sshuttle -r $1 0.0.0.0/0 --dns ;}

#alias leto='rdesktop -d ad.sfu.ca -u mtomwing -g 1376x738 leto.csil.sfu.ca -a 16 -z'
alias leto='rdesktop -d ad.sfu.ca -u mtomwing -g 100% leto.csil.sfu.ca -a 16 -z'
alias desktop='vncviewer 192.168.1.106 -compresslevel 9'
alias open='xdg-open'

##
# Shell colors
##
BLACK="\[\e[0;30m\]"  BOLD_BLACK="\[\e[1;30m\]"  UNDER_BLACK="\[\e[4;30m\]"
RED="\[\e[0;31m\]"    BOLD_RED="\[\e[1;31m\]"    UNDER_RED="\[\e[4;31m\]"
GREEN="\[\e[0;32m\]"  BOLD_GREEN="\[\e[1;32m\]"  UNDER_GREEN="\[\e[4;32m\]"
YELLOW="\[\e[0;33m\]" BOLD_YELLOW="\[\e[1;33m\]" UNDER_YELLOW="\[\e[4;33m\]"
BLUE="\[\e[0;34m\]"   BOLD_BLUE="\[\e[1;34m\]"   UNDER_BLUE="\[\e[4;34m\]"
PURPLE="\[\e[0;35m\]" BOLD_PURPLE="\[\e[1;35m\]" UNDER_PURPLE="\[\e[4;35m\]"
CYAN="\[\e[0;36m\]"   BOLD_CYAN="\[\e[1;36m\]"   UNDER_CYAN="\[\e[4;36m\]"
WHITE="\[\e[0;37m\]"  BOLD_WHITE="\[\e[1;37m\]"  UNDER_WHITE="\[\e[4;37m\]"
NO_COLOR="\[\e[0m\]"

##
# Git shell prompt
#   requires Git bash completion to be installed
##
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

# export PS1="${PURPLE}\h${WHITE}[${YELLOW}\w${WHITE}]${WHITE}[${GREEN}\$(parse_git_branch)${RED}\$(parse_git_dirty)${WHITE}]${NO_COLOR} "
export PS1="${PURPLE}\h${WHITE}[${YELLOW}\w${WHITE}]\$(__git_ps1 '${WHITE}[${GREEN}%s${RED}'\$(parse_git_dirty)'${WHITE}]')${WHITE}${NO_COLOR} "
export PS2=" > "
export PS4=" + "

# Other things
export EDITOR="vim"
