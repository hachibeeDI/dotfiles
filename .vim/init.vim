source ~/.vim/environments.rc.vim

set termguicolors
"set autogroup
augroup MyAutoCmd
  autocmd!
augroup END

" It should upgrade to Dein.vim soon
source ~/.vim/neobundle.bootstrap.vim

source ~/.vim/common.rc.vim
set viminfo& viminfo+=n~/.vimcache/nviminfo

source ~/.vim/keymap.rc.vim
