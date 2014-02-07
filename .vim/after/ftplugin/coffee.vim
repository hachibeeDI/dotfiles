if exists('b:did_ftplugin_coffee')
    finish
endif
let b:did_ftplugin_coffee = 1

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

nnoremap <buffer> ,cww :<C-u>CoffeeWatch<CR>
nnoremap <buffer> ,cwv :<C-u>CoffeeWatch vert<CR>
