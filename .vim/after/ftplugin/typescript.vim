if exists('b:did_ftplugin_typescript')
    finish
endif
let b:did_ftplugin_typescript = 1

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

if exists('*TSScompleteFunc') &&  &omnifunc ==# ''
  setlocal omnifunc=TSScompleteFunc
endif
