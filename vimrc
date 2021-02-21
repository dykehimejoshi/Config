"set runtimepath^=~/.vim runtimepath+=/.vim/after
"let &packpath = &runtimepath

let mapleader = "\<SPACE>"

syntax on
syntax enable

set backupcopy=yes
set backupext=.bak
set lcs=tab:\|\ ,trail:\- 
set expandtab
"set noexpandtab
set background=dark
set noautoindent
set nocindent
set breakindent
set ttimeoutlen=100
set ignorecase
set smartcase
set gdefault
set showmatch
set number
set formatoptions+=otc
set tabstop=4
set shiftwidth=4
set nojoinspaces
set smartindent

if !&scrolloff
	set scrolloff=3
endif

if !&sidescrolloff
	set sidescrolloff=5
endif

set nostartofline
set list
set autochdir

nnoremap ; :
nnoremap <Leader>w :w<CR>
nnoremap <Leader>f :wq<CR>
nnoremap <Leader>e :q!<CR>
nnoremap <Leader>h :set hlsearch!<CR>
