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
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

" Plugins for TS and JS
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'tpope/vim-obsession' " Vim auto save
" Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }

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
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'preservim/nerdcommenter'
Plug 'neovim/nvim-lspconfig'

Plug 'kabouzeid/nvim-lspinstall'

Plug 'nvim-lua/completion-nvim'

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

lua << EOF
local lsp_config = require("lspconfig")
local lsp_completion = require("completion")


--Enable completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local general_on_attach = function(client, bufnr)
  if client.resolved_capabilities.completion then
    lsp_completion.on_attach(client, bufnr)
  end
end
local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{
-- Add capabilities
    capabilities = capabilities,
    on_attach = general_on_attach
    }
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
EOF


nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.bufimplementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>



" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c



set nohlsearch
.
