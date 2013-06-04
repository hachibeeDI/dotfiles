
if version < 600
  syntax clear
elseif exists("b:current_after_syntax")
  finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"

hi link pythonDelimiter    Special

let b:current_after_syntax = "python"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet:
