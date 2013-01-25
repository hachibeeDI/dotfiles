" Vim indent file

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nolisp
setlocal autoindent

setlocal indentexpr=VbNetGetIndent(v:lnum)
setlocal indentkeys&
setlocal indentkeys+=!^F,o,O,=~catch,=~else,=~elseif,=~end,=~next,<:>

" Only define the function once.
if exists("*VbNetGetIndent")
  finish
endif
let s:keepcpo= &cpo
set cpo&vim


fun! VbNetGetIndent(lnum)
  " labels and preprocessor get zero indent immediately
  let this_line = getline(a:lnum)
  let LABELS_OR_PREPROC = '^\s*\(\<\k\+\>:\s*$\|#.*\)'
  if this_line =~? LABELS_OR_PREPROC
    return 0
  endif

  " Find a non-blank line above the current line.
  " Skip over labels and preprocessor directives.
  let lnum = a:lnum
  while lnum > 0
    let lnum = prevnonblank(lnum - 1)
    let previous_line = getline(lnum)
    if previous_line !~? LABELS_OR_PREPROC
      let pp_line = getline(lnum - 1)
      break
    endif
  endwhile

  " Hit the start of the file, use zero indent.
  if lnum == 0
    return 0
  endif

  let ind = indent(lnum)

  if this_line =~? '^\s*#'
    return 0
  endif

  if previous_line =~? '\s_$'
    let ind = ind + &sw
  endif

  if pp_line =~? '\s_$'
    let ind = ind - &sw
  endif

  if previous_line =~? '>\s\+_$'
    let ind = ind - &sw
  endif

  " Add
  if previous_line =~? '^\s*\(\(Public\|Protected\|Protected Friend\|Private\|Friend\|Overrides\|Overridable\|Overloads\|NotOverridable\|MustOverride\|Shadows\|Shared\|ReadOnly\|WriteOnly\)\s\+\)*\<\(Function\|Sub\|Class\|Module\|Namespace\|Property\|Get\|Set\|Custom Event\|Enum\)\>'
      \ || previous_line =~? '^\s*\<\(AddHandler\|RemoveHandler\|RaiseEvent\)\s*('
    let ind = ind + &sw
    if pp_line =~? '>\s\+_$'
      let ind = ind + &sw
    endif
  elseif previous_line =~? '^\s*<[A-Z]' && previous_line =~? '>\s\+\(\(Public\|Protected\|Protected Friend\|Private\|Friend\|Overrides\|Overridable\|Overloads\|NotOverridable\|MustOverride\|ReadOnly\|WriteOnly\|Shadows\|Shared\)\s\+\)*\<\(Function\|Sub\|Class\|Module\|Namespace\|Property\|Get\|Set\|Enum\)\>'
    let ind = ind + &sw
  elseif previous_line =~? '^\s*\<\(Select\|Case\|Default\|Else\|ElseIf\|Do\|For\|While\|With\|SyncLock\|Using\|Try\|Catch\|Finally\)\>'
    let ind = ind + &sw
  elseif previous_line =~? '\<Then$'
    let ind = ind + &sw
  endif

  " Subtract
  if this_line =~? '^\s*\<End\>\s\+\<Select\>'
    if previous_line !~? '^\s*\<Select\>'
      let ind = ind - 2 * &sw
    else
      " this case is for an empty 'select' -- 'end select'
      " (w/o any case statements) like:
      "
      " select case readwrite
      " end select
      let ind = ind - &sw
    endif
  elseif this_line =~? '^\s*\<\(Catch\|End\|Else\|ElseIf\|Until\|Loop\|Next\)\>'
    let ind = ind - &sw
  elseif this_line =~? '^\s*\<\(Case\)\>'
    if previous_line !~? '^\s*\<Select\>'
      let ind = ind - &sw
    endif
  endif

return ind
endfun
