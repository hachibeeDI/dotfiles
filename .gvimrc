" commonsettings{{{
let g:no_gvimrc_example = 1

"set imdisable      " IMを無効化

map <silent> gw :macaction selectNextWindow:
map <silent> gW :macaction selectPreviousWindow:

nnoremap + :set transparency+=5<CR>
nnoremap - :set transparency-=5<CR>

set guioptions=C
" add register text on OS's clip boald
set guioptions+=a

if has('mac')
  colorscheme desertEx
  set transparency=5 " 透明度を指定
  set guifont=Ricty\ Discord:h19
  set guifontwide=Ricty\ Discord:h19
elseif has('win32')
    colorscheme desertEx
    "set shell='C:/cygwin/bin/zsh.exe'
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
    set transparency=5 " 透明度を指定
    set guifont=Ricty\ Discord\ h20
    set guifontwide=Ricty\ Discord\ h20
    set background=dark
endif


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


" vim:ft=vim:fdm=marker:
