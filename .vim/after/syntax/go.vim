scriptencoding utf-8

" vim-goが上書きをかけてくる？
" if exists('b:current_after_go_syntax')
"   finish
" endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword goSpecial err
hi link goSpecial Special

" let b:current_after_go_syntax = 'go'

let &cpo = s:cpo_save
unlet s:cpo_save
