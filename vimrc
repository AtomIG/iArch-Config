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
set shiftwidth=4
set softtabstop=0 noexpandtab
set tabstop=4
set virtualedit=all

set nocompatible 

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'dag/vim-fish'

" Vim Latex

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set sw=2
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'zathura'
let g:Tex_CustomTemplateDirectory = '~/.vim/latex/, $VIM/ftplugin/latex-suite/templates/'
