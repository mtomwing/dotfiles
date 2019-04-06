set clipboard+=unnamedplus
filetype off

" Python Interpreter
let g:python_host_prog = expand('~/.virtualenvs/neovim2/bin/python')
let g:python3_host_prog = expand('~/.virtualenvs/neovim3/bin/python')

" Dein Setup
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/dein')
    call dein#begin('~/.config/nvim/dein')

    call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    "" General
    call dein#add('wsdjeg/dein-ui.vim')
    call dein#add('Lokaltog/vim-easymotion')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('bitc/vim-bad-whitespace')
    call dein#add('bling/vim-airline')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-unimpaired')
    call dein#add('tweekmonster/braceless.vim')
    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('tpop/vim-obsession')
    call dein#add('ctrlpvim/ctrlp.vim')

    "" Snippets
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')

    "" Syntax Highlighting
    call dein#add('chrisbra/csv.vim')
    call dein#add('ekalinin/Dockerfile.vim')
    call dein#add('wting/rust.vim')
    call dein#add('junegunn/rainbow_parentheses.vim')
    call dein#add('rodjek/vim-puppet')
    call dein#add('posva/vim-vue')
    call dein#add('w0rp/ale')

    "" Code Completion
    call dein#add('Shougo/echodoc.vim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('tbodt/deoplete-tabnine', {'build': './install.sh'})
    call dein#add('deoplete-plugins/deoplete-go', {'build': 'make'})
    call dein#add('fatih/vim-go')

    "" Git Things
    call dein#add('gregsexton/gitv')

    "" Colorschemes
    call dein#add('chriskempson/vim-tomorrow-theme')
    call dein#add('chriskempson/base16-vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" PLUGINS


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

"" Tmux Navigato
nmap <bs> :<c-u>TmuxNavigateLeft<cr>

"" w0rp/ale
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1


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

""" Python Stuff
autocmd Filetype python call SetPythonOptions()
function SetPythonOptions()

endfunction

"" Golang Stuff
autocmd Filetype go call SetGolangOptions()
function SetGolangOptions()
    " Indentation
    set noexpandtab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4

    " Pretty colours
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_types = 1

    " Highlight same identifiers
    let g:go_auto_sameids = 1

    " Automatically include imports
    let g:go_fmt_command = "goimports"

    " Show types
    let g:go_auto_type_info = 1

    noremap <Leader>d :GoDef<CR>
endfunction
