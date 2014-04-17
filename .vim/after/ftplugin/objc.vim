if exists('b:did_ftplugin_objc')
    finish
endif
let b:did_ftplugin_objc = 1

let g:clang_auto_user_options = 'path, .clang_complete, ios'
