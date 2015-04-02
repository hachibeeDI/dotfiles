
if version < 600
  syntax clear
elseif exists('b:current_after_syntax')
  finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self
syn keyword pythonSpecialMethod __init__ __add__ __metaclass__ __slots__ __init__
syn keyword pythonSpecialMethod __abs__ __add__ __and__ __ror__ __rshift__ __concat__
syn keyword pythonSpecialMethod __or__ __lt__ __le__ __eq__ __ne__ __ge__
syn keyword pythonSpecialMethod __gt__ __nonzero__ __len__ __floordiv__

hi link pythonSpecialMethod  Structure
hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special

let b:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet:
