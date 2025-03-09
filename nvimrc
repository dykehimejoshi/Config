set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

" mouse
set mouse=

" https://lazy.folke.io/installation
lua require("config.lazy")
