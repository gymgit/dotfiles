"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ }

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = 5000
nnoremap <silent> <leader>z :GitGutterToggle<cr>
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap <leader>hs <Plug>GitGutterStageHunk
nmap <leader>hr <Plug>GitGutterRevertHunk
nmap <leader>hp <Plug>GitGutterPreviewHunk

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tcomment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Gitv
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <leader>gv :Gitv --date-order<CR>
nnoremap <silent> <leader>gV :Gitv! --date-order<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = expand('~/vimrt/others/ycm_gextra_conf.py')
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_error_symbol = 'E>'
let g:ycm_warning_symbol = 'W>'
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_invoke_completion = '<C-Space>'

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = "/usr/bin/clangd"
let g:ycm_clangd_args = ['-background-index', '-clang-tidy']

nnoremap <silent> <leader>g :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <silent> <leader>gi :YcmCompleter GoToImprecise<CR>
nnoremap <silent> <leader>gx :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>gt :YcmCompleter GetType<CR>
nnoremap <silent> <leader>fi :YcmCompleter FixIt<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UndoTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <leader>u :UndotreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => AutoFormat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <F3> :Autoformat<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ListToggle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'
let g:lt_height = 15

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => IndentLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:indentLine_color_term = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => EasyGrep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyGrepCommand=1
nnoremap <leader>/ :Grep<space>
" def bindings
" <Leader>vv  - Grep for the word under the cursor, match all occurences,
" 			  like |gstar|
" <Leader>vV  - Grep for the word under the cursor, match whole word, like 
" 			  |star|
" <Leader>va  - Like vv, but add to existing list
" <Leader>vA  - Like vV, but add to existing list
" <Leader>vr  - Perform a global search search on the word under the cursor
" 			  and prompt for a pattern with which to replace it.
" <Leader>vo  - Select the files to search in and set grep options

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Denite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
	call denite#custom#var('grep', 'command', ['ag'])
	call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', [])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
	call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
elseif executable('rg')
	" Ripgrep
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob'])
  " call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])
endif

call denite#custom#option('default', 'prompt', '»')
call denite#custom#option('_', 'highlight_matched_char', 'no')
call denite#custom#option('_', 'smartcase', 'true')
call denite#custom#option('_', 'reversed', 'true')
call denite#custom#option('_', 'auto_resize', 'true')
call denite#custom#source('_', 'matchers', ['matcher/cpsm'])
call denite#custom#source('_', 'sorters', ['sorter/sublime'])
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<ESC>', '<denite:enter_mode:normal>', 'noremap')
"call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', '<C-o>', '<denite:do_action:tabopen>', 'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', '<C-h>', '<denite:do_action:split>', 'noremap')

call denite#custom#map('normal', 'gg', '<denite:move_to_first_line>', 'noremap')
call denite#custom#map('normal', 'st', '<denite:do_action:tabopen>', 'noremap')
call denite#custom#map('normal', 'sv', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', 'sh', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', 'r', '<denite:redraw>', 'noremap')

nnoremap <silent> <leader>o :Denite file/rec<cr>
"nnoremap <silent> <leader>tt :Denite file/rec<cr>
nnoremap <silent> <leader>i :Denite buffer<cr>
nnoremap <silent> <leader>t :Denite outline: -mode=normal<cr>
nnoremap <silent> <leader>u/ :Denite grep<cr>
nnoremap <silent> <leader>uy :Denite neoyank<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:multi_cursor_next_key="\<C-s>"
" Default mapping
"let g:multi_cursor_next_key='<C-n>'
"let g:multi_cursor_prev_key='<C-p>'
"let g:multi_cursor_skip_key='<C-x>'
"let g:multi_cursor_quit_key='<Esc>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F8> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NerdTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F7> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>f :NERDTreeFind<CR>

autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeStatusline = "NERD"
highlight EndOfBuffer ctermfg=black

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Workspace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>wp :ToggleWorkspace<CR>
let g:workspace_session_directory = expand('~/.vimrt/temp_dirs/')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CloseBuffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>wh :CloseHiddenBuffers<CR>
nnoremap <silent> <leader>wc :CloseNamelessBuffers<CR>
