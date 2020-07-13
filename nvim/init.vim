call plug#begin('~/.local/share/nvim/plugged')

set mouse=a
set hidden
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
"Plug 'w0rp/ale'
Plug 'OrangeT/vim-csharp', {'for': 'cs'}
Plug 'coyotebush/vim-pweave'
Plug 'xuhdev/vim-latex-live-preview', {'for': 'tex'}
Plug 'vim-syntastic/syntastic'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'tomasiser/vim-code-dark'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'shime/vim-livedown', { 'for': 'markdown' }
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'hkupty/iron.nvim', { 'do': ':UpdateRemotePlugins', 'for': 'python' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs', 'branch': 'type_highlighting' }
Plug 'tpope/vim-speeddating', { 'for': 'org' }
Plug 'vim-scripts/paredit.vim', { 'for': 'clojure' }
Plug 'jceb/vim-orgmode', { 'for': 'org' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'flazz/vim-colorschemes'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'travitch/hasksyn', { 'for': 'haskell' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'kien/ctrlp.vim'
Plug 'neomake/neomake'
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'https://github.com/Lokaltog/vim-easymotion'
Plug 'jistr/vim-nerdtree-tabs' 

call plug#end()
"
" Bind easymotion to single leaderkey
let mapleader=" "
map <Leader> <Plug>(easymotion-prefix)

" bind save to control s
:nmap <c-s> :w<cr>
:imap <c-s> <esc>:w<cr>a
:imap <c-s> <esc><c-s>
let g:ctrlp_map = '<s-t>'
set so=7
set laststatus=2
set foldcolumn=0
set autoread
set visualbell
inoremap jj <Esc>
inoremap kk <Esc>
set magic
set noswapfile
syntax enable
"set background=dark
set ignorecase

exec "set listchars=trail:\uB7\,nbsp:~"

function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

nnoremap <silent> <C-n> :<C-u>call ToggleErrors()<CR>

" Delete in normal mode to switch off highlighting till next search
nnoremap <silent> <BS> :nohlsearch <cr>

nnoremap <silent> ,j :%!jq '.'<CR>:set syntax=json<CR>

let g:clipbrdDefaultReg = '+'
set clipboard=unnamedplus
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

filetype plugin on
set completeopt=longest,menuone,preview
highlight Comment cterm=italic
highlight htmlArg cterm=italic

let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

highlight Comment cterm=italic
highlight htmlArg cterm=italic
set history=1000
let g:ctrlp_map = '<s-t>'

set t_Co=256
set t_ut=
colorscheme codedark
hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi LineNr  ctermbg=NONE guibg=NONE
hi EndOfBuffer ctermbg=NONE guibg=NONE

set number
set wildmode=longest,list,full
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox,.stack-work

" Toggle nerdtree
nnoremap <C-e> :NERDTreeTabsToggle<CR>
set cmdheight=1

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

set noshowmode
nnoremap <C-j>  :tabprev<CR>
nnoremap <C-k>  :tabnext<CR>
map <Bar> <C-W>v<C-W><Right>
map -     <C-W>s<C-W><Down>

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }

set cursorline


let g:rustfmt_autosave = 1


let g:ale_linters = { 'cs': ['OmniSharp'], 'rust': ['rls'] }

augroup omnisharp_commands
    autocmd!

    " When Syntastic is available but not ALE, automatic syntax check on events
    " (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>


    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

set number relativenumber
set nu rnu

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Add syntax highlighting for types and interfaces
nnoremap <Leader>th :OmniSharpHighlightTypes<CR>

let g:OmniSharp_start_server = 0
let g:OmniSharp_port = 2000
let g:OmniSharp_server_use_mono = 1

let g:ale_linters = {'rust': ['rls']}
let g:ale_rust_rls_toolchain='nightly'
let g:syntastic_always_populate_loc_list = 1

let g:racer_cmd = "/home/boo/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:livepreview_engine = 'xelatex'
