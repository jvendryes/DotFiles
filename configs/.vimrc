" Automatically source .vimrc on save
autocmd! BufWritePost ~/.vimrc nested :source ~/.vimrc

" Disable automatically adding comments on new lines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" General configuration
set nocompatible                    " Ensure enhancements are turned on
set t_Co=256                        " Force 256 colors in terminal
set t_ut=                           " Fixes the background color in vim when using tmux (https://sunaku.github.io/vim-256color-bce.html)
set noswapfile                      " Turn off swap files
set number                          " Show line numbers
set encoding=utf-8                  " Set encoding to UTF-8
set showmatch                       " Enable showing matches
set matchpairs=(:),{:},[:]          " Define characters for 'showmatch'
set undolevels=1000                 " Define the maximum number of changes that can be undone
set title                           " Title of the window set to value of 'titlestring'
set cursorline                      " Highlight the line the cursor is on
set nowrap                          " Disable automatic wrapping
set textwidth=0                     " Disable 'textwidth'
syntax on                           " Enable syntax highlighting
autocmd BufWritePre * :%s/\s\+$//e  " Automatically remove trailing spaces
set laststatus=2                    " Always show status line
set hidden                          " Hide buffer instead of closing them
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
Plugin 'tpope/vim-fugitive'
Plugin 'vim-syntastic/syntastic'
Plugin 'leafgarland/typescript-vim'

call vundle#end()
filetype plugin indent on
" End Vundle

" Airline configuration
let g:airline_powerline_fonts = 1   " Automatically populate 'g:airline_symbols'
let g:airline#extensions#tabline#enabled = 1    " Display all buffers as tabline

" Syntastic configuration
let g:syntastic_always_populate_loc_list = 1    " Tell Syntastic to always stick any detected errors into the 'location-list'
let g:syntastic_auto_loc_list = 1               " Error window will be automatically opened when errors are detected, and closed when none are detected
let g:syntastic_check_on_open = 1               " Run syntax checks when buffers are first loaded, as well as on saving
let g:syntastic_check_on_wq = 0                 " Skip checks on :wq, :x, :ZZ

" CtrlP configuration
" Ignore the following files and directories
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$'
    \ }

" Theme options
colorscheme onedark                 " Set colorscheme

" Final configuration
set secure                          " Harden vim
