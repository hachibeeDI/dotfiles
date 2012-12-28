" commonsettings{{{
let g:no_gvimrc_example = 1

set showtabline=2  " タブを常に表示
"set imdisable      " IMを無効化

NeoBundleSource vimshell
NeoBundleSource Color-Sampler-Pack
NeoBundleSource vim-colors-solarized
NeoBundleSource unite-colorscheme
NeoBundleSource unite-font

map <silent> gw :macaction selectNextWindow:
map <silent> gW :macaction selectPreviousWindow:

nnoremap + :set transparency+=5<CR>
nnoremap - :set transparency-=5<CR>

"set clipboard=unnamed
set guioptions=C

if has('mac')
    colorscheme solarized
    set transparency=5 " 透明度を指定
    set guifont=RictyDiscord-Regular-Powerline:h28
    "set guifontwide=RictyDiscord-Regular-Powerline:h20
    set background=dark

elseif has('win32')
    colorscheme desert
    "set shell='C:/cygwin/bin/zsh.exe'
    set guifont=Source_Code_Pro:h11
    set guifontwide=Migu_1M:h11

elseif has('win64')
    colorscheme desert
    set guifont=Source_Code_Pro:h11
    set guifontwide=Migu_1M:h11
endif

" add register text on OS's clip boald
set guioptions+=a

set antialias
"}}}


"--- VimShell ----------------{{{
" This go along with vimshell doc's sample.
" My purpose of using VimShell is lessen stress of Windows and its terrible terminal-emulator!

if has('win32') || has('win64') 
  " Display user name on Windows.
  let g:vimshell_prompt = $USERNAME."% "
else
  " Display user name on Linux.
  let g:vimshell_prompt = $USER."% "

  call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
  call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
  let g:vimshell_execute_file_list['zip'] = 'zipinfo'
  call vimshell#set_execute_file('tgz,gz', 'gzcat')
  call vimshell#set_execute_file('tbz,bz2', 'bzcat')
endif

let g:vimshell_user_prompt = 'fnamemodify(getcwd(),":~")'
" let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'

autocmd FileType vimshell
\ call vimshell#altercmd#define('g', 'git')
\| call vimshell#altercmd#define('i', 'iexe')
\| call vimshell#altercmd#define('l', 'll')
\| call vimshell#altercmd#define('ll', 'ls -l')
\| call vimshell#hook#set('chpwd', ['g:my_chpwd'])
\| call vimshell#hook#set('emptycmd', ['g:my_emptycmd'])
\| call vimshell#hook#set('preprompt', ['g:my_preprompt'])
\| call vimshell#hook#set('preexec', ['g:my_preexec'])

function! g:my_chpwd(args, context)
  call vimshell#execute('echo "===================== to be continued ==================>>"')
endfunction
function! g:my_emptycmd(cmdline, context)
  call vimshell#execute('echo "emptycmd"')
  return a:cmdline
endfunction
function! g:my_preprompt(args, context)
  call vimshell#execute('echo "ズキュゥゥゥウウンッ！！ <-----------------------------------------------"')
endfunction
function! g:my_preexec(cmdline, context)
  call vimshell#execute('echo "preexec"')

  let l:args = vimproc#parser#split_args(a:cmdline)
  if len(l:args) > 0 && l:args[0] ==# 'diff'
    call vimshell#set_syntax('diff')
  endif

  return a:cmdline
endfunction

nnoremap <silent> ,vp :<C-u>VimShellPop<CR>
nnoremap <silent> ,cvp :<C-u>VimShellPop %:p:h<CR>
nnoremap <silent> ,cvs :<C-u>VimShell %:p:h<CR>
" }}}



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
