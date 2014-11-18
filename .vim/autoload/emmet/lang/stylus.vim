
function! emmet#lang#stylus#findTokens(str)
  return emmet#lang#sass#findTokens(a:str)
endfunction

function! emmet#lang#stylus#parseIntoTree(abbr, type)
  echom a:abbr
  return emmet#lang#sass#parseIntoTree(a:abbr, a:type)
endfunction

function! emmet#lang#stylus#toString(settings, current, type, inline, filters, itemno, indent)
  "echom 'current ==============='
  "for kv in items(a:current)
  "  if type(kv[1]) == 4
  "    echom kv[0] . ' ------------------'
  "    for _kv in items(kv[1])
  "      echom string(_kv)
  "    endfor
  "  else
  "    echom string(kv)
  "  endif
  "endfor
  "echom 'inline ------------------'
  "echom a:inline
  return emmet#lang#sass#toString(a:settings, a:current, a:type, a:inline, a:filters, a:itemno, a:indent)
endfunction

function! emmet#lang#stylus#imageSize()
endfunction

function! emmet#lang#stylus#encodeImage()
endfunction

function! emmet#lang#stylus#parseTag(tag)
endfunction

function! emmet#lang#stylus#toggleComment()
endfunction

function! emmet#lang#stylus#balanceTag(flag) range
  call emmet#lang#sass#balanceTag(a:flag)
endfunction

function! emmet#lang#stylus#moveNextPrevItem(flag)
  return emmet#lang#sass#moveNextPrev(a:flag)
endfunction

function! emmet#lang#stylus#moveNextPrev(flag)
  call emmet#lang#sass#moveNextPrev(a:flag)
endfunction

function! emmet#lang#stylus#splitJoinTag()
endfunction

function! emmet#lang#stylus#removeTag()
endfunction
