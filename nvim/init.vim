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
    call dein#add('Shougo/unite.vim')
    call dein#add('Shougo/vimfiler.vim')
    call dein#add('w0ng/vim-hybrid')
    call dein#add('itchyny/lightline.vim')

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

if dein#tap('deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
endif

let g:vimfiler_as_default_explorer = 1

"}}}

" 日本語用の設定
setlocal formatoptions+=mM " 連結時に空白を入れない
set spelllang=en_us,cjk    " 日本語はスペルチェックをしない
if exists('&amiwidth')     " 記号でカーソル位置がずれないように
    set ambiwidth=double
endif

" 行末のスペースを削除する
autocmd BufWritePre * :%s/\s\+$//ge

" setting
filetype plugin indent on
syntax enable
set fenc=utf-8
set autoread
set sh=zsh

au FileType vim setlocal foldmethod=marker
" visual
set title
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

nnoremap Y y$
set display=lastline
nnoremap + <C-a>
nnoremap - <C-x>

" clipboardとregisterの内容を共有
set clipboard+=unnamedplus

" tex
autocmd FileType tex set wrap

" spell check
autocmd FileType tex set spell
autocmd FileType markdown set spell
autocmd FileType text set spell

" Disable automatic command insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
