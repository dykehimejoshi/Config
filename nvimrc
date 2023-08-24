set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require('plugins')

" set a few things in :checkhealth to be skipped over
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

colorscheme rose-pine-moon

lua << EOF
-- i've seen people separate this into individual config files
-- but i'm not doing that just yet

-- firenvim config
if vim.g.started_by_firenvim == true then
    vim.o.laststatus = 0
else
    vim.o.laststatus = 2
end

EOF

" mouse
set mouse=
