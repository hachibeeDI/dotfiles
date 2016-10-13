if exists('b:did_ftplugin_python')
    finish
endif
let b:did_ftplugin_python = 1

setlocal shiftwidth=4
setlocal tabstop=4
setlocal smarttab
setlocal expandtab
setlocal foldmethod=indent
setlocal commentstring=#%s

" - af: a function
" - if: inner function
" - ac: a class
" - ic: inner class

" this plugin has aditional key-bind
"  -  '[pf', ']pf': move to next/previous function
"  -  '[pc', ']pc': move to next/previous class
xmap <buffer> af <Plug>(textobj-python-function-a)
omap <buffer> af <Plug>(textobj-python-function-a)
xmap <buffer> if <Plug>(textobj-python-function-i)
omap <buffer> if <Plug>(textobj-python-function-i)
xmap <buffer> ac <Plug>(textobj-python-class-a)
omap <buffer> ac <Plug>(textobj-python-class-a)
xmap <buffer> ic <Plug>(textobj-python-class-i)
omap <buffer> ic <Plug>(textobj-python-class-i)

if has_key(g:, 'vimrc_sid')
  call function("<SNR>".g:vimrc_sid."_def_smartchar")()
endif

setlocal omnifunc=jedi#completions
