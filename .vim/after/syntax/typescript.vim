if get(b:, 'current_after_syntax', '') == 'typeScript'
  finish
endif


" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim


syn keyword typeScriptSpecialWord constructor
syn keyword typeScriptSpecialWord !

" hi link typeScriptSpecialMethod  Structure
hi link typeScriptSpecialWord    Special


let b:current_after_syntax = 'typeScript'


let &cpo = s:cpo_save
unlet s:cpo_save


" vim:set sw=2 sts=2 ts=8 noet:
