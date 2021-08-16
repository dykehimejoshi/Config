"set runtimepath^=~/.vim runtimepath+=/.vim/after
"let &packpath = &runtimepath

set nocompatible

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

let mapleader = "\<SPACE>"
nnoremap ; :

"" Saving and not exiting
inoremap <C-s> <ESC>:w<CR>a
noremap <C-s> :w<CR>

"" Saving and exiting
nnoremap <C-x> :wq<CR>
inoremap <C-x> <ESC>:wq<CR>

"" Exiting without saving
noremap <C-e>q :q!<CR>
noremap <C-e><C-q> :q!<CR>
nnoremap <Leader>e :q!<CR>

"" Editing with multiple files
""" Next
nnoremap <C-n> :n<CR>
inoremap <C-n> <ESC>:w<CR>:n<CR>
""" Previous
nnoremap <C-p> :N<CR>
inoremap <C-p> <ESC>:w<CR>:N<CR>

"" set the backspace to delete normally
set backspace=indent,eol,start

"" Misc
nnoremap <Leader>h :set hlsearch!<CR>
nnoremap <C-h> :set hlsearch!<CR>
vmap <Tab> >V
vmap <S-Tab> <V
