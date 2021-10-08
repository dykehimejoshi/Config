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
set conceallevel=2
set scrolloff=22
set sidescrolloff=5

" Search and Replace
set ignorecase
set smartcase
set nogdefault
set incsearch

" Misc
set ttimeoutlen=100
set backupcopy=yes
set backupext=.vim.bak
set startofline
set belloff=all
set showcmd

"" set the backspace to delete normally
set backspace=indent,eol,start

" Keybinds

let mapleader = "\<SPACE>"
noremap ; :

"" Change the redo keybind (`u' is already undo)
nnoremap <S-u> :redo<CR>

"" autocmd
if has('autocmd')
    "" set certain options for some text-based filetypes
    autocmd FileType markdown call TextSettings()
    autocmd FileType css call TextSettings()

    "" source vimrc after editing it
    autocmd BufWritePost *vimrc autocmd! | source %

    "" Run Python scripts
    autocmd FileType python noremap <buffer> <C-r> :w<CR>:exec '!/usr/bin/env python3' shellescape(@%, 1)<CR>
    autocmd FileType python inoremap <buffer> <C-r> <esc>:w<CR>:exec '!/usr/bin/env python3' shellescape(@%, 1)<CR>

    "" Run Javascript scripts
    autocmd FileType javascript noremap <buffer> <C-r> :w<CR>:exec '!/usr/bin/env node' shellescape(@%, 1)<CR>
    autocmd FileType javascript inoremap <buffer> <C-r> <esc>:w<CR>:exec '!/usr/bin/env node' shellescape(@%, 1)<CR>

    "" Run Shell scripts
    autocmd FileType sh noremap <buffer> <C-r> :w<CR>:exec '!/bin/bash' shellescape(@%, 1)<CR>
    autocmd FileType sh inoremap <buffer> <C-r> <esc>:w<CR>:exec '!/bin/bash' shellescape(@%, 1)<CR>

    "" Show HTML Files
    autocmd FileType *html noremap <buffer> <C-r> :w<CR>:exec '!/usr/bin/env firefox file://' . expand("%:p:h") . '/' . shellescape(@%, 1)<CR>

    "" Show markdown files (uses Calibre's ebook-viewer)
    autocmd FileType markdown noremap <buffer> <C-r> :w<CR>:exec '!/usr/bin/ebook-viewer --raise-window --detach' shellescape(@%, 1)<CR><CR>
endif " has autocmd

"" Tabs
""" Moving tabs: gt for next, gT for previous
""" If in a split window, <C-w>T (capital T) opens current split in new tab
""" Open a new tab (tc for "tab create")
nnoremap <C-w>tc :tabnew<CR>
""" Close the current tab (tq for "tab quit")
nnoremap <C-w>tq :tabclose<CR>
""" Move a tab
nnoremap <C-w>tm :tabmove 

"" Windows
""" Keybinds to reflect my tmux.conf file
nnoremap <C-w>/ :vsplit<CR>
nnoremap <C-w>" :split<CR>

"" Saving and not exiting
inoremap <C-s> <ESC>:w<CR>a
nnoremap <C-s> :w<CR>

"" Saving and exiting
nnoremap <C-x> :wq<CR>
inoremap <C-x> <ESC>:wq<CR>

"" Exiting without saving
noremap <C-e>q :q!<CR>
"noremap <C-e><C-q> :q!<CR>
nnoremap <Leader>e :q!<CR>

"" Editing with multiple files
""" Next
nnoremap <C-n> :n<CR>
inoremap <C-n> <ESC>:w<CR>:n<CR>
""" Previous
nnoremap <C-p> :N<CR>
inoremap <C-p> <ESC>:w<CR>:N<CR>

"" xxd
"" interesting for reverse engineering but not really that useful
let g:ishex = 0 " off by default
function! Hex()
    let g:ishex = !g:ishex
    if g:ishex
        " this is where we convert the program into xxd
        call feedkeys(":w\<CR>:%!xxd\<CR>")
    else
        " convert back into text
        call feedkeys(":%!xxd -r\<CR>:w\<CR>")
    endif
endfunction
"map <F3> <ESC>:call Hex()<CR>

"" Misc
nnoremap <Leader>h :set hlsearch!<CR>
nnoremap <C-h> :set hlsearch!<CR>
vnoremap <Tab> >V
vnoremap <S-Tab> <V

"" Functions

function! TextSettings()
    setlocal nocindent
    setlocal expandtab
endfunction
