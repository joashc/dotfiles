set nocompatible
set shell=/bin/bash
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'itchyny/lightline.vim'
Bundle 'tpope/vim-surround'
Bundle 'https://github.com/Lokaltog/vim-easymotion'
Bundle 'jelera/vim-javascript-syntax'

set showcmd
let mapleader=","
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

set smartcase
set hlsearch
set incsearch

set showmatch

set expandtab
set ai "Auto indent
set si "Smart indent
set wrap
map j gj
map k gk
set smarttab
map 0 ^
set wrap
set shiftwidth=4
set tabstop=4

map <space> /
map <c-space> ?
set relativenumber

" Highlights 81st char of each line
highlight ColorColumn ctermbg=blue
call matchadd('ColorColumn', '\%81v', 100)

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


" Delete in normal mode to switch off highlighting till next search
nnoremap <silent> <BS> :nohlsearch <cr>

" Persistent undo
if has('persistent_undo')
    set undodir=$HOME/tmp/.VIM_UNDO_FILES
    set undolevels=5000
    set undofile
endif

" Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
vmap <BS> x
