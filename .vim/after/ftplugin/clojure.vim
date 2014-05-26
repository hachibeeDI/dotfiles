if exists('b:did_ftplugin_clojure')
    finish
endif
let b:did_ftplugin_clojure = 1

" simple word completion
setlocal omnifunc=clojurecomplete#Complete
