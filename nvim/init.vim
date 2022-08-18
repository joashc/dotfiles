call plug#begin('~/.local/share/nvim/plugged')

set mouse=a
set hidden
Plug 'rafaqz/ranger.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'vimwiki/vimwiki'
Plug 'lambdalisue/nerdfont.vim'
Plug 'milkypostman/vim-togglelist'
Plug 'udalov/kotlin-vim'
Plug 'jdonaldson/vaxe'
Plug 'arcticicestudio/nord-vim'
Plug 'djoshea/vim-autoread'
Plug 'coyotebush/vim-pweave'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hashivim/vim-terraform'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
Plug 'xuhdev/vim-latex-live-preview', {'for': 'tex'}
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'tomasiser/vim-code-dark'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'hkupty/iron.nvim', { 'do': ':UpdateRemotePlugins', 'for': 'python' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'tpope/vim-speeddating', { 'for': 'org' }
Plug 'vim-scripts/paredit.vim', { 'for': 'clojure' }
Plug 'jceb/vim-orgmode', { 'for': 'org' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'flazz/vim-colorschemes'
Plug 'travitch/hasksyn', { 'for': 'haskell' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'neomake/neomake'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'https://github.com/Lokaltog/vim-easymotion'
call plug#end()
"
" Bind easymotion to single leaderkey
let mapleader=" "
map <Leader><Leader> <Plug>(easymotion-prefix)

autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
}
EOF


:nmap <silent> <c-s-k> :wincmd k<CR>
:nmap <silent> <c-s-j> :wincmd j<CR>
:nmap <silent> <c-s-h> :wincmd h<CR>
:nmap <silent> <c-s-l> :wincmd l<CR>
:nmap <c-s-cr> <Plug>VimwikiTabnewLink
:nmap <c-s> :w<cr>
:nmap <Leader>. <Plug>(coc-codeaction-line)
:nmap <Leader>e :CocList diagnostics<cr>
:nmap <Leader>E :CocDiagnostics<cr>
:nmap <c-p> :CocCommand<cr>
:imap <c-s> <esc>:w<cr>a
:imap <c-s> <esc><c-s>
let g:ctrlp_map = '<s-t>'
nnoremap <s-t> <cmd>Telescope find_files<cr>
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


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


" Remap keys for applying codeAction to the current buffer.
:nmap <silent> <c-Space> :CocAction<CR>
" " Apply AutoFix to problem on the current line.
" nmap <C-.>qf  <Plug>(coc-fix-current)

function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

"nnoremap <silent> <C-n> :<C-u>call ToggleErrors()<CR>

inoremap <silent><expr> <c-.> coc#refresh()

" Delete in normal mode to switch off highlighting till next search
nnoremap <silent> <s-BS> :nohlsearch <cr>

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

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

set history=1000
let g:ctrlp_map = '<s-t>'

set t_Co=256
set t_ut=
colorscheme nord
highlight Comment cterm=italic ctermfg=Gray
highlight htmlArg cterm=italic
hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi LineNr  ctermbg=NONE guibg=NONE
hi EndOfBuffer ctermbg=NONE guibg=NONE

set number
set wildmode=longest,list,full
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox,.stack-work

" Toggle explorer
nnoremap <C-q> :NvimTreeFocus<CR>
nnoremap <C-s-q> :NvimTreeToggle<CR>
set cmdheight=1

set noshowmode

nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>
nnoremap <C-j>  :tabprev<CR>
nnoremap <C-k>  :tabnext<CR>
inoremap <C-j>  <Esc>:tabprev<CR>
inoremap <C-k>  <Esc>:tabnext<CR>
map <Bar> <C-W>v<C-W><Right>
map -     <C-W>s<C-W><Down>

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }


let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

set cursorline


let g:rustfmt_autosave = 1



" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)

set number relativenumber
set nu rnu

set undofile
set undodir=~/.undo


let g:syntastic_always_populate_loc_list = 1

let g:livepreview_engine = 'xelatex'
let g:previm_open_cmd='chromium'

let g:vimwiki_list = [ { 'auto_diary_index': 1 } ]

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

imap <C-l> <Plug>(coc-snippets-expand)

" Symbol renaming.
nmap <silent> gR <Plug>(coc-rename)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

map <leader>rr :RangerEdit<cr>
map <leader>rv :RangerVSplit<cr>
map <leader>rs :RangerSplit<cr>
map <leader>rt :RangerTab<cr>
map <leader>ri :RangerInsert<cr>
map <leader>ra :RangerAppend<cr>
map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
map <leader>rd :RangerCD<cr>
map <leader>rld :RangerLCD<cr>
