" [quickfix を便利に使う設定](http://d.hatena.ne.jp/thinca/20130708/1373210009)

noremap <buffer> p <CR>zz<C-w>p

setlocal statusline+=\ %L

noremap <silent> <buffer> <expr> j <SID>tb_loop(v:count1)
noremap <silent> <buffer> <expr> k <SID>tb_loop(-v:count1)

function! s:tb_loop(motion)
  " if line has no index infomation, this function ignore that.
  " and loop top and bottom when reach there.
  let max = line('$')
  let list = getloclist(0)
  if empty(list) || len(list) != max
    let list = getqflist()
  endif
  let cur = line('.') - 1
  let pos = g:Vit.Math.modulo(cur + a:motion, max)
  let m = 0 < a:motion ? 1 : -1
  while cur != pos && list[pos].bufnr == 0
    let pos = g:Vit.Math.modulo(pos + m, max)
  endwhile
  return (pos + 1) . 'G'
endfunction


nnoremap <silent> <buffer> dd :call <SID>del_entry()<CR>
nnoremap <silent> <buffer> x :call <SID>del_entry()<CR>
vnoremap <silent> <buffer> d :call <SID>del_entry()<CR>
vnoremap <silent> <buffer> x :call <SID>del_entry()<CR>

function! s:del_entry() range
  " delete like a normal buffer.
  let qf = getqflist()
  let history = get(w:, 'qf_history', [])
  call add(history, copy(qf))
  let w:qf_history = history
  unlet! qf[a:firstline - 1 : a:lastline - 1]
  call setqflist(qf, 'r')
  execute a:firstline
endfunction

nnoremap <silent> <buffer> u :<C-u>call <SID>undo_entry()<CR>

function! s:undo_entry()
  let history = get(w:, 'qf_history', [])
  if !empty(history)
    call setqflist(remove(history, -1), 'r')
  endif
endfunction
