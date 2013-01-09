#!/bin/sh

if [ -e $HOME/.vimrc ]; then
    mv $HOME/.vimrc $HOME/.vimrc_old
fi
ln -s $PWD/vimrc $HOME/.vimrc

if [ -e $HOME/vim ]; then
    mv $HOME/.vim $HOME/.vim_old
fi
ln -s $PWD/vim/ $HOME/.vim

git submodule init
git submodule update
