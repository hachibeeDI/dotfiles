if exists('b:did_ftplugin_clojure')
    finish
endif
let b:did_ftplugin_clojure = 1

autocmd FileType clojure :RainbowParenthesesToggle

