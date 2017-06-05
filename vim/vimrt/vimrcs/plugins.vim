""""""""""""""""""""""""""""""""""""""""
" => UNITE config
""""""""""""""""""""""""""""""""""""""""
let g:unite_prompt='» '
let g:unite_source_history_yank_enable = 1
let g:unite_source_grep_max_candidates = 1000
let g:unite_source_rec_async_command = 'ag'
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--line-numbers --nocolor --nogroup --hidden'
	let g:unite_source_grep_recursive_opt = ''
	let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
endif
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <leader>o :Unite -start-insert -no-split -auto-resize -buffer-name=files file file_rec/async file_mru<CR>
nnoremap <leader>uo :Unite -start-insert -no-split -auto-preview -buffer-name=outline outline<CR>
nnoremap <leader>uy :Unite -no-split -quick-match -buffer-name=yank history/yank<CR>
nnoremap <leader>ul :Unite -no-split -quick-match -start-insert -buffer-name=lines line<CR>
nnoremap <leader>b :Unite -no-split -quick-match -buffer-name=buffer buffer<CR>

""""""""""""""""""""""""""""""
" => snipMate (support <CTRL-j>)
""""""""""""""""""""""""""""""
imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger
"ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
"snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>

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
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

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
" => Nextval
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <C-i> <Plug>nextvalInc
nnoremap <silent> <C-o> <Plug>nextvalDec


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => EasyMotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
omap t <Plug>(easymotion-t)
omap / <Plug>(easymotion-tn)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
"map / <Plug>(easymotion-sn)
"map n <Plug>(easymotion-next)
"map N <Plug>(easymotion-prev)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => EasyGrep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyGrepCommand=1
nnoremap <leader>/ :Grep<space>


"" DEPRECATED
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ag searching and cope displaying
"    requires ag.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ag after the selected text
" vnoremap <silent> gv :call VisualSelection('gv', '')<CR>
"
" " Open Ag and put the cursor in the right position
"  map <leader>/ :Ag 
"
" " When you press <leader>r you can search and replace the selected text
" vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>
"
" " Do :help cope if you are unsure what cope is. It's super useful!
" "
" " When you search with Ag, display your results in cope by doing:
" "   <leader>cc
" "
" " To go to the next search result do:
" "   <leader>n
" "
" " To go to the previous search results do:
" "   <leader>p
" "
" map <leader>cc :botright cope<cr>
" map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
" "TODO
" map <leader>n :cn<cr>
" map <leader>p :cp<cr>
"

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
" => UndoTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <leader>u :UndotreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Hardmode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>hh <Esc>:call ToggleHardMode()<CR>

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

nnoremap <silent> <leader>g :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <silent> <leader>gi :YcmCompleter GoToImprecise<CR>
nnoremap <silent> <leader>gx :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>gt :YcmCompleter GetType<CR>
nnoremap <silent> <leader>fi :YcmCompleter FixIt<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => SimpleFold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helpre Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" function! CmdLine(str)
"     exe "menu Foo.Bar :" . a:str
"     emenu Foo.Bar
"     unmenu Foo
" endfunction 
"
" function! VisualSelection(direction, extra_filter) range
"     let l:saved_reg = @"
"     execute "normal! vgvy"
"
"     let l:pattern = escape(@", "\\/.*'$^~[]")
"     let l:pattern = substitute(l:pattern, "\n$", "", "")
"
"     if a:direction == 'gv'
"         call CmdLine("Ag '" . l:pattern . "' " )
"     elseif a:direction == 'replace'
"         call CmdLine("%s" . '/'. l:pattern . '/')
"     endif
"
"     let @/ = l:pattern
"     let @" = l:saved_reg
" endfunction
"
