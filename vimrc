"set runtimepath^=~/.vim runtimepath+=/.vim/after
"let &packpath = &runtimepath

" Formatting
syntax on
syntax enable
set list " Shows tabs as CTRL-I is displayed
set listchars=tab:\|\ ,trail:\-,nbsp:% " comma-separated string settings for 'list'
set formatoptions+=otc " Describes how automatic formatting is done.
                       " t = autowrap text using textwidth;
                       " c = autowrap comments using textwidth, inserting the current comment leader automatically
                       " o = automatically insert the current comment leader after using 'o' or 'O' in normal mode
                       " `:help fo-table` for more
set tabstop=4 " Number of spaces a tab counts for.
set shiftwidth=4 " Number of spaces to use for each step of [auto]indent
set nojoinspaces " (Does not) insert two spaces after a '.', '?', and '!' with a join command.
set smartindent " Do smart autoindenting when starting a new line.
set expandtab " In insert mode: use spaces instead of tabs.
set autoindent " Copy indent from current line when starting a new line
set cindent " Enables automatic C program indenting.
" The following two lines prevent indent from being removed when typing a hash ("#")
set cinkeys-=0#
set indentkeys-=0#
set nobreakindent " Every wrapped line will (not) continue visually indented.

" Visuals
set showmatch " When a bracket is inserted, briefly jump to the matching one only if the match can be seen on-screen.
set matchtime=5 " Tenths of a second to show the matching parenthesis when 'showmatch' is set.
set number " Show line numbers.
set relativenumber " Changes displayed number to be relative to the cursor
set background=dark " Use colors that look good on the specified ('light', 'dark') background.
if !&scrolloff
    set scrolloff=3 " Minimal number of screen lines to keep above and below the cursor.
endif
if !&sidescrolloff
    set sidescrolloff=5 " Minimul number of screen columns to keep to the left and right of the cursor if 'nowrap' is set.
endif

" Search and Replace
set ignorecase " Ignore case in search patterns.
set smartcase " Override 'ignorecase' if the search pattern contains uppercase characters.
set nogdefault " When on, the ":substitute" flag 'g' is default on; meaning, all matches in a line are substituted instead of one.

" Misc
set ttimeoutlen=100 " Time in ms that is waited for a key code or mapped key sequence to complete.
set backupcopy=yes " Determines how backups are made when writing a file.
set backupext=.vim.bak " String to be appended to a filename to make the name of the backup file.
set startofline " When on, certain commands move the cursor to the first non-blank of the line.
set autochdir " Automatically change the current working directory whenever you open a file, switch buffers, delete a buffer, or open/close a window.
set belloff=all " Turns off the terminal bell. `:help 'belloff'` for info

" Keybinds
let mapleader = "\<SPACE>"

nnoremap ; :
nnoremap <Leader>w :w<CR>
nnoremap <Leader>f :wq<CR>
nnoremap <Leader>e :q!<CR>
nnoremap <Leader>h :set hlsearch!<CR>

" set the backspace to delete normally
set backspace=indent,eol,start

vmap <Tab> >
vmap <S-Tab> <
