if exists('b:did_ftplugin_haskell')
    finish
endif
let b:did_ftplugin_haskell = 1

setlocal softtabstop=2
setlocal shiftwidth=2

augroup ghcmodcheck
  autocmd! BufWritePost <buffer> GhcModCheckAsync
augroup END

setlocal omnifunc=necoghc#omnifunc
