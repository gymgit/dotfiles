" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vimrt/plugins')
	" Supertab completion
	" Plug 'ervandew/supertab' broken
    Plug 'itchyny/lightline.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'Asheq/close-buffers.vim'
    ", { 'on': 'NERDTreeToggle' } --> consider this
    " TODO session management
    Plug 'thaerkh/vim-workspace'
    Plug 'airblade/vim-gitgutter'
    Plug 'michalbachowski/vim-wombat256mod' " TODO find something nicer mb
    " Retire youcomplete me, way too unreliable, crashes after system updates
    " Plug 'Valloric/YouCompleteMe', {'do': './install.py --clangd-completer --cs-completer --rust-completer', 'for': ['c', 'cpp', 'cs', 'python', 'objc', 'objcpp', 'rust']}
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround' " TODO confing
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'
    "Plug 'tomtom/tcomment_vim' " can't get it to use inline comments ffs
    Plug 'gregsexton/gitv'
    Plug 'Shougo/neomru.vim'
    Plug 'Shougo/neoyank.vim'
    "Plug 'Shougo/vimproc.vim', {'do': 'make'} "better cmd execution not sure if this is needed
    "Plug 'Shougo/denite.nvim', {'do': 'pip3 install --user --upgrade pynvim'}
    "Plug 'roxma/nvim-yarp'
    "Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'mbbill/undotree'
    "Plug 'derekwyatt/vim-fswitch'
    "Plug 'kris89/vim-multiple-cursors'
    
    "TODO config this
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    
    Plug 'bfrg/vim-cpp-modern'
    "Plug 'octol/vim-cpp-enhanced-highlight'
    "TODO consider this: https://github.com/jackguo380/vim-lsp-cxx-highlight
    Plug 'Chiel92/vim-autoformat'
    Plug 'Valloric/ListToggle'
    Plug 'Yggdroot/indentLine'
    Plug 'RRethy/vim-illuminate'
    Plug 'lyuts/vim-rtags' " TODO config this
    Plug 'dkprice/vim-easygrep'
    Plug 'nixprime/cpsm', {'do': './install.sh'}
    Plug 'majutsushi/tagbar'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " c/cpp syntax highlight
    "Plug 'jeaye/color_coded'
	"LSP Client
	Plug 'prabirshrestha/vim-lsp'
	" LSP Completion
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	" LSP ultisnip support
	Plug 'thomasfaingnaert/vim-lsp-snippets'
	Plug 'thomasfaingnaert/vim-lsp-ultisnips'
	" LSP syntax highlight (might not work wiht clangd+vim-lsp)
	Plug 'jackguo380/vim-lsp-cxx-highlight'
	" Capnp schema
	Plug 'cstrahan/vim-capnp'
call plug#end()
" Make sure you use single quotes
