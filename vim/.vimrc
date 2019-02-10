set nocompatible              " be iMproved, required
filetype off                  " required

so ~/.vim/plugins.vim

map <C-n> :NERDTreeToggle<CR>
set laststatus=2
set noshowmode
set showmatch

let g:lightline = {
      \ 'colorscheme': 'srcery_drk',
      \ }

set number
syntax on

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
