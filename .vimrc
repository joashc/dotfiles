set nocompatible
set shell=/bin/bash

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'lukerandall/haskellmode-vim'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'https://github.com/Lokaltog/vim-easymotion'
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'vim-scripts/YankRing.vim'
Plug 'goldfeld/vim-seek'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'Shougo/neocomplete.vim'
Plug 'Twinside/vim-haskellConceal', { 'for': 'haskell' }
Plug 'travitch/hasksyn', { 'for': 'haskell' }

call plug#end()

" Vim-Latex
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
function SetXeTex()
    let g:Tex_CompileRule_pdf = 'xelatex -aux-directory=~ --synctex=-1 -src-specials -interaction=nonstopmode $*'
endfunction
map <Leader>lb :<C-U>call SetXeTex()<CR>


" Bind save to control s
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
:imap <c-s> <Esc><c-s>

let mapleader=" "
set so=7
set laststatus=2
set foldcolumn=0
set autoread
inoremap jj <Esc>
inoremap kk <Esc>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
set magic
set noswapfile
syntax enable
try
    colorscheme mustang
catch
endtry
set background=dark
set ignorecase
let g:clipbrdDefaultReg = '+'
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '|' }
      \ }

" Bind easymotion to single leaderkey
map <Leader> <Plug>(easymotion-prefix)

" Toggle nerdtree
nnoremap <C-e> :NERDTreeToggle<CR>

" Bind vimseek to s
let g:seek_subst_disable = 1

" Bind control p to T
let g:ctrlp_map = '<s-t>'

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" 

set smartcase
set hlsearch
set incsearch
set noshowmode
set showmatch

set expandtab
set ai "Auto indent
set si "Smart indent
set wrap
map j gj
map k gk
set smarttab
set wrap
set shiftwidth=4
set tabstop=4

map <s-space> ?
map <c-space> ?
set number

" Show bad whitespace
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

nnoremap <silent> n   n:call HLNext(0.1)<cr>
nnoremap <silent> N   N:call HLNext(0.1)<cr>
highlight WhiteOnRed ctermbg=red ctermfg=white
" highlight the match in red
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

nnoremap <silent> <C-h> :<C-u>call ToggleErrors()<CR>

" Delete in normal mode to switch off highlighting till next search
nnoremap <silent> <BS> :nohlsearch <cr>


" Persistent undo
if has('persistent_undo')
    set undodir=$HOME/tmp/.VIM_UNDO_FILES
    set undolevels=5000
    set undofile
endif

hi SpellBad ctermfg=253 ctermbg=8

let g:necoghc_enable_detailed_browse = 1
let g:neocomplete#enable_at_startup = 1
