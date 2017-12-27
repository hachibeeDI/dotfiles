let s:is_neovim = has('nvim')


if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_repo = $HOME.'/.ghq/github.com/Shougo/dein.vim'
" Required:
set runtimepath+=~/.ghq/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.dein/')
  call dein#begin('~/.dein/')

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_repo)

  call dein#load_toml('~/.vim/plugin-settings/general.toml')
  if s:is_neovim
    call dein#load_toml('~/.vim/plugin-settings/nvim.toml')
  else
    call dein#load_toml('~/.vim/plugin-settings/plain-vim.toml')
  endif


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif















"
"
" 
" 
" let s:BUNDLEPATH = expand('~/.neobundle')
" 
" 
" " Neobundle {{{
" if has('vim_starting')
"   " via: https://twitter.com/ShougoMatsu/status/541718069010128896
"   " set nocompatible
"   set runtimepath& runtimepath+=~/.vim/neobundle.vim/
" 
"   if executable('gom')
"     set rtp+=$HOME/.go/src/github.com/mattn/gom/misc/vim
"     autocmd MyAutoCmd Filetype go SetGomEnv
"     if &ft ==# 'go'
"       :SetGomEnv
"     endif
"   endif
" 
" endif
" call g:neobundle#begin(s:BUNDLEPATH)
" 
" 
" let g:neobundle#log_filename = expand('~/.neobundle/.neobundle/neobundle.log')
" "let g:neobundle#install_max_processes = 4
" let g:neobundle#install_process_timeout = 180
" let g:neobundle#types#git#enable_submodule = 1
" 
" 
" if g:neobundle#load_cache()
" 
"   call neobundle#load_toml("~/.vim/plugin-settings/general.toml", {})
"   if s:is_neovim
"     call neobundle#load_toml("~/.vim/plugin-settings/nvim.toml", {})
"   else
"     call neobundle#load_toml("~/.vim/plugin-settings/plain-vim.toml", {})
"   endif
" 
"   " ---------- utils for edit {{{
"     " in $HOME/.vim/after/ftplugin/python.vim
"   " }}}
" 
"   " NeoBundle 'hachibeeDI/vim-textobj-continuous-line', {
"   " \ 'base': expand('~/Dropbox/development/viml/'),
"   " \ 'type': 'nosync',
"   " \ }
" 
"   "textobj-user }}}
" 
"   " }}}
" 
"   " === Language surpport === {{{
"   " NeoBundleLazy 'hachibeeDI/rope-vim', {
"   " \ 'autoload' : {
"   " \   'filetypes' : ['python'],
"   " \ },
"   " \ 'disabled' : !has('python'),
"   " \ 'base': expand('~/Dropbox/development/viml/'),
"   " \ 'type': 'nosync',
"   " \}
" 
"   " }}}
"   " -- Haxe {{{
"   if executable('haxe')
"     NeoBundleLazy 'jdonaldson/vaxe', {
"         \ 'autoload' : {
"         \   'filetypes' : ['haxe', 'hxml', 'nmml.xml'],
"         \ }
"         \}
"     NeoBundleLazy 'hachibeeDI/unite-vaxe', {
"     \ 'autoload' : {
"     \   'filetypes' : ['haxe', 'hxml', 'nmml.xml'],
"     \   'unite_sources' : 'vaxe'},
"     \ }
"   endif
" 
"   "  }}}
" 
" 
"   " if s:is_neovim
"     " LSP completion should be fine than ternjs in idea itselfs. But implementaions are still unstable.
"     " NeoBundle 'autozimu/LanguageClient-neovim'
"     " set hidden
"     "
"     " let g:LanguageClient_serverCommands = {
"     " \ 'javascript': ['/home/ogura/.nodebrew/current/bin/javascript-typescript-stdio'],
"     " \ 'javascript.jsx': ['/home/ogura/.nodebrew/current/bin/javascript-typescript-stdio'],
"     " \ }
"     "
"     " " Automatically start language servers.
"     " let g:LanguageClient_autoStart = 1
"     "
"     " nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"     " nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"     " nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
"   " endif
" 
"   " --- style sheets {{{
"   " css_color is too heavy... ...
"   "" seems more useful then css_color.vim
"   "NeoBundleLazy 'skammer/vim-css-color', {
"   "    \ 'autoload' : {
"   "    \   'filetypes' : ['css', 'less', 'scss', 'sass'] }
"   "    \}
" 
"   " }}}
" 
"   " === }}}
" 
"   source ~/.vim/plugin.rc.vim
" 
"   call g:neobundle#end()
"   " Installation check.
"   NeoBundleCheck
" 
" 
"   if !has('vim_starting')
"     " Call on_source hook when reloading .vimrc.
"     call g:neobundle#call_hook('on_source')
"   endif
"   " Neobundle }}}
" 
" endif
