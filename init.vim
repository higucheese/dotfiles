"
" Configuration for Neovim
"

" Initial setup "{{{

if &compatible
    set nocompatible
endif

" Set autocmd group.
augroup MyAutoCmd
    autocmd!
    augroup END


let s:config_home = expand('$HOME/.config/nvim')

"}}}

" dein.vim "{{{

let s:dein_dir = s:config_home . '/dein.vim'
let s:dein_plugin_dir = s:config_home . '/dein'

let g:dein#install_process_timeout = 3600


exe 'set runtimepath+=' . s:dein_dir

if dein#load_state(s:dein_plugin_dir)
    call dein#begin(s:dein_plugin_dir)

    call dein#add('Shougo/unite.vim')
    call dein#add('Shougo/vimfiler.vim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/unite-outline')
    call dein#add('Shougo/neossh.vim')
    call dein#add('itchyny/lightline.vim')
    call dein#add('w0ng/vim-hybrid')
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('morhetz/gruvbox')
    call dein#add('tomasr/molokai')
    call dein#add('vim-scripts/gtags.vim')

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

"}}}

filetype plugin on
filetype plugin indent off
syntax enable

" Swap, backup and undo "{{{
set swapfile
exe 'set directory=' . s:config_home . '/swap'
set backup
exe 'set backupdir=' . s:config_home . '/backup'

" Note: This feature has a bug in Neovim 0.1.0
if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/undo
endif
"}}}

" Built-in features "{{{

" Enable hidden buffers.
set hidden

" Automatic reloading.
set autoread

" Share the clipboard with other applications.
if has("clipboard")
    set clipboard^=unnamedplus
    set clipboard^=unnamed
end

" Enable incremental search.
set incsearch
" Enable highlighting during searching.
set hlsearch

" Enables ignoring case.
set ignorecase
" Enables smartcase.
set smartcase

" File name completion
set wildmenu
set wildmode=list:longest,full

" Show the line number.
set number

" Set the height of command line.
set cmdheight=1

" Always show the status bar.
set laststatus=2


" Disable the beep.
set vb t_vb=

" Keep the visual mode on indentation.
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" Keep the correct indent despite blank lines. {{{
nnoremap o oX<C-h>
nnoremap O OX<C-h>
inoremap <CR> <CR>X<C-h>
" }}}

" Show tabs and new-lines.
set list
set listchars=tab:▸\ ,eol:¬

" Force :make to use the option --print-directory.
set makeprg=make\ -w

" Disable completeopt.
set completeopt=menuone

" Do not jump to first character with page commands.
"set nostartofline

" Disable automatic comment insertion.
autocmd MyAutoCmd FileType * setlocal formatoptions-=ro

" Enable mouse for all modes.
set mouse=a

"}}}

" Indent "{{{

set tabstop=4
set softtabstop=4
set shiftwidth=4

set autoindent
set expandtab

"}}}

" Key Bindings "{{{

" [Space] Smart space mapping. "{{{
nmap  <Space>   [Space]
xmap  <Space>   [Space]
nnoremap  [Space]   <Nop>
xnoremap  [Space]   <Nop>
"}}}

" Ctrl + Shift + Arrow : Resize window "{{{
nnoremap <silent> <C-S-Left>    :vertical resize -5<cr>
nnoremap <silent> <C-S-Right>   :vertical resize +5<cr>
nnoremap <silent> <C-S-Up>      :resize -2<cr>
nnoremap <silent> <C-S-Down>    :resize +2<cr>
" }}}

" Key Bindings for Command-line mode "{{{

" <C-a>, A: move to head.
cnoremap <C-a>          <Home>
" <C-b>: previous char.
cnoremap <C-b>          <Left>
" <C-d>: delete char.
cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
cnoremap <C-f>          <Right>
" <C-n>: next history.
cnoremap <C-n>          <Down>
" <C-p>: previous history.
cnoremap <C-p>          <Up>
" <C-k>, K: delete to end.
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
      \ '' : getcmdline()[:getcmdpos()-2]<CR>
      " <C-y>: paste.
cnoremap <C-y>          <C-r>*

"}}}

" [Space]t : Spawn a new terminal.
nnoremap <silent> [Space]t
\ :rightb 17sp +terminal<CR>
\ :startinsert<CR>

" Escape from the terminal window.
tnoremap <Esc> <C-\><C-n>

" Ctrl + s : Save the current file
nnoremap <silent> <C-S> :<C-u>update<CR>
inoremap <silent> <C-S> <C-o>:<C-u>update<CR>

" Ctrl + j : Jump using Gtags.
nnoremap <silent> <C-J> :<C-u>GtagsCursor<CR>
inoremap <silent> <C-J> <C-o>:<C-u>GtagsCursor<CR>

" [Space]c : Change the current directory to the opened file.
nnoremap <silent>   [Space]c  :<C-u>cd %:p:h<CR>:<C-u>pwd<CR>

" Disable the default action of F1 to show help (to prevent mistype)
nmap <F1> <nop>
imap <F1> <nop>

"}}}

" Folding "{{{

set nofoldenable
set foldmethod=syntax
set commentstring=%s

noremap [fold]     <Nop>
nmap    [Space]f [fold]
vmap    [Space]f [fold]

" Move over foldings.
noremap [Space]j    zj
noremap [space]k    zk

" Toggle.
noremap [fold]f    za
" [H]ide all foldings
noremap [fold]h    zM
" [S]how all foldings
noremap [fold]s    zR
" [M]ake a folding.
noremap [fold]m    zm
" [D]elete a folding.
noremap [fold]d    zd

" Ctrl + H : Toggle the folding.
noremap <C-H>   za

" [Space]r : reload neovim configuration.
nnoremap <silent> [Space]r  :<C-u>source $MYVIMRC<CR>

" :RemoveSwap : Remove all swap files. {{{
function! s:remove_swapfiles()
    let list = split(glob(s:config_home . "/swap/*"), "\n")
        for file in list
        echo file
        call delete(file)
    endfor
endfunction
command! -nargs=0 RemoveSwap  call s:remove_swapfiles()
" }}}

" VimFiler "{{{

" Replace netrw.
let g:vimfiler_as_default_explorer = 1

" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
if has('gui_running')
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
else
    let g:vimfiler_tree_opened_icon = 'V'
    let g:vimfiler_tree_closed_icon = '>'
endif
let g:vimfiler_file_icon = '-'
"
" [Space]x : Open the VimFiler with explorer-like style.
nnoremap <silent> [Space]x
\ :VimFilerSimple -buffer-name=explorer -toggle -no-quit<CR>
\ :vertical resize 25<CR>
\ :setlocal winfixwidth<CR>
\ :setlocal nonumber<CR>

"}}}

" Denite "{{{

" [Space]b : Show buffers.
nnoremap <silent> [Space]b  :<C-u>Denite buffer<CR>

"}}}

" Unite "{{{

" [Space]o: Show outline.
nnoremap <silent> [Space]o  :<C-u>Unite -buffer-name=outline outline<CR>

"}}}

" Styles "{{{

" Enable syntax highlighting.
syntax on

" Use the dark background by default.
set background=dark

"colorscheme desert

let g:hybrid_custom_term_colors = 1
"let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
"colorscheme hybrid

"}}}

" vim: foldmethod=marker
