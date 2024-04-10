colorscheme palenight

set-option global tabstop 4
set-option global indentwidth 4
set-option global scrolloff 25,20

# enable lsp
eval %sh{kak-lsp --kakoune -s $kak_session}
lsp-enable

# keybinds

## saving and quitting
map global user q :quit!<ret>
map global user x :wq<ret>
map global user w :w<ret>
map global user d :db<ret>
map global normal <c-s> :w<ret>

map global user <tab> :buffer-next<ret>
map global user <s-tab> :buffer-previous<ret>

# make the tab key insert spaces
# (by using the > or < keys, which take indentwidth)
map global insert <tab> '<a-;><a-gt>'
map global insert <s-tab> '<a-;><a-lt>'
