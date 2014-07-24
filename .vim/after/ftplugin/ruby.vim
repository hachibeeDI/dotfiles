if exists('b:did_ftplugin_ruby')
    finish
endif
let b:did_ftplugin_ruby = 1

setlocal softtabstop=2 shiftwidth=2

setlocal omnifunc=rubycomplete#Complete

