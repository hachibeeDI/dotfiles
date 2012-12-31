if exists('b:did_ftplugin_python')
    finish
endif
let b:did_ftplugin_python = 1

set foldmethod=syntax

NeoBundleSource pyflakes-vim
NeoBundleSource jedi-vim
NeoBundleSource vim-django-support
NeoBundleSource vim-indent-guides

