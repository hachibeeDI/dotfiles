if exists('b:did_ftplugin_go')
    finish
endif
let b:did_ftplugin_go = 1

" goの標準スタイルはハードタブ
setlocal noexpandtab
setlocal tabstop=4

setlocal errorformat=File\ %f,(%l\\,%c):%m

