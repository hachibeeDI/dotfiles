if exists('b:did_ftplugin_haxe')
    finish
endif
let b:did_ftplugin_haxe = 1

" for vaxe
setl autowrite

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

RainbowParenthesesLoadBraces
