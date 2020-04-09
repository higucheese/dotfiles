"
" Configuration for Neovim
"

if &compatible
    set nocompatible
endif

let s:config_home = expand('$HOME/.config/nvim')

let s:dein_dir = s:config_home . '/dein.vim'
let s:dein_plugin_dir = s:config_home . '/dein'
let g:dein#install_process_timeout = 3600

exe 'set runtimepath+=' . s:dein_dir

if dein#load_state(s:dein_plugin_dir)
    call dein#begin(s:dein_plugin_dir)

    call dein#add('w0ng/vim-hybrid')
    call dein#add('itchyny/lightline.vim')
    call dein#add('rhysd/vim-clang-format')
    call dein#add('kana/vim-operator-user')

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

" Settings of clang-format
let g:clang_format#code_style = 'google'
let g:clang_format#style_options = {
            \'AccessModifierOffset': '-4',
            \'ColumnLimit': '140',
            \'IndentWidth': '4',
            \'DerivePointerAlignment': 'false',
            \'PointerAlignment': 'Left',
            \'IncludeBlocks': 'Preserve',
            \'AllowShortFunctionsOnASingleLine': 'None'}

set title
set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set autoindent
set smartindent
set visualbell
set autochdir

" Show the other parenthesis
set showmatch

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

" Share contents between register and clipboard
set clipboard+=unnamedplus

let g:tex_flavor = "latex"
autocmd FileType tex set nowrap

autocmd FileType tex set spell
autocmd FileType markdown set spell
autocmd FileType text set spell

" Disable automatic insertions of a comment header
setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Settings for Japanese
set spelllang=en_us,cjk " No spell check for Japanese
setlocal formatoptions+=mM
if exists('&amiwidth') " Set a width of some charactors
    set ambiwidth=double
endif

" Emphasize white spaces in the end of a line
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

filetype plugin indent on
syntax enable
set fenc=utf-8
set sh=zsh

" Automatically update a local buffer when its file is updated
set autoread

" syntax-highlight setting
au BufReadPost *.pxi set syntax=python
au BufReadPost *.inc set syntax=make
au BufReadPost *.vsm set syntax=vsm
au FileType vim setlocal foldmethod=marker

