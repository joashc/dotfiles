set nocompatible
set shell=/bin/bash
set mouse=a
set ttymouse=xterm2

call plug#begin('~/.vim/plugged')

Plug 'felixhummel/setcolors.vim'
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'
Plug 'leafgarland/typescript-vim'
Plug 'glittershark/vim-hare'
Plug 'tpope/vim-dispatch'
Plug 'mhinz/vim-startify'
Plug 'jceb/vim-orgmode', { 'for': 'org' }
Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx' }
Plug 'flowtype/vim-flow', { 'for': 'javascript.jsx' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'Raimondi/delimitMate'
Plug 'junegunn/goyo.vim'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'https://github.com/Lokaltog/vim-easymotion'
Plug 'pangloss/vim-javascript', { 'for': 'javascript.jsx' }
Plug 'jaxbot/syntastic-react', { 'for': 'javascript.jsx' }
Plug 'vim-scripts/YankRing.vim'
Plug 'justinmk/vim-sneak'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'kien/ctrlp.vim'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Shougo/neocomplete.vim'
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' }
Plug 'travitch/hasksyn', { 'for': 'haskell' }

call plug#end()

let g:flow#autoclose = 1

let g:jsx_ext_required = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint', 'tsc']

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
    colorscheme candycode
catch
endtry
set background=dark
set ignorecase

let g:clipbrdDefaultReg = '+'
set clipboard=unnamedplus,autoselect

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '|' }
      \ }

" Bind easymotion to single leaderkey
map <Leader> <Plug>(easymotion-prefix)

" Toggle nerdtree
nnoremap <C-e> :NERDTreeToggle<CR>

" Bind vimseek to s
let g:seek_subst_disable = 1

" Bind control p to T
let g:ctrlp_map = '<s-t>'
set wildignore+=*/node_modules/*

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
set shiftwidth=2
set tabstop=2

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

set guifont=Meslo\ LG\ M\ for\ Powerline:h18


" Persistent undo
if has('persistent_undo')
    set undodir=$HOME/tmp/.VIM_UNDO_FILES
    set undolevels=5000
    set undofile
endif

hi SpellBad ctermfg=253 ctermbg=8

let g:necoghc_enable_detailed_browse = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

set go-=M
set go-=m
set go-=T
set go-=r
set go-=L
set go-=f
set go-=F
set go-=b

highlight Comment cterm=italic
highlight htmlArg cterm=italic

set history=1000
set wildmode=longest,list,full
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox,.stack-work
set completeopt+=longest

set cmdheight=1

let hscoptions="shtD𝐒𝐓𝐄𝐌𝔻"
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
