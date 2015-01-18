" Vundle Stuff
set nocompatible
filetype off

set runtimepath=~/.nvim/
set runtimepath+=~/.nvim/bundle/Vundle.vim/
call vundle#begin('~/.nvim/bundle')

Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'

Plugin 'chriskempson/vim-tomorrow-theme'

call vundle#end()
filetype plugin indent on

" Put VIM's temp files somewhere
set backupdir=~/.nvim/backups
set directory=~/.nvim/swaps
set undodir=~/.nvim/undo

" Looks
colorscheme Tomorrow-Night-Eighties

" Highlight the current line
set cursorline
hi CursorLine cterm=none ctermbg=254 guibg=Gray89

" Show visible tab characters
set list listchars=tab:→\

" GitGutter Settings
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" Search Settings
set ignorecase
set hlsearch
set incsearch

" Various Settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab
set number
set title
set showcmd

" Just so I'll stick to HJKL
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Bindings to make my life easier
noremap H ^
noremap L $
