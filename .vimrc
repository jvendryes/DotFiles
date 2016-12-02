" Automagically source .vimrc on save
autocmd! BufWritePost ~/.vimrc nested :source ~/.vimrc

set nocompatible
set t_Co=256
filetype off
set noswapfile

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'joshdick/onedark.vim'
Plugin 'powerline/fonts'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-syntastic/syntastic'

call vundle#end()
filetype plugin indent on

" Tabs and Indenting
set tabstop=4                   " a tab is four spaces
set smarttab
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

" General Settings
set number                      " Show line numbers
set encoding=utf-8              " Encoding to UTF8
set showmatch
set matchpairs=(:),{:},[:]
set undolevels=1000
set title
set cursorline
syntax on
autocmd BufWritePre * :%s/\s\+$//e " Auto-remove trailing spaces
set formatoptions-=cro          " Stop adding comments on new lines

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

colorscheme onedark
set laststatus=2

" Last Line
set secure                      " Harden VIM
