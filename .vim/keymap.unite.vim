nnoremap <SID>[Unite] <Nop>
nmap ,u <SID>[Unite]
nnoremap <SID>[UMenu] <Nop>
nmap [Unite]t <SID>[UMenu]

nnoremap <silent>[UMenu]g :Unite -silent -start-insert menu:git<CR>

" バッファ一覧
nnoremap <silent> <SID>[Unite]b :<C-u>Unite buffer<CR>

" ファイル一覧
nnoremap <silent> <SID>[Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" .gitを基準にしたプロジェクト一覧 (ctrlp的な)
nnoremap <silent> <SID>[Unite]p :<C-u>Unite file_rec/async:!<CR>
nnoremap <silent> <D-p> :<C-u>Unite file_rec/async:!<CR>

" レジスタ一覧
nnoremap <silent> <SID>[Unite]r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> <SID>[Unite]m :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> <SID>[Unite]u :<C-u>Unite buffer file_mru<CR>
" タブ一覧
nnoremap <silent> <SID>[Unite]t :<C-u>Unite tab<CR>
" 全部乗せ
nnoremap <silent> <SID>[Unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" その他
nnoremap <silent> <SID>[Unite]` :<C-u>Unite -auto-quit neobundle/update<CR>
" Outline
nnoremap <silent> <SID>[Unite]o :<C-u>Unite -vertical outline<CR>
" grep
nnoremap <silent> <SID>[Unite]gg :<C-u>Unite giti<CR>
nnoremap <silent> <SID>[Unite]gs :<C-u>Unite giti/status<CR>
nnoremap <silent> <SID>[Unite]gb :<C-u>Unite giti/branch<CR>
" quickfix
nnoremap <silent> <SID>[Unite]q :<C-u>Unite -no-quit -direction=botright quickfix

"" neocomplete
"imap <C-i>  <Plug>(neocomplete_start_unite_complete)
"imap <C-w>  <Plug>(neocomplete_start_unite_quick_match)
" }}}
