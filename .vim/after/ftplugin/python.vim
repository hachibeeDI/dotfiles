if exists('b:did_ftplugin_python')
    finish
endif
let b:did_ftplugin_python = 1

setlocal foldmethod=indent
setlocal commentstring=#%s
" python.vim (default bundled syntax plugin)
let python_highlight_all = 1

setlocal omnifunc=jedi#completions
