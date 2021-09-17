set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

filetype plugin on

let g:prettier#config#tab_width = 2 
let g:prettier#config#arrow_parens = 'avoid'
let g:NERDDefaultAlign = 'start'
:lua require('telescope').load_extension('fzy_native')
hi Normal guibg=NONE ctermbg=NONE

let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.js,*.jsx,*.tsx,*.html.erb,*.md'
let g:closetag_xhtml_filenames = '*.js,*.jsx,*.tsx'

let s:zoomed = 0

function! ToggleZoom()
    if s:zoomed
        :exe "normal \<c-w>="
        let s:zoomed = 0
    else
        :exe "normal \<c-w>_ \| \<c-w>\|"
        let s:zoomed = 1
    endif
endfunction

noremap <leader>z :call ToggleZoom()<CR>
