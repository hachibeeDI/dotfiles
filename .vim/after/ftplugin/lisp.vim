if exists('b:did_ftplugin_lisp')
    finish
endif
let b:did_ftplugin_lisp = 1

autocmd FileType lisp :RainbowParenthesesToggle

