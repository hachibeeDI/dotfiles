" NeoVim specific settings

let g:python_host_prog = system('echo -n $(which python2)')
let g:python3_host_prog = system('echo -n $(which python3)')

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
" see also: https://github.com/jwilm/alacritty/issues/109
set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum
" let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
" let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
" set termguicolors

source ~/.vim/environments.rc.vim

" show substitution interactively
set inccommand=split

"set autogroup
augroup MyAutoCmd
  autocmd!
augroup END

source ~/.vim/plugin-settings/bootstrap.vim

source ~/.vim/common.rc.vim
set viminfo& viminfo+=n~/.vimcache/nviminfo

source ~/.vim/keymap.rc.vim

if exists('g:nyaovim_version')
  " Write NyaoVim specific code here
  colorscheme hazard
  inoremap <D-v> <C-r>"
  nnoremap <D-v> <C-r>"
  cnoremap <D-v> <C-r>"
  nnoremap <D-t> :<C-u>tabnew<CR>
endif


source ~/.vimrc.local
