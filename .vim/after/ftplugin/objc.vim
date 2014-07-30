if exists('b:did_ftplugin_objc')
    finish
endif
let b:did_ftplugin_objc = 1

setlocal tabstop=2 softtabstop=2 shiftwidth=2

let g:clang_auto_user_options = 'path, .clang_complete, ios'
let g:clang_complete_getopts_ios_ignore_directories = ["^\.git",  "\.xcodeproj"]

nnoremap <buffer> <silent> <D-C-UP> :call <SID>AlternateFile()<CR>
nnoremap <buffer> <silent> <D-UP> :call <SID>AlternateFile()<CR>

function! s:AlternateFile()
  let filename_without_extensions = expand('%:p:r')
  let extensions = expand('%:e')
  if extensions == 'm'
    execute 'e ' . filename_without_extensions . '.' . 'h'
  elseif extensions == 'h'
    execute 'e ' . filename_without_extensions . '.' . 'm'
  else
    echoh ErrorMsg | echo 'unsupported file extensions.' | echoh None
  endif
endf
