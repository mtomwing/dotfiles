" Vundle Stuff
set nocompatible
filetype off

set runtimepath=~/.nvim/
set runtimepath+=~/.nvim/bundle/Vundle.vim/
call vundle#begin('~/.nvim/bundle')

" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'  " git status indicators in gutter
Plugin 'bitc/vim-bad-whitespace'  " highlight trailing whitespace
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'  " use <Tab> for completions
Plugin 'kien/ctrlp.vim'  " <C-p> to fuzzy search to open files
Plugin 'scrooloose/syntastic'  " linting and other static stuff
Plugin 'tpope/vim-fugitive'  " adds :G<command> for better git integration
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'  " adds ways to manipulate (, ', [, </tag>

" Colorschemes
Plugin 'chriskempson/vim-tomorrow-theme'

call vundle#end()
filetype plugin indent on

" Put VIM's temp files somewhere
set backupdir=~/.nvim/backups
set directory=~/.nvim/swaps
set undodir=~/.nvim/undo

" Highlight the current line
set cursorline
hi CursorLine cterm=none ctermbg=254 guibg=Gray89

" Looks
colorscheme Tomorrow-Night-Eighties
set number
set title
set showcmd

" Show visible tab characters
set list listchars=tab:→\

" GitGutter Settings
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" Search Settings
set ignorecase
set hlsearch
set incsearch
set smartcase

" Tab = 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab

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
