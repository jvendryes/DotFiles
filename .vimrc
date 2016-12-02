" Automatically source .vimrc on save
autocmd! BufWritePost ~/.vimrc nested :source ~/.vimrc

" General configuration
set nocompatible                    " Ensure enhancements are turned on
set t_Co=256                        " Force 256 colors in terminal
set noswapfile                      " Turn off swap files
set number                          " Show line numbers
set encoding=utf-8                  " Set encoding to UTF-8
set showmatch                       " Enable showing matches
set matchpairs=(:),{:},[:]          " Define characters for 'showmatch'
set undolevels=1000                 " Define the maximum number of changes that can be undone
set title                           " Title of the window set to value of 'titlestring'
set cursorline                      " Highlight the line the cursor is on
syntax on                           " Enable syntax highlighting
autocmd BufWritePre * :%s/\s\+$//e  " Automatically remove trailing spaces
set formatoptions-=cro              " Disable automatically adding comments on new lines
set laststatus=2                    " Always show status line
" Tabs and indenting
set tabstop=4                       " A tab is four spaces
set smarttab                        " <TAB> key inserts indentation according to 'shiftwidth'
set softtabstop=4                   " When hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                       " Insert space characters whenever the tab key is pressed
set shiftwidth=4                    " Number of spaces to use for autoindenting
set shiftround                      " Use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start      " Define how backspacing works in insert mode
set list                            " Make whitespace characters visible
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅ " Define whitespace characters

" Start Vundle
filetype off
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
" End Vundle

" Airline configuration
let g:airline_powerline_fonts = 1   " Automatically populate 'g:airline_symbols'

" Theme options
colorscheme onedark                 " Set colorscheme

" Final configuration
set secure                          " Harden VIM
