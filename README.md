# dotfiles

## Requirements

Besides the obvious per package requirements, the main thing you need is either GNU Stow or XStow.

## How to use

```bash
$ git clone https://github.com/mtomwing/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ stow <package name>
```

## Extra VIM Steps

  1) Initialize and update any git submodules
  ```bash
$ git submodule init
$ git submodule update
  ```

  2) Create necessary VIM folders
  ```bash
$ mkdir -p ~/.vim/{backups,swaps,undo}
  ```
