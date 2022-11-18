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

set number                     " Show current line number
set relativenumber             " Show relative line numbers

inoremap jk <ESC>

let mapleader = "'"

set noswapfile " disable the swapfile
set hlsearch " highlight all results
set ignorecase " ignore case in search
set incsearch " show search results as you type

:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

:nnoremap <leader>sv :source $MYVIMRC<cr>

" Set native formatting to use autopep8 for python
au FileType python setlocal formatprg=autopep8\ -

" Set the filetype based on the file's extension, overriding any
" 'filetype' that has already been set
au BufRead,BufNewFile *.py set filetype=python


" Convert tabs to spaces
:set tabstop=4 shiftwidth=4 expandtab

" Install vim-plug automatically
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vi'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

" Plugins for TS and JS
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'tpope/vim-obsession' " Vim auto save
" Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Plug 'vim-airline/vim-airline'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'gruvbox-community/gruvbox'
Plug 'nvie/vim-flake8'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'typescriptreact', 'javascriptreact'] }
"Plug 'ctrlpvim/ctrlp.vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'BurntSushi/ripgrep'

Plug 'preservim/nerdcommenter'
Plug 'neovim/nvim-lspconfig'

call plug#end()


" let g:coc_global_extensions = [ 'coc-tsserver' ]

" Show CoC tooltip
" nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>

syntax on
set t_Co=256
set cursorline


if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif


let python_highlight_all=1


let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|venv'




autocmd BufWritePost *.py call flake8#Flake8()






" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

colorscheme gruvbox
let g:coq_settings = { 'auto_start': v:true }
lua << EOF
local lsp_config = require("lspconfig")
local coq = require "coq"

local configs = require('lspconfig/configs')
local util = require('lspconfig/util')

local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({'*', '.*'}) do
    local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
    if match ~= '' then
      return path.join(path.dirname(match), 'bin', 'python')
    end
  end

  -- Fallback to system Python.
  return exepath('python3') or exepath('python') or 'python'
end

lsp_config.pyright.setup(coq.lsp_ensure_capabilities({
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end
}))
--[[
lsp_config.pylsp.setup(coq.lsp_ensure_capabilities(
{
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            maxLineLength = 100
        },
         flake8 = {
            maxLineLength = 100
        }
      }
    }
  }
}
))
--]]
EOF


nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.bufimplementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_prev()<CR>

nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_next()<CR>



" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c



set nohlsearch


filetype plugin on

:lua require('telescope').load_extension('fzy_native')

hi Normal guibg=NONE ctermbg=NONE



let g:NERDDefaultAlign = 'start'



nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.bufimplementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_prev()<CR>

nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_next()<CR>



" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c



set nohlsearch


filetype plugin on

:lua require('telescope').load_extension('fzy_native')

hi Normal guibg=NONE ctermbg=NONE



let g:NERDDefaultAlign = 'start'

