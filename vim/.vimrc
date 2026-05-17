" Minimal Vim fallback. Neovim is the default editor for this repo.

set nocompatible
filetype plugin indent on
syntax on

set backspace=indent,eol,start
set encoding=utf-8
set hidden
set ignorecase
set incsearch
set laststatus=2
set modelines=0
set nobackup
set noerrorbells
set noswapfile
set number
set ruler
set scrolloff=3
set shiftwidth=2
set smartcase
set tabstop=2
set title
set wildignore+=*/.git/*,*/node_modules/*,*/dist/*,*/build/*

let mapleader = ","

nnoremap n nzzzv
nnoremap N Nzzzv
