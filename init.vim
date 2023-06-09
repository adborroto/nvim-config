:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

call plug#begin()

Plug 'preservim/nerdcommenter'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'dyng/ctrlsf.vim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " this is for auto complete, prettier and tslinting
Plug 'puremourning/vimspector'
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed

Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {

" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
set encoding=UTF-8

call plug#end()


:colorscheme jellybeans

:let mapleader = "\<Space>"


nnoremap <leader>pp <cmd>Telescope find_files<cr>
nnoremap <leader>pg <cmd>Telescope live_grep<cr>
nnoremap <leader>pb <cmd>Telescope buffers<cr>
nnoremap <leader>ph <cmd>Telescope help_tags<cr>
nnoremap <leader>pp <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>pg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>pb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>ph <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <leader>ee :NERDTreeToggle<CR>
nnoremap <leader>en :NERDTree<CR>
nnoremap <leader>ef :NERDTreeFind<CR>

nnoremap <leader>b<Left> :BufferPrevious<CR>
nnoremap <leader>bp<Right> :BufferNext<CR>
nnoremap <leader>ww :BufferClose<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

map <Leader>kc <Plug>NERDCommenterComment
map <Leader>ku <Plug>NERDCommenterUncomment
