set clipboard+=unnamedplus

filetype off

" Python Interpreter
let g:python_host_prog = expand('~/.virtualenvs/neovim2/bin/python')
let g:python3_host_prog = expand('~/.virtualenvs/neovim3/bin/python')

" Vundle Setup
set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" PLUGINS

"" General
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bitc/vim-bad-whitespace'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tweekmonster/braceless.vim'
NeoBundle 'benekastah/neomake'
NeoBundle 'junegunn/fzf', {'dir': '~/.fzf'}
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'tpop/vim-obsession'

"" Syntax Highlighting
NeoBundle 'chrisbra/csv.vim'
NeoBundle 'ekalinin/Dockerfile.vim'
" NeoBundle 'scrooloose/syntastic'
NeoBundle 'wting/rust.vim'
NeoBundle 'junegunn/rainbow_parentheses.vim'
NeoBundle 'rodjek/vim-puppet'
NeoBundle 'posva/vim-vue'

"" Code Completion
NeoBundle 'Shougo/echodoc.vim'
NeoBundle 'Shougo/deoplete.nvim'
"NeoBundle 'zchee/deoplete-jedi', {'for': 'python'}
"NeoBundle 'davidhalter/jedi-vim', {'for': 'python'}
"NeoBundle 'zchee/deoplete-clang', {'for': 'cpp'}
NeoBundle 'tbodt/deoplete-tabnine', { 'build': {'linux': './install.sh' }}

"" Git Things
NeoBundle 'gregsexton/gitv'

"" Colorschemes
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'chriskempson/base16-vim'

" Vundle End
call neobundle#end()

" Dunno what to call this
filetype plugin indent on
syntax on


" GENERAL VIM SETTINGS

"" Put VIM's temp files somewhere
set backupdir=~/.config/nvim/backups
set directory=~/.config/nvim/swaps
set undodir=~/.config/nvim/undo

"" Highlight the current line
set cursorline
hi CursorLine cterm=none ctermbg=254 guibg=Gray89

"" Show visible tab characters
set list listchars=tab:→\

"" Highlight the current line
set cursorline
hi CursorLine cterm=none ctermbg=254 guibg=Gray89

"" Search Settings
set ignorecase
set hlsearch
set incsearch
set smartcase

"" Tab = 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab

"" Various Things
set number
set title
set showcmd
set ttyfast

"" Easier Window Switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"" Bindings to make my life easier
noremap H ^
noremap L $

"" Rainbow Parantheses
augroup rainbow_parentheses
    autocmd!
    autocmd FileType * RainbowParentheses
augroup END


" LOOK AND FEEL

"" Looks
colorscheme Tomorrow-Night-Eighties
set number
set title
set showcmd

"" Remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/


" PLUGIN SETTINGS

"" braceless
autocmd FileType python BracelessEnable +indent +fold + highlight

"" Deoplete
imap <silent><expr><Tab> pumvisible() ? "\<c-n>"
            \ : (<SID>is_whitespace() ? "\<Tab>"
            \ : deoplete#mappings#manual_complete())
inoremap <expr><S-Tab>  pumvisible() ? "\<c-p>" : "\<c-h>"
function! s:is_whitespace()
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~? '\s'
endfunction
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#enable_refresh_always = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"" Deoplete - Python
let deoplete#sources#jedi#enable_cache = 1
let g:jedi#completions_enabled = 0

"" Deoplete - Clang
let deoplete#sources#clang#enable_cache = 1
let g:deoplete#sources#clang#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/usr/local/opt/llvm/include'
let g:deoplete#sources#clang#std#cpp = 'c++11'

"" Omnicomplete Functions
augroup omnifuncs
    autocmd!
    autocmd FileType python setlocal omnifunc=jedi#completions
    autocmd FileType html let b:deoplete_disable_auto_complete=1
augroup end

"" Echodoc
set cmdheight=2
let g:echodoc_enable_at_startup=1
set completeopt+=menuone
set completeopt-=preview

"" Fugitive
nnoremap ,gs :Gstatus<cr>
nnoremap ,gd :Gdiff<cr>
nnoremap ,gb :Gblame<cr>
nnoremap ,gc :Gcommit<cr>

"" GitGutter Settings
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

"" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_python_enabled_makers = ['pylama']

"" FZF
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
fun! s:fzf_root()
	let l:path = finddir('.git', expand('%:p:h').';')
	return fnamemodify(substitute(l:path, '.git', '', ''), ':p:h')
endfun
nnoremap <silent> <Leader>ff :exe 'Files ' . <SID>fzf_root()<CR>
nnoremap <silent> <Leader>fc :Colors<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>bb :Buffers<CR>
nnoremap <silent> <Leader>; :Commands<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>ll :Lines<CR>
nnoremap <silent> <Leader>lb :BLines<CR>

"" Tmux Navigato
nmap <bs> :<c-u>TmuxNavigateLeft<cr>


" LANGUAGE SETTINGS

"" Web dev stuff
autocmd Filetype html call SetHTMLOptions()
autocmd Filetype htmldjango call SetHTMLOptions()
autocmd Filetype javascript call SetHTMLOptions()
function SetHTMLOptions()
    setlocal shiftwidth=2
    setlocal tabstop=2
endfunction

"" C++ Stuff
autocmd Filetype cpp call SetCPPOptions()
function SetCPPOptions()
    setlocal noexpandtab
endfunction

"" YAML Stuff
autocmd Filetype yaml call SetYAMLOptions()
function SetYAMLOptions()
    set shiftwidth=2
    set tabstop=2
endfunction
