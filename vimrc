syntax enable
set number
colorscheme lucario
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='simple'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeWinPos='left'
let NERDTreeQuitOnOpen=1
set shiftwidth=4 smarttab
set softtabstop=0 noexpandtab
set tabstop=4

set nocompatible 
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'dag/vim-fish'

filetype plugin indent on
