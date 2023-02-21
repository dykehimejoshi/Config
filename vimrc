" vimrc

set nocompatible

" Formatting
syntax on
syntax enable
set list
set listchars=tab:\|\ ,trail:\-,nbsp:%
set formatoptions=tcoql
set matchpairs+=<:>
set tabstop=4
set softtabstop=4
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

"" Folding
set foldenable
set foldlevelstart=10
set foldmethod=indent
set fdc=1

" Visuals
set showmatch
set matchtime=5
set relativenumber
set background=dark
set ruler
set conceallevel=2
set scrolloff=22 " stay around the middle of the screen while scrolling vertically
set sidescrolloff=5
set nowrap
set laststatus=2
set colorcolumn=81
if &t_Co == 8
    highlight ColorColumn ctermbg=7
else
    highlight ColorColumn ctermbg=8
endif

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
set spelllang=en_us
set nospell

"" File Browsing (youtu.be/XA2WjJbmmoM)
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\$\+'
" :edit a folder to open in a file browser
" <CR>, v, or t to open in an h-split, v-split, or tab
" check |netrw-browse-maps| for more mappings

"" Finding Files (re: link above)
set path+=**
set wildmenu

"" set the backspace to delete normally
set backspace=indent,eol,start

" Keybinds

" temporary keybinds for until the muscle memory of C-e is no more
nnoremap <C-e>q <Esc>
nnoremap <C-e> <Esc>
inoremap <C-e> <Esc>

let mapleader = ","
noremap ; :

