"
" Configuration for Neovim
"

" Initial setup "{{{

if &compatible
    set nocompatible
endif

let s:config_home = expand('$HOME/.config/nvim')

"}}}

" dein.vim "{{{

let s:dein_dir = s:config_home . '/dein.vim'
let s:dein_plugin_dir = s:config_home . '/dein'

let g:dein#install_process_timeout = 3600


exe 'set runtimepath+=' . s:dein_dir

if dein#load_state(s:dein_plugin_dir)
    call dein#begin(s:dein_plugin_dir)

    call dein#add('Shougo/deoplete.nvim')
    call dein#add('w0ng/vim-hybrid')
    call dein#add('scrooloose/nerdtree')
    call dein#add('itchyny/lightline.vim')

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

"}}}

" autocmd "{{{

"autocmd VimEnter * execute 'NERDTree'
autocmd BufWritePre * :%s/\s\+$//ge

"}}}

" setting
filetype plugin indent on
syntax enable
set fenc=utf-8
set autoread
set sh=zsh

au FileType vim setlocal foldmethod=marker
" visual
set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set autoindent
set smartindent
set visualbell

" 括弧の対応付を表示(0.1秒)
set showmatch
set matchtime=1

set laststatus=2
set wildmode=list:longest
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set expandtab
set tabstop=4
set shiftwidth=4

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

set background=dark
colorscheme hybrid

let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
nmap <C-o> :NERDTree<Cr><Esc>

nnoremap Y y$
set display=lastline
nnoremap + <C-a>
nnoremap - <C-x>

" clipboardとregisterの内容を共有
set clipboard+=unnamedplus
