" NeoVim specific settings

" FIXME: more generic way to set the path
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

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
source ~/.vim/keymap.unite.vim

if exists('g:nyaovim_version')
  " Write NyaoVim specific code here
  colorscheme hazard
endif
