if exists('b:did_ftplugin_vimshell')
    finish
endif
let b:did_ftplugin_vimshell = 1

call vimshell#hook#set('chpwd', ['g:my_chpwd'])
    \| call vimshell#hook#set('emptycmd', ['g:my_emptycmd'])
    \| call vimshell#hook#set('preexec', ['g:my_preexec'])

" functions for command hooks {{{
function! g:my_chpwd(args, context)
  call vimshell#execute('echo "===================== to be continued ==================>>"')
endfunction
function! g:my_emptycmd(cmdline, context)
  call vimshell#execute('echo "emptycmd"')
  return a:cmdline
endfunction
function! g:my_preexec(cmdline, context)
  call vimshell#execute('echo "preexec"')

  let l:args = vimproc#parser#split_args(a:cmdline)
  if len(l:args) > 0 && l:args[0] ==# 'diff'
    call vimshell#set_syntax('diff')
  endif

  return a:cmdline
endfunction
"}}}
