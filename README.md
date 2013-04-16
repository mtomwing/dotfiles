dotfiles
========

VIM Setup Instructions
----------------------

1) Symlink vimrc to $HOME/.vimrc
```bash
ln -s vimrc $HOME/.vimrc
```

2) Symlink vim to $HOME/.vim
```bash
ln -s vim $HOME/.vim
```

3) Initialize and pull the git submodules for VIM plugins
```bash
git submodule init
git submodule update
```
