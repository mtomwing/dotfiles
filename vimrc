" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

" Solarized
syntax enable
set background=dark
colorscheme solarized
set t_Co=256

" Python Mode
let g:pymode_lint_cwindow = 0
let g:pymode_folding = 0

" Powerline
set laststatus=2

" Various Settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab
