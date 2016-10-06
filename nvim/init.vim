set termguicolors
"set autogroup
augroup MyAutoCmd
  autocmd!
augroup END

source ~/.vim/common.rc.vim
set viminfo& viminfo+=n~/.vimcache/nviminfo

source ~/.vim/keymap.rc.vim
