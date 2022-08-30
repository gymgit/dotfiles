""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f #--- <esc>a
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#
au FileType python set noexpandtab

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> $log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f //--- PH<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => CoffeeScript section
"""""""""""""""""""""""""""""""
function! CoffeeScriptFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()

au FileType gitcommit call setpos('.', [0, 1, 1, 0])
autocmd BufWrite *.coffee :call DeleteTrailingWS()


""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" => HTML and md
""""""""""""""""""""""""""""""

au FileType markdown,html setl tabstop=2
au FileType markdown,html setl shiftwidth=2

function! TexToMd()
    " Save cursor position
    let l:save = winsaveview()

    " Replace mintinline with ``
    %s/\\mintinline\(\[[a-z=]*\]\)\?{[^\}]*}{\([^\}]*\)}/`\2`/g

    " Replace Section with #
    %s/\\section{\([^\}]*\)}/# \1/g

    " Replace Subsection with ##
    %s/\\subsection{\([^\}]*\)}/## \1/g

    " Replace URL to [](url)
    %s/\\url{\([^\}]*\)}/\[\](\1)/g

    " Code block begin to ```c
    %s/\\begin{ccode}.*/```c/g

    " Code block end or minted block to ```
    %s/\\begin{minted}.*\|\\end{minted}\|\\end{ccode}/```/g

    " Item to *
    %s/\\item/*/g

    " Delete begin/end itemize
    %s/\\begin{itemize}.*\|\\end{itemize}//g

    " Move cursor to original position
    call winrestview(l:save)
endfunction

""""""""""""""""""""""""""""""
" => C, Cpp
""""""""""""""""""""""""""""""
au FileType c,cpp setl commentstring=//\ %s

" Allow CPP man search 
" This relies on that cppman is installed and the default man plugin is enabled
" must run the following commands to work properly
" cppman -c
" cppman -m true

" Improved keyword selection that includes cpp scope
function! s:JbzCppMan()
    let old_isk = &iskeyword
    setl iskeyword+=:
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
    execute 'Man ' . str
endfunction
command! JbzCppMan :call s:JbzCppMan()


"au FileType cpp nnoremap <buffer>K :JbzCppMan<CR>
au FileType cpp nnoremap <leader>K :JbzCppMan<CR>

" TODO maybe add QT browser doc lookup in browser
" https://idie.ru/posts/vim-modern-cpp
" TODO add maybe guttentag support

""""""""""""""""""""""""""""""
" => Latex
""""""""""""""""""""""""""""""
autocmd Filetype tex let b:surround_{char2nr('o')} = "\\mintinline{text}{\r}"

