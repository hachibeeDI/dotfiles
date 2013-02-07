if exists('b:did_ftplugin_unite')
    finish
endif
let b:did_ftplugin_unite = 1

" ウィンドウを分割して開く
nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
nnoremap <silent> <buffer> <esc><esc> <esc>:q<CR>
inoremap <silent> <buffer> <esc><esc> <esc>:q<CR>
