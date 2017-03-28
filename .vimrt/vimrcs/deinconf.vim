if dein#load_state(expand('~/.vimrt/plugins'))
  call dein#begin(expand('~/.vimrt/plugins'))

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('michalbachowski/vim-wombat256mod')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/unite-outline')
  call dein#add('Shougo/neoyank.vim')
  call dein#add('tpope/vim-dispatch') " TODO config
  call dein#add('tpope/vim-fugitive') " TODO config
  call dein#add('tpope/vim-repeat') " TODO config
  call dein#add('tpope/vim-surround') " TODO config
  call dein#add('tomtom/tcomment_vim') "No config
  call dein#add('gregsexton/gitv') 
  call dein#add('easymotion/vim-easymotion') 
  call dein#add('itchyny/lightline.vim')
  call dein#add('mbbill/undotree')
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('wikitopian/hardmode')
  call dein#add('octol/vim-cpp-enhanced-highlight')
  call dein#add('Valloric/ListToggle') 
  call dein#add('airblade/vim-gitgutter')
  call dein#add('qwertologe/nextval.vim')
  call dein#add('Yggdroot/indentLine') 
  call dein#add('MarcWeber/vim-addon-mw-utils') "snipmate dep
  call dein#add('tomtom/tlib_vim') "snipmate dep
  call dein#add('garbas/vim-snipmate')
  call dein#add('honza/vim-snippets')
  call dein#add('dkprice/vim-easygrep')
  call dein#add('tmhedberg/SimpylFold')
  call dein#add('Valloric/YouCompleteMe',{'build' : 'python install.py --clang-completer --omnisharp-completer', 'merged' : 0})
  call dein#end()
  call dein#save_state()
endif

" Auto install
if dein#check_install()
    call dein#install()
endif
