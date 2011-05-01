"=============================================================================
" FILE: eev.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 10 May 2009
" Usage: Just source this file.
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Version: 1.0, for Vim 7.0
"-----------------------------------------------------------------------------
" ChangeLog: "{{{
"   1.0:
"     - Initial version.
""}}}
"-----------------------------------------------------------------------------
" TODO: "{{{
"     -
""}}}
" Bugs"{{{
"     -
""}}}
"=============================================================================

if exists('g:loaded_eev') || v:version < 700
  finish
endif

" Plugin keymapping"{{{
nnoremap <silent> <Plug>(eev_search_forward)   :<C-u>call search('#:', 'w')<CR>
nnoremap <silent> <Plug>(eev_search_backward)  :<C-u>call search('#:', 'bw')<CR>
nnoremap <silent> <Plug>(eev_eval)  :<C-u>call <SID>eval()<CR>
nnoremap <silent> <Plug>(eev_create)  :<C-u>call <SID>create()<CR>
"}}}

" Global options definition."{{{
"}}}

command! -nargs=1 -complete=custom,s:ReditCompletion REdit call <SID>redit('<bang>', <q-args>)

function! s:eval()
    execute matchstr(getline('.'), '#:\zs.*$')
endfunction

function! s:redit(bang, filename)
    let l:filename = printf('%s/%s', expand('%:p:h'), a:filename)
    if a:bang == ''
        edit `=l:filename`
    else
        edit! `=l:filename`
    endif
endfunction

function! s:create()
    call append(line('.'), '#: ')
    normal! j
    startinsert!
endfunction

function! s:set_comment_pattern(filetype, pattern)"{{{
    for ft in split(a:filetype, ',')
        if !has_key(g:Eev_Comment, ft) 
            let g:Eev_Comment[ft] = a:pattern
        endif
    endfor
endfunction"}}}

function! s:ReditCompletion(ArgLead, CmdLine, CursorPos)
    let l:cd = getcwd()
    lcd `=expand('%:p:h')`
    let l:ret = glob(a:ArgLead . '*')
    lcd `=l:cd`

    return l:ret
endfunction

let g:loaded_eev = 1

" vim: foldmethod=marker
