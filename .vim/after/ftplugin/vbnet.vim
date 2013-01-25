if exists('b:did_ftplugin_vbnet')
    finish
endif
let b:did_ftplugin_vbnet = 1
let s:cpo_save = &cpo
set cpo&vim


setlocal cinkeys-=0#
setlocal indentkeys-=0#
setlocal suffixesadd=.vb
setlocal comments-=:%
setlocal commentstring='%s

fun! <SID>VbSearch(pattern, flags)
    let cnt = v:count1
    while cnt > 0
      call search(a:pattern, a:flags)
      let cnt = cnt - 1
    endwhile
endfun


nnoremap <buffer> <silent> [[ :call <SID>VbSearch('^\s*\(\(private\|public\)\s\+\)\=\(function\\|sub\)', 'bW')<cr>
nnoremap <buffer> <silent> ]] :call <SID>VbSearch('^\s*\(\(private\|public\)\s\+\)\=\(function\\|sub\)', 'W')<cr>
nnoremap <buffer> <silent> [] :call <SID>VbSearch('^\s*\<end\>\s\+\(function\\|sub\)', 'bW')<cr>
nnoremap <buffer> <silent> ][ :call <SID>VbSearch('^\s*\<end\>\s\+\(function\\|sub\)', 'W')<cr>


let &cpo = s:keepcpo
unlet s:keepcpo
