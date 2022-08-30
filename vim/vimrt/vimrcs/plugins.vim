"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Man
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Loads the default man plugin
runtime! ftplugin/man.vim
" Leader + K should open man for current word

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



" maybe use to comment block comments too   \ 'commentstring_rx': '\%%(// %s\)', 
" let g:tcomment#inline_fmt_c = {
"     \ 'rxmid': '',
"     \ 'rxend': '', 
"     \ 'commentstring': '// %s', 
"     \ 'commentstring_rx': '\%%(// %s\|/* %s */\)', 
"     \ 'replacements': {},
"     \ 'rxbeg': ''}

" let g:tcomment#inline_fmt_c = {'commentstring': '// %s' }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commentary
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:commentary_startofline = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Gitv
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <leader>gv :Gitv --date-order<CR>
nnoremap <silent> <leader>gV :Gitv! --date-order<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ycm_global_ycm_extra_conf = expand('~/vimrt/others/ycm_gextra_conf.py')
" let g:ycm_extra_conf_globlist = ['~/dev/projects/*', '~/ctf/srces/*']
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_always_populate_location_list = 1
" let g:ycm_error_symbol = 'E>'
" let g:ycm_warning_symbol = 'W>'
" let g:ycm_complete_in_comments = 1
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_key_invoke_completion = '<C-Space>'

" " Let clangd fully control code completion
" let g:ycm_clangd_uses_ycmd_caching = 0
" " Use installed clangd, not YCM-bundled clangd which doesn't get updates.
" let g:ycm_clangd_binary_path = "/usr/bin/clangd"
" let g:ycm_clangd_args = ['-background-index', '-clang-tidy']

" nnoremap <silent> <leader>g :YcmCompleter GoTo<CR>
" nnoremap <silent> <leader>gd :YcmCompleter GoToDefinition<CR>
" nnoremap <silent> <leader>gi :YcmCompleter GoToImprecise<CR>
" nnoremap <silent> <leader>gx :YcmCompleter GoToReferences<CR>
" nnoremap <silent> <leader>gt :YcmCompleter GetType<CR>
" nnoremap <silent> <leader>fi :YcmCompleter FixIt<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>
" cs'" -> change ' to " 
" ds' -> delete surrounding '
" ys[selector][char] -> surround selected text with char (ysiw[)
nmap <leader>s ysiw

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
" if executable('rg')
" 	" Ripgrep
"   call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob'])
"   " call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
"   call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
"   call denite#custom#var('grep', 'recursive_opts', [])
"   call denite#custom#var('grep', 'final_opts', [])
"   call denite#custom#var('grep', 'separator', ['--'])
"   call denite#custom#var('grep', 'default_opts',
"         \ ['-i', '--vimgrep', '--no-heading'])
" elseif executable('ag')
" 	call denite#custom#var('grep', 'command', ['ag'])
" 	call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
" 	call denite#custom#var('grep', 'recursive_opts', [])
" 	call denite#custom#var('grep', 'pattern_opt', [])
" 	call denite#custom#var('grep', 'separator', ['--'])
" 	call denite#custom#var('grep', 'final_opts', [])
" 	call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
" endif
"
" call denite#custom#option('default', 'prompt', '»')
" call denite#custom#option('_', 'highlight_matched_char', 'no')
" call denite#custom#option('_', 'smartcase', 'true')
" call denite#custom#option('_', 'reversed', 'true')
" call denite#custom#option('_', 'auto_resize', 'true')
" call denite#custom#source('_', 'matchers', ['matcher/cpsm'])
" call denite#custom#source('_', 'sorters', ['sorter/sublime'])
" call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
" call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
" call denite#custom#map('insert', '<ESC>', '<denite:enter_mode:normal>', 'noremap')
" "call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
" call denite#custom#map('insert', '<C-o>', '<denite:do_action:tabopen>', 'noremap')
" call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
" call denite#custom#map('insert', '<C-h>', '<denite:do_action:split>', 'noremap')
"
" call denite#custom#map('normal', 'gg', '<denite:move_to_first_line>', 'noremap')
" call denite#custom#map('normal', 'st', '<denite:do_action:tabopen>', 'noremap')
" call denite#custom#map('normal', 'sv', '<denite:do_action:vsplit>', 'noremap')
" call denite#custom#map('normal', 'sh', '<denite:do_action:split>', 'noremap')
" call denite#custom#map('normal', 'r', '<denite:redraw>', 'noremap')
"
" nnoremap <silent> <leader>o :Denite file/rec<cr>
" "nnoremap <silent> <leader>tt :Denite file/rec<cr>
" nnoremap <silent> <leader>i :Denite buffer<cr>
" nnoremap <silent> <leader>t :Denite outline: -mode=normal<cr>
" nnoremap <silent> <leader>u/ :Denite grep<cr>
" nnoremap <silent> <leader>uy :Denite neoyank<cr>


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
" => Workspace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>wp :ToggleWorkspace<CR>
let g:workspace_session_directory = expand('~/.vimrt/temp_dirs/')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CloseBuffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>wh :CloseHiddenBuffers<CR>
nnoremap <silent> <leader>wc :CloseNamelessBuffers<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_command_prefix = 'Fz'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

