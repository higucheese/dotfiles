"
" Configuration for vim
"

" autocmd {{{
autocmd BufWritePre * :%s/\s\+$//ge
" }}}
" setting
syntax enable
set fenc=utf-8
set autoread

" visual
set number
set cursorline
"set cursorcolumn
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
set list
set expandtab
set tabstop=4
set shiftwidth=4

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

nmap <Esc><Esc> :nohlsearch<CR><Esc>

colorscheme elflord

" Move to a previous position when opening file
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
