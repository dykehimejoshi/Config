"set runtimepath^=~/.vim runtimepath+=/.vim/after
"let &packpath = &runtimepath

" Formatting
syntax on
syntax enable
set list
set listchars=tab:\|\ ,trail:\-,nbsp:%
set formatoptions+=otc
set tabstop=4
set shiftwidth=4
set nojoinspaces
set smartindent
set expandtab
set autoindent
set cindent
" The following two lines prevent indent from being removed when typing a hash
set cinkeys-=0#
set indentkeys-=0#
set nobreakindent

" Visuals
set showmatch
set matchtime=5
set number
set relativenumber
set background=dark
set ruler
if !&scrolloff
    set scrolloff=3
endif
if !&sidescrolloff
    set sidescrolloff=5
endif

" Search and Replace
set ignorecase
set smartcase
set nogdefault

" Misc
set ttimeoutlen=100
set backupcopy=yes
set backupext=.vim.bak
set startofline
set autochdir
set belloff=all

" Keybinds
let mapleader =

nnoremap ; :
nnoremap <Leader>w :w<CR>
nnoremap <Leader>f :wq<CR>
nnoremap <Leader>e :q!<CR>
nnoremap <Leader>h :set hlsearch!<CR>

" set the backspace to delete normally
set backspace=indent,eol,start

vmap <Tab> >V
vmap <S-Tab> <V
