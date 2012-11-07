" commonsettings{{{
set showtabline=2  " タブを常に表示
"set imdisable      " IMを無効化

map <silent> gw :macaction selectNextWindow:
map <silent> gW :macaction selectPreviousWindow:

if has('mac')
    colorscheme solarized
    set transparency=5 " 透明度を指定
    set guifont=RictyDiscord-Regular-Powerline:h20
    set background=dark

elseif has('win32')
    colorscheme desert
    set clipboard=unnamed,autoselect
    "set shell='C:/cygwin/bin/zsh.exe'
    set guifont=Source_Code_Pro:h11
    set guifontwide=Migu_1M:h11
    set guioptions-=m
elseif has('win64')
    colorscheme desert
    set clipboard=unnamed,autoselect
    "set shell='C:/cygwin/bin/zsh.exe'
    set guifont=Source_Code_Pro:h11
    set guifontwide=Migu_1M:h11
    set guioptions-=m
endif

" add register text on OS's clip boald
set guioptions+=a

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


"vim:ft=vim:fdm=marker:fen:
