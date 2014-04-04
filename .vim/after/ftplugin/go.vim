if exists('b:did_ftplugin_go')
    finish
endif
let b:did_ftplugin_go = 1

" goの標準スタイルはハードタブ
setlocal noexpandtab
setlocal tabstop=4

" golint
if !executable("golint")
    finish
endif

command! -buffer Lint call s:GoLint()

function! s:GoLint() abort
    cexpr system('golint ' . shellescape(expand('%')))
endfunction
