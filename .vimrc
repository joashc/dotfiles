set nocompatible
set shell=/bin/bash

" Vundle needs bash to work
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'itchyny/lightline.vim'
Bundle 'tpope/vim-surround'
Bundle 'https://github.com/Lokaltog/vim-easymotion'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'goldfeld/vim-seek'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'eagletmt/neco-ghc'
Bundle 'Shougo/neocomplete.vim'
Bundle 'dag/vim2hs'

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
set clipboard=unnamedplus
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

" Toggles syntastic error window

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
" Highlights 81st char of each line
"highlight ColorColumn ctermbg=blue
"call matchadd('ColorColumn', '\%81v', 100)

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

let g:necoghc_enable_detailed_browse = 1
let g:neocomplete#enable_at_startup = 1