"" Change the redo keybind (`u' is already undo)
nnoremap <S-u> :redo<CR>

"" Folding
nnoremap <Leader>f za

"" Moving lines
nnoremap K :m -2<CR>
nnoremap J :m +1<CR>
" todo: visual mode

"" autocmd
if has('autocmd')
    "" set certain options for some text-based filetypes
    autocmd FileType markdown call TextSettings()
    autocmd FileType css call CssSettings()
    autocmd FileType text call TextSettings()
    autocmd FileType make call MakeSettings()
    autocmd FileType *html call HtmlSettings()

    "" set certain options for filetypes of programming languages
    autocmd FileType python call PythonSettings()
    autocmd FileType c call CSettings()
    autocmd FileType cpp call CPPSettings()
    autocmd FileType vim call VimSettings()
    autocmd FileType java call JavaSettings()
    autocmd FileType javascript call JavaScriptSettings()
    autocmd FileType arduino call ArduinoSettings()
    autocmd FileType *sh call ShSettings()
    autocmd FileType json call ProgrammingSettings()

    "" source vimrc after editing it
    autocmd BufWritePost *vimrc autocmd! | source %

    "" Run Python scripts
    autocmd FileType python noremap <buffer> <Leader>r :w<CR>:exec '!/usr/bin/env python3' shellescape(@%, 1)<CR>
"    autocmd FileType python inoremap <buffer> <Leader>r <esc>:w<CR>:exec '!/usr/bin/env python3' shellescape(@%, 1)<CR>

    "" Run Javascript scripts
    autocmd FileType javascript noremap <buffer> <Leader>r :w<CR>:exec '!/usr/bin/env node' shellescape(@%, 1)<CR>
"    autocmd FileType javascript inoremap <buffer> <Leader>r <esc>:w<CR>:exec '!/usr/bin/env node' shellescape(@%, 1)<CR>

    "" Run Shell scripts
    autocmd FileType *sh noremap <buffer> <Leader>r :w<CR>:exec '!/usr/bin/env bash' shellescape(@%, 1)<CR>
"    autocmd FileType *sh inoremap <buffer> <Leader>r <esc>:w<CR>:exec '!/bin/bash' shellescape(@%, 1)<CR>

    "" zsh scripts
    autocmd FileType zsh noremap <buffer> <Leader>r :w<CR>:exec '!/usr/bin/env zsh' shellescape(@%, 1)<CR>

    "" Show HTML Files
    autocmd FileType *html noremap <buffer> <Leader>r :w<CR>:exec '!/usr/bin/env firefox file://' . expand("%:p:h") . '/' . shellescape(@%, 1)<CR>

    "" Show markdown files (uses Calibre's ebook-viewer)
    autocmd FileType markdown noremap <buffer> <Leader>r :w<CR>:exec '!/usr/bin/ebook-viewer --raise-window --detach' shellescape(@%, 1)<CR><CR>

    "" Run makefiles
    autocmd FileType make nnoremap <buffer> <Leader>r :w<CR>:exec '!make'<CR>

    "" Compile and upload arduino .ino sketches (requires arduino-cli and the core set up beforehand)
    autocmd FileType arduino nnoremap <buffer> <Leader>r :w<CR>:exec '! cmd="$(arduino-cli board list)"; [ \! "$cmd" = "No boards found." ] && arduino-cli compile --fqbn $(echo $cmd \| cut -d " " -f 12) && arduino-cli upload -p $(echo $cmd \| cut -d " " -f 1 \| tail -n 1 \| tr -d "\n") --fqbn $(echo $cmd \| cut -d " " -f 12)'<CR>
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
imap <C-s> <ESC>:w<CR>a
nmap <C-s> :w<CR>
"" Saving and not exiting with the map leader
"" TODO maybe not have this in insert mode?  will try it out and see
imap <Leader>s <ESC>:w<CR>a
nmap <Leader>s :w<CR>

"" Saving and exiting
nnoremap <Leader>x :wq<CR>
"inoremap <Leader>x <ESC>:wq<CR>

"" Exiting without saving
noremap <Leader>q :q!<CR>

"" Editing with multiple files
""" Next
nnoremap <Leader>n :n<CR>
"inoremap <Leader>n <ESC>:w<CR>:n<CR>
""" Previous
nnoremap <Leader>p :N<CR>
"inoremap <Leader>p <ESC>:w<CR>:N<CR>

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

function! FixHex()
    " Useful for if you accidentally save while editing the hex, this reverts
    " the hex back to code
    let g:ishex = 1
    call Hex()
endfunction

"" Make copying from tmux easier
function! ToggleMargin()
    set relativenumber!
    let nextfdc=!&fdc
    let &foldcolumn=nextfdc
    if nextfdc == 1
        set listchars=tab:\|\ ,trail:\-,nbsp:%
    else
        set listchars=tab:\ \ ,trail:\ ,nbsp:\ 
    endif
endfunction

nnoremap <Leader>c :call ToggleMargin()<CR>

"" Misc
nnoremap <Leader>h :set hlsearch!<CR>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" wrap highlighted text with html/markdown stuff
vnoremap <Leader>ws c<sub><C-r>"</sub><ESC>
vnoremap <Leader>wS c<sup><C-r>"</sup><ESC>
vnoremap <Leader>wb c**<C-r>"**<ESC>
vnoremap <Leader>wi c*<C-r>"*<ESC>
" parens/brackets/etc
vnoremap <Leader>w( c(<C-r>")<ESC>
vnoremap <Leader>w[ c[<C-r>"]<ESC>
vnoremap <Leader>w< c<<C-r>"><ESC>


"" Functions for different filetypes

function! TextSettings()
    " settings for markdown, css
    setlocal nocindent
    setlocal expandtab
endfunction

function! ProgrammingSettings()
    " settings for various programming languages
    setlocal softtabstop=4
    ab ube #!/usr/bin/env
    set conceallevel=0
endfunction

function! CssSettings()
    call TextSettings()
    ab debug background-color: #f00
endfunction

function! MakeSettings()
    setlocal noexpandtab
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction

function! PythonSettings()
    call ProgrammingSettings()
    call CommentHash()
    ab ifnamemain if __name__ == "__main__":
    ab debug print("XXX")
endfunction

function! ShSettings()
    call ProgrammingSettings()
    call CommentHash()
    ab debug echo "XXX"
endfunction

function! CSettings()
    call ProgrammingSettings()
    call CommentDoubleSlash()
    ab cmainargs int main(int argv, char **argv)
    ab cmainvoid int main(void)
    ab debug printf("XXX\n")
    function! IfndefGuards()
        call feedkeys("ggi#ifndef " . expand("%:t:r") . "_H\<ESC>vBUo#define " . expand("%:t:r") . "_H\<ESC>vBUGo#endif\<ESC>ggjo\<ESC>")
    endfunction
endfunction

function! CPPSettings()
    call CSettings()
endfunction

function! JavaSettings()
    call ProgrammingSettings()
    call CommentDoubleSlash()
    ab psvm public static void main(String[] args)
    ab debug System.out.println("XXX")
endfunction

function! JavaScriptSettings()
    call ProgrammingSettings()
    call CommentDoubleSlash()
    ab debug console.log("XXX")
endfunction

function! ArduinoSettings()
    call ProgrammingSettings()
    call CommentDoubleSlash()
endfunction

function! VimSettings()
    call ProgrammingSettings()
    call CommentQuote()
endfunction

function! HtmlSettings()
    call TextSettings()
    setlocal softtabstop=2
endfunction

"" Functions to call for languages with different commenting styles

function! CommentHash()
    " #
    nnoremap # 0i#<Esc>
    nnoremap & ^x<Esc>
endfunction

function! CommentDoubleSlash()
    " //
    nnoremap # 0i//<Esc>
    nnoremap & ^2x<Esc>
endfunction

function! CommentQuote()
    " "
    nnoremap # 0i"<Esc>
    nnoremap & ^x<Esc>
endfunction
