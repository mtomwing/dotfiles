# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Some shell options
shopt -s extglob


## General Environment Variables
export TERM='xterm-256color'
export EDITOR="vim"


## Virtualenv Stuff
export WORKON_HOME="~/.virtualenvs"
if [ -f "/usr/bin/virtualenvwrapper.sh" ]; then
    source /usr/bin/virtualenvwrapper.sh
fi


## Automatically include any other bash related things
for FILE in ~/.bash/!(*.after); do
    source "$FILE"
done
for FILE in ~/.bash/*.after; do
    source "$FILE"
done
unset FILE
