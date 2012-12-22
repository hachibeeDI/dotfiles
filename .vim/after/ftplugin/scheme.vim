if exists('b:did_ftplugin_scheme')
    finish
endif
let b:did_ftplugin_scheme = 1


NeoBundleSource rainbow_parentheses.vim
NeoBundleSource slimv.vim

autocmd FileType scheme :RainbowParenthesesToggle

