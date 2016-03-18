" Vundle Stuff
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugins
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Valloric/YouCompleteMe'
Bundle 'airblade/vim-gitgutter'
Bundle 'bitc/vim-bad-whitespace'
Bundle 'bling/vim-airline'
Bundle 'chrisbra/csv.vim'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'lambdalisue/vim-pyenv'
Bundle 'mattn/webapi-vim'
Bundle 'octol/vim-cpp-enhanced-highlight'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tweekmonster/braceless.vim'
Bundle 'wting/rust.vim'

" Themes
Bundle 'DAddYE/soda.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'chriskempson/base16-vim'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'freeo/vim-kalisi'
Bundle 'reedes/vim-colors-pencil'
Bundle 'romainl/Apprentice'
Bundle 'tomasr/molokai'

" Regular Stuff
filetype plugin indent on
syntax on

" Put VIM's temp files somewhere
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

" Highlight the current line
set cursorline
hi CursorLine cterm=none ctermbg=254 guibg=Gray89

" indicate tabs
set list listchars=tab:→\

" ignore case when searching, except when pattern contains capital
set ignorecase
set smartcase

" OSX Stuff
set clipboard=unnamedplus
set backspace=indent,eol,start

" Theme
syntax enable
let base16colorspace=256
set t_Co=256
set background=dark
colorscheme base16-atelierdune

" braceless
autocmd FileType python BracelessEnable +indent +fold + highlight

" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
let g:ctrlp_working_path_mode = 'r'
nmap <leader>p :CtrlP<cr>
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" Buffergator
let g:buffergator_viewport_split_policy = 'R'
let g:buffergator_suppress_keymaps = 1
nmap <leader>jj :BuffergatorMruCyclePrev<cr>
nmap <leader>kk :BuffergatorMruCycleNext<cr>
nmap <leader>bl :BuffergatorOpen<cr>
nmap <leader>t :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

" Syntastic
let g:syntastic_python_checkers=['flake8', 'pyflakes']
noremap <F1> :SyntasticCheck<CR>

" YouCompleteMe
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
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

" csv.vim
let g:csv_highlight_column = 'y'

" Search / Replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

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
set ttyfast

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
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd Filetype markdown call SetHTMLOptions()
let g:pandoc_no_folding = 1
set nofoldenable

" GUI Stuff
set guifont=Source\ Code\ Pro:h13
set guioptions=aem
set lines=999 columns=9999
set noerrorbells
set novisualbell
autocmd! GUIEnter * set vb t_vb=

" Web dev stuff
autocmd Filetype html call SetHTMLOptions()
autocmd Filetype htmldjango call SetHTMLOptions()
autocmd Filetype javascript call SetHTMLOptions()
function SetHTMLOptions()
    setlocal shiftwidth=2
    setlocal tabstop=2
endfunction

" C++ Stuff
autocmd Filetype cpp call SetCPPOptions()
function SetCPPOptions()
    setlocal noexpandtab
endfunction
