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
set showcmd

" Keybinds

let mapleader = "\<SPACE>"
nnoremap ; :

"" Run Python scripts
autocmd FileType python map <buffer> <C-r> :w<CR>:exec '!/usr/bin/env python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <C-r> <esc>:w<CR>:exec '!/usr/bin/env python3' shellescape(@%, 1)<CR>

"" Run Javascript scripts
autocmd FileType javascript map <buffer> <C-r> :w<CR>:exec '!/usr/bin/env node' shellescape(@%, 1)<CR>
autocmd FileType javascript imap <buffer> <C-r> <esc>:w<CR>:exec '!/usr/bin/env node' shellescape(@%, 1)<CR>

"" Run Shell scripts
autocmd FileType sh map <buffer> <C-r> :w<CR>:exec '!/bin/bash' shellescape(@%, 1)<CR>
autocmd FileType sh imap <buffer> <C-r> <esc>:w<CR>:exec '!/bin/bash' shellescape(@%, 1)<CR>

"" Move to the beginning of the line in insert mode
inoremap <C-k> <ESC>0i

"" Move to the end of the line in insert mode
inoremap <C-l> <ESC>$a

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

"" xxd
let g:ishex = 0 " off by default
function Hex()
    let g:ishex = !g:ishex
    if g:ishex
        " this is where we convert the program into xxd
        call feedkeys(":w\<CR>:%!xxd\<CR>")
    else
        " convert back into text
        call feedkeys(":%!xxd -r\<CR>:w\<CR>")
    endif
endfunction
map <C-b> <ESC>:call Hex()<CR>

"" Misc
nnoremap <Leader>h :set hlsearch!<CR>
nnoremap <C-h> :set hlsearch!<CR>
vmap <Tab> >V
vmap <S-Tab> <V
