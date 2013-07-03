if exists('b:did_ftplugin_gitcommit')
    finish
endif
let b:did_ftplugin_gitcommit = 1

nnoremap <buffer> [Show]d :<C-u>DiffGitCached<CR>

