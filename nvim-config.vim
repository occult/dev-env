set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

filetype plugin on


:lua require('telescope').load_extension('fzy_native')

hi Normal guibg=NONE ctermbg=NONE