nnoremap <leader>o :FzFiles<cr>
nnoremap <leader>i :FzBuffer<cr>
" ctrl + / is used to grep for whatever
nnoremap <C-_> :FzRg 
" search for the word under the cursor
nnoremap <expr> <C-g> ':FzRg '.expand("<cword>").'<cr>'
" grep for the visual mode selected item
vnoremap <C-g> "ry :FzRg <C-r>r<cr>
" search in ctags for word under cursor
nnoremap <expr> <C-8> ':FzTags '.expand("<cword>").'<cr>'
" fzf commits
nnoremap <leader>c :FzCommits<cr>

" 
function! RgPath(query, path)
    call fzf#vim#grep(printf("rg --column --line-number --no-heading --color=always --smart-case %s %s", shellescape(a:query), shellescape(expand(a:path))), 1, fzf#vim#with_preview(), 0)
endfunction

command! -bang -nargs=* RgCurr call RgPath(<q-args>, expand('%:p:h'))
nnoremap <C-?> :RgCurr 
" grep in current directory
" function! RgCurr(query)
"     call RgPath(a:query, expand('%:p:h'))
" endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NerdTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F7> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>f :NERDTreeFind<CR>

autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeStatusline = "NERD"
highlight EndOfBuffer ctermfg=black

" for whatever reason this only works if NT is toggled on and off
autocmd VimEnter * call NERDTreeAddKeyMap({'quickhelpText': 'Run (E)xtract repro on the file', 'key': 'E', 'callback': 'NERDTreeExecExtractRepro', 'override': 1, 'scope': 'FileNode'})
autocmd VimEnter * call NERDTreeAddKeyMap({'quickhelpText': '(f)ind in folder', 'key': 'f', 'callback': 'NERDTreeRgCommand', 'override': 1})

function! NERDTreeRgCommand()
    let path = g:NERDTreeFileNode.GetSelected().path.getDir().str()
    let cmd = input('Grep: ')
    "echo cmd . ' ' . path
    wincmd p
    call RgPath(cmd, path)
endfunction

function! NERDTreeExecExtractRepro(filenode)
    " echo a:filenode.path.str()
    call system("extract_repro.py " . a:filenode.path.str())
    :NERDTreeRefreshRoot
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moder CPP Highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Illuminate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Don't do the nerd tree window
let g:Illuminate_ftblacklist = ['nerdtree']

" Time in milliseconds (default 0)
let g:Illuminate_delay = 0

" This should be fine tuned
" :echo synIDattr(synID(line("."), col("."), 1), "name")
" let g:Illuminate_ftHighlightGroups = {
"       \ 'vim': ['vimVar', 'vimString', 'vimLineComment',
"       \         'vimFuncName', 'vimFunction', 'vimUserFunc', 'vimFunc']
"       \ }
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LSP server config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('clangd')
    augroup vim_lsp_cpp
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd', '-background-index']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
                    \ })
	autocmd FileType c,cpp,objc,objcpp,cc setlocal omnifunc=lsp#complete
    augroup end
endif

" if executable('ccls')
"    au User lsp_setup call lsp#register_server({
"       \ 'name': 'ccls',
"       \ 'cmd': {server_info->['ccls']},
"       \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"       \ 'initialization_options': {
"       \   'highlight': { 'lsRanges' : v:true },
"       \ },
"       \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"       \ })
" endif

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

set completeopt+=menuone

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Asynccomplete binds
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" Force refresh completion
"imap <c-space> <Plug>(asyncomplete_force_refresh)
