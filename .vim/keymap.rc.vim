" ======== Key Mapping ========

nnoremap <C-j> *
nnoremap <C-k> #

" disable unuseful keys {{{
"<NPA> means to unset command on keymap
nnoremap q: <NOP>
nnoremap Q <NOP>
" same as :wq
nnoremap ZZ <NOP>
" same as :q!
nnoremap ZQ <Nop>
" }}}

" modify existing behavior {{{

":はコマンドモードへの移行、;はfind時に次の該当単語へジャンプする
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <Backspace> :%s/

nnoremap Y y$

" x,y,cで削除した文字はblack holeに行ってもらう.
" NOTE: xはいらないので別のkeymapで使う
" nnoremap x "_x
nnoremap s "_s
nnoremap c "_c
" vnoremap x "_x
vnoremap s "_s
vnoremap c "_c
onoremap c "_c

" adjust buffer size
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
nnoremap <Left> <C-w>>
nnoremap <Right> <C-w><


" Ctrl + C は、`insert modeの強制終了`なので微妙に挙動が変わる。直感に反するので統一
inoremap <C-c> <Esc>

" 行頭と空白抜きの先頭をトグルする
nnoremap <expr> 0
\         col('.') ==# 1 ? '^' : '0'
"nnoremap _ 0
onoremap 0 ^
onoremap _ 0


" }}}

" edit on normal mode {{{
" カーソルを移動せずに改行 http://qiita.com/kentaro/items/42159874a0637d57ae1a
nnoremap go :<C-u>call append('.', '')<CR>
nnoremap gO :normal! O<ESC>j

" Insert Space in normal-mode
nnoremap <Space><Space> i<Space><Esc><Right>
" }}}


" behavior like as emac in insert mode {{{
inoremap <C-a> <Home>
" inoremap <C-e> <End> neocomplete
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-h> <Backspace>
cnoremap <C-d> <Del>
" FIXME
cnoremap <C-k> <Del><Del><Del><Del><Del><Del><Del><Del><Del><Del><Del><Del><Del><Del><Del>
" }}}

" -- mapping to show status
" via: http://vim-users.jp/2010/05/hack-144/
nnoremap <SID>[Show] <Nop>
nmap <Space>s <SID>[Show]
nnoremap <SID>[Show]m  :<C-u>Capture marks<CR>
nnoremap <SID>[Show]k  :<C-u>Capture map<CR>
nnoremap <SID>[Show]r  :<C-u>Capture registers<CR>
nnoremap <SID>[Show]e  :<C-u>edit $MYVIMRC<CR>
nnoremap <SID>[Show]l  :<C-u>source $MYVIMRC<CR>
nnoremap <SID>[Show]q  :<C-u>tab help<Space>
nnoremap <SID>[Show]hc  :<C-u>HierClear<CR>
nnoremap <SID>[Show]hs  :<C-u>HierStart<CR>
nnoremap <SID>[Show]hp  :<C-u>HierStop<CR>
nnoremap <SID>[Show]hu  :<C-u>HierUpdate<CR>

" vim Hack: http://vim-users.jp/2010/07/hack159/ {{{
nnoremap <SID>(split-to-j) :<C-u>execute 'belowright' (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <SID>(split-to-k) :<C-u>execute 'aboveleft'  (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <SID>(split-to-h) :<C-u>execute 'topleft'    (v:count == 0 ? '' : v:count) 'vsplit'<CR>
nnoremap <SID>(split-to-l) :<C-u>execute 'botright'   (v:count == 0 ? '' : v:count) 'vsplit'<CR>

nmap spj <SID>(split-to-j)
nmap spk <SID>(split-to-k)
nmap sph <SID>(split-to-h)
nmap spl <SID>(split-to-l)
" }}}

nnoremap <Esc><Esc> :<C-u>nohlsearch <Bar> cclose<CR><Esc>

" toggle set spell
nnoremap <SID>[Show]s  :<C-u>setl spell!<CR>


nnoremap <SID>[EditSupport] <Nop>
nmap , <SID>[EditSupport]

" substitute word is under cursor
nnoremap <expr> <SID>[EditSupport]s* ':%substitute/\<' . expand('<cword>') . '\>/'
nnoremap <expr> <SID>[EditSupport]e* ':' . line('.') . ',$s/\<' . expand('<cword>') . '\>/'




" =================== 既存のキーマップを割と大幅に変えるもの {{{

" Like builtin getchar() but returns string always.
" and do inputsave()/inputrestore() before/after getchar().
function! s:getchar_safe(...)
  let c = s:input_helper('getchar', a:000)
  return type(c) == type('') ? c : nr2char(c)
endfunction

" Like builtin getchar() but
" do inputsave()/inputrestore() before/after input().
function! s:input_safe(...)
    return s:input_helper('input', a:000)
endfunction

" Do inputsave()/inputrestore() before/after calling a:funcname.
function! s:input_helper(funcname, args)
    let success = 0
    if inputsave() !=# success
        throw 'inputsave() failed'
    endif
    try
        return call(a:funcname, a:args)
    finally
        if inputrestore() !=# success
            throw 'inputrestore() failed'
        endif
    endtry
endfunction

nnoremap <expr><silent> f '/\V'.<SID>getchar_safe()."\<CR>:nohlsearch\<CR>"
nnoremap <expr><silent> F '?\V'.<SID>getchar_safe()."\<CR>:nohlsearch\<CR>"
nnoremap <expr><silent> t '/.\ze\V'.<SID>getchar_safe()."\<CR>:nohlsearch\<CR>"
nnoremap <expr><silent> T '?\V'.<SID>getchar_safe().'\v\zs.'."\<CR>:nohlsearch\<CR>"



" NOTE: <expr>は副作用(カーソルの移動とか)を許可しないので使えない
" preview error line in quickfix
nnoremap <M-p> :<C-u>call <SID>loop_qfpreview()<CR>
function! s:loop_qfpreview()
  try
    cprevious
  catch /E553/
    clast
  endtry
endfunction
" next error line in quickfix
nnoremap <M-n> :<C-u>call <SID>loop_qfnext()<CR>
function! s:loop_qfnext()
  try
    cnext
  catch /E553/
    cfirst
  endtry
endfunction

command!
\  -nargs=1
\  VimGrepCurrent
\  vimgrep <args> % | cw

nnoremap <expr>* ':<C-u>VimGrepCurrent ' . expand('<cword>') . '<CR>'


" }}}



" ---------
"  Scripts with key map
"  ======================={{{

" move current directory on the above of file is editing.
" via: <http://vim-users.jp/2009/09/hack69/> {{{
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory ==# ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang ==# ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>
" }}}
