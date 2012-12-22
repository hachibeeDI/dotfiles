if exists('b:did_ftplugin_lisp')
    finish
endif
let b:did_ftplugin_lisp = 1


NeoBundleSource rainbow_parentheses.vim

autocmd FileType lisp :RainbowParenthesesToggle

