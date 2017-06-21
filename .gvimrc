" commonsettings{{{
let g:no_gvimrc_example = 1

"set imdisable      " IMを無効化

map <silent> gw :macaction selectNextWindow:
map <silent> gW :macaction selectPreviousWindow:

nnoremap + :set transparency+=5<CR>
nnoremap - :set transparency-=5<CR>

" M: disable menu.vim
" a: add register text on OS's clip boald
" c: use cmdline when intaractive answer
set guioptions=Mac
"set guioptions-=m "disable menu
"set guioptions-=T "disable toolbar
"" disable right side scroll bar
"set guioptions-=r
"set guioptions-=R
"" disable right side scroll bar
"set guioptions-=l
"set guioptions-=L
"" disable horizontal scroll bar
"set guioptions-=b

if has('mac')
  colorscheme desertEx
  set transparency=5 " 透明度を指定
  set guifont=Ricty\ Diminished\ Discord:h18
  set guifontwide=Ricty\ Diminished\ Discord:h18
elseif has('win32')
    colorscheme desertEx
    set guifont=MeiryoKe_Gothic:h12
    set guifontwide=MeiryoKe_Gothic:h12
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
elseif has('win64')
    colorscheme desertEx
    "set shell='C:/cygwin/bin/zsh.exe'
    set guifont=MeiryoKe_Gothic:h12
    set guifontwide=MeiryoKe_Gothic:h12
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
elseif has('unix')
    colorscheme desertEx
    " set transparency=5 " 透明度を指定
    set guifont=Noto\ Sans\ Mono\ CJK\ JP
    set guifontwide=Noto\ Sans\ Mono\ CJK\ JP
    set background=dark
endif

" フォントによってはambiwidthが勝手に解除されたりするのでもっかいセットする
set ambiwidth=double

set antialias
"}}}


"auto save window size
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif


source ~/.gvimrc.local


" vim:ft=vim:fdm=marker:
