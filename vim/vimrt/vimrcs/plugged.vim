" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vimrt/plugins')
    Plug 'itchyny/lightline.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'Asheq/close-buffers.vim'
    ", { 'on': 'NERDTreeToggle' } --> consider this
    " TODO session management
    " TODO neosnippets or something similar
    Plug 'thaerkh/vim-workspace'
    Plug 'airblade/vim-gitgutter'
    Plug 'michalbachowski/vim-wombat256mod' " TODO find something nicer mb
    Plug 'Valloric/YouCompleteMe', {'do': './install.py --clangd-completer --cs-completer --rust-completer --system-boost', 'for': ['c', 'cpp', 'cs', 'python', 'objc', 'objcpp', 'rust']}
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround' " TODO confing
    Plug 'tomtom/tcomment_vim'
    Plug 'gregsexton/gitv'
    Plug 'Shougo/neomru.vim'
    Plug 'Shougo/neoyank.vim'
    "Plug 'Shougo/vimproc.vim', {'do': 'make'} "better cmd execution not sure if this is needed
    Plug 'Shougo/denite.nvim', {'do': 'pip3 install --user --upgrade pynvim'} " TODO config
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'mbbill/undotree'
    "Plug 'derekwyatt/vim-fswitch'
    "Plug 'kris89/vim-multiple-cursors'
    " Plug 'SirVer/ultisnips'
    "Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'Chiel92/vim-autoformat'
    Plug 'Valloric/ListToggle'
    Plug 'Yggdroot/indentLine'
    Plug 'lyuts/vim-rtags' " TODO config this
    Plug 'dkprice/vim-easygrep'
    Plug 'nixprime/cpsm', {'do': './install.sh'}
    Plug 'majutsushi/tagbar'

call plug#end()
" Make sure you use single quotes