" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

" Solarized
syntax enable
set background=dark
set t_Co=256
let g:solarized_termtrans = 1
colorscheme solarized

" Python Mode
let g:pymode_lint_cwindow = 0
let g:pymode_folding = 0
let g:pymode_lint_checker = "pylint"

" Powerline
set laststatus=2

" Various Settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab
set hlsearch

" Just so I'll stick to HJKL
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Web dev stuff
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2

" Bindings to make my life easier
noremap H ^
noremap L $
