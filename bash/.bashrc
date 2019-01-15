# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Some shell options
shopt -s extglob


## General Environment Variables
export TERM='xterm-256color'
export EDITOR="vim"
export PATH="${PATH}:${HOME}/.bin"

## Golang Stuff
export GOROOT="/usr/lib/go"
export GOPATH="${HOME}/Projects/go"
export PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin"


## Virtualenv Stuff
export WORKON_HOME="${HOME}/.virtualenvs"
if [ -f "/usr/local/bin/virtualenvwrapper" ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi


## Automatically include any other bash related things
for FILE in ~/.bash/!(*.after); do
    source "$FILE"
done
for FILE in ~/.bash/*.after; do
    source "$FILE"
done
unset FILE
