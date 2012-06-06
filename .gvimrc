
" transparency->more
nnoremap <up> :<C-u>call <SID>relative_tranparency(5)<Cr>
inoremap <up> <C-o>:call <SID>relative_tranparency(5)<Cr>

" transparency->less
nnoremap <down> :<C-u>call <SID>relative_tranparency(-5)<Cr>
inoremap <down> <C-o>:call <SID>relative_tranparency(-5)<Cr>

"reset-trancparency
nnoremap <Esc><Esc> :<C-u>let &transparency = g:transparency<Cr><C-l>

colorscheme zenburn

if has('gui_macvim')
    set showtabline=2  " タブを常に表示
    set imdisable      " IMを無効化
    set transparency=5 " 透明度を指定
    map <silent> gw :macaction selectNextWindow:
    map <silent> gW :macaction selectPreviousWindow:
endif
