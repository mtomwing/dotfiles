" Virtualenv
python << EOF
import sys, vim, os

ve_dir = vim.eval('$VIRTUAL_ENV')
ve_dir in sys.path or sys.path.insert(0, ve_dir)
activate_this = os.path.join(ve_dir, 'bin', 'activate_this.py')

if os.path.exists(activate_this):
    execfile(activate_this, dict(__file__=activate_this))
EOF

" Vundle Stuff
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"
" Bundles
Bundle 'gmarik/vundle'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'Lokaltog/powerline'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Valloric/YouCompleteMe'
Bundle 'airblade/vim-gitgutter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bitc/vim-bad-whitespace'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'vim-pandoc/vim-pandoc-syntax'
Bundle 'vim-pandoc/vim-pantondoc'
Bundle 'wting/rust.vim'

" Regular Stuff
filetype plugin indent on
syntax on

" Put VIM's temp files somewhere
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" Highlight the current line
set cursorline
hi CursorLine cterm=none ctermbg=254 guibg=Gray89

" indicate tabs
set list listchars=tab:→\

" ignore case when searching, except when pattern contains capital
set ignorecase
set smartcase

" Performance Stuff
" set synmaxcol=200
" set ttyfast
" set ttyscroll=3
" set lazyredraw

" OSX Stuff
set clipboard=unnamed
set backspace=indent,eol,start

" Solarized
syntax enable
set background=light
" set t_Co=256
let g:solarized_termtrans = 1
let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized

" Syntastic
let g:syntastic_python_checkers=['flake8']
noremap <F1> :SyntasticCheck<CR>

" YouCompleteMe
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python2'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filepath_completion_use_working_dir = 1
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Powerline
set laststatus=2
set encoding=utf-8

" Gist
let g:gist_browser_command = 'open %URL%'
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_get_multiplefile = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1

" GitGutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" Web dev stuff
autocmd Filetype html call SetHTMLOptions()
autocmd Filetype htmldjango call SetHTMLOptions()
autocmd Filetype javascript call SetHTMLOptions()
function SetHTMLOptions()
    setlocal shiftwidth=2
    setlocal tabstop=2
endfunction

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

" Easier Window Switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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

" Toggle 80 column marker
nnoremap <F2> :call ToggleColorColumn()<CR>
func! ToggleColorColumn()
    if exists("b:colorcolumnon") && b:colorcolumnon
        let b:colorcolumnon = 0
        exec ':set colorcolumn=0'
        echo '80 column marker off'
    else
        let b:colorcolumnon = 1
        exec ':set colorcolumn=80'
        echo '80 column marker on'
    endif
endfunc

" Remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Pandoc
autocmd BufRead,BufNewFile *.md set filetype=pandoc
autocmd Filetype pandoc call SetHTMLOptions()
let g:pandoc_no_folding = 1
set nofoldenable

" GUI Stuff
set guifont=Source\ Code\ Pro:h13
set lines=999 columns=9999
set noerrorbells
set novisualbell
autocmd! GUIEnter * set vb t_vb=
