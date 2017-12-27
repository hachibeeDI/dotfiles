let s:is_neovim = has('nvim')
let s:BUNDLEPATH = expand('~/.neobundle')

" Neobundle {{{
if has('vim_starting')
  " via: https://twitter.com/ShougoMatsu/status/541718069010128896
  " set nocompatible
  set runtimepath& runtimepath+=~/.vim/neobundle.vim/

  if executable('gom')
    set rtp+=$HOME/.go/src/github.com/mattn/gom/misc/vim
    autocmd MyAutoCmd Filetype go SetGomEnv
    if &ft ==# 'go'
      :SetGomEnv
    endif
  endif

endif
call g:neobundle#begin(s:BUNDLEPATH)


let g:neobundle#log_filename = expand('~/.neobundle/.neobundle/neobundle.log')
"let g:neobundle#install_max_processes = 4
let g:neobundle#install_process_timeout = 180
let g:neobundle#types#git#enable_submodule = 1


if g:neobundle#load_cache()

  call neobundle#load_toml("~/.vim/plugin-settings/general.toml", {})
  if s:is_neovim
    call neobundle#load_toml("~/.vim/plugin-settings/nvim.toml", {})
  else
    call neobundle#load_toml("~/.vim/plugin-settings/plain-vim.toml", {})
  endif

  " NeoBundleLazy 'airblade/vim-rooter', {
  " \ 'autoload': {
  " \   'mappings': ['<Plug>RooterChangeToRootDirectory'],
  " \   'commands': ['Rooter'],
  " \ },
  " \}
  let g:rooter_manual_only = 1
  let g:rooter_disable_map = 1
  nmap <silent> <unique> <Space>rt <Plug>RooterChangeToRootDirectory

  " NeoBundleLazy 'majutsushi/tagbar', {
  " \ 'autoload' : {
  " \   'commands' : ['Tagbar', 'TagbarToggle'],
  " \ }
  " \}
  nnoremap <Space>T :<C-u>Tagbar<CR>


  " ---------- utils for edit {{{
    " in $HOME/.vim/after/ftplugin/python.vim
  " }}}

  " NeoBundle 'hachibeeDI/vim-textobj-continuous-line', {
  " \ 'base': expand('~/Dropbox/development/viml/'),
  " \ 'type': 'nosync',
  " \ }

  "textobj-user }}}

  " NeoBundleLazy 'kana/vim-smartword', { 'autoload' : {
  "       \ 'mappings' : [
  "       \   '<Plug>(smartword-w)', '<Plug>(smartword-b)', '<Plug>(smartword-ge)']
  "       \ }}
  " NeoBundleLazy 'kana/vim-smarttill', { 'autoload' : {
  "       \ 'mappings' : [
  "       \   '<Plug>(smarttill-t)', '<Plug>(smarttill-T)']
  "       \ }}
  " smartword.vim"{{{
  " Replace w and others with smartword-mappings
  nmap w  <Plug>(smartword-w)
  nmap b  <Plug>(smartword-b)
  nmap ge  <Plug>(smartword-ge)
  xmap w  <Plug>(smartword-w)
  xmap b  <Plug>(smartword-b)
  " Operator pending mode.
  omap <Leader>w  <Plug>(smartword-w)
  omap <Leader>b  <Plug>(smartword-b)
  omap <Leader>ge  <Plug>(smartword-ge)
  "}}}

  " }}}

  " " undo history visualizer
  " NeoBundleLazy 'sjl/gundo.vim', {
  " \ 'autoload' : {
  " \   'commands' : ['GundoToggle'],
  " \ }
  " \}
  " ----- Gundo.vim --- {{{
  nnoremap U :<C-u>GundoToggle<CR>
  " ---- }}}

  " NeoBundleLazy 'hachibeeDI/vim-operator-codic', {
  " \ 'autoload': {
  " \   'mappings' : '<Plug>',
  " \ }}
  map x <Plug>(operator-codic)

  " NeoBundleLazy 'LeafCage/foldCC', {
  " \ 'autoload' : {
  " \   'functions' : ['FoldCCtext'],
  " \ }
  " \}
  " via: http://d.hatena.ne.jp/leafcage/20111223/1324705686
  set foldtext=FoldCCtext()
  "set foldcolumn=5

  " === Language surpport === {{{

  " Flake8-vim {{{
  let g:PyFlakeOnWrite = 1
  " 無視する警告の種類
  " E501 => 行ごとの文字数制限, E121 => 次行のインデントはひとつだけ, E303 => 改行の数が多すぎる, E309 => クラスの後は一行あける（コメント書けないじゃん）
  let g:PyFlakeDisabledMessages = 'E501,E121,E303,E309'
  " エラー行のマーカー。hierあればいらねー
  let g:PyFlakeSigns = 0
  " flake8-autoをかけるためのコマンド。visual-modeでの範囲選択に対応
  let g:PyFlakeRangeCommand = 'Q'
  let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
  " McCabe複雑度の最大値
  let g:PyFlakeDefaultComplexity=10
  " Be aggressive for autopep8
  let g:PyFlakeAggressive = 1
  " }}}
  " NeoBundleLazy 'flake8-vim', {
  " \ 'autoload' : {
  " \   'filetypes' : ['python'],
  " \ },
  " \ 'base': expand('~/Dropbox/development/viml/'),
  " \ 'type': 'nosync',
  " \}

  " NeoBundleLazy 'hachibeeDI/rope-vim', {
  " \ 'autoload' : {
  " \   'filetypes' : ['python'],
  " \ },
  " \ 'disabled' : !has('python'),
  " \ 'base': expand('~/Dropbox/development/viml/'),
  " \ 'type': 'nosync',
  " \}

  " }}}
  " - - golang {{{
  " NeoBundleLazy 'fatih/vim-go', {
  " \   'autoload': {'filetypes': ['go']},
  " \ }
  au MyAutoCmd FileType go nmap <Leader>s <Plug>(go-implements)
  au MyAutoCmd FileType go nmap <Leader>i <Plug>(go-info)
  let g:go_auto_type_info = 1
  let g:go_fmt_command = 'goimports'
  " }}}
  " -- Haxe {{{
  if executable('haxe')
    NeoBundleLazy 'jdonaldson/vaxe', {
        \ 'autoload' : {
        \   'filetypes' : ['haxe', 'hxml', 'nmml.xml'],
        \ }
        \}
    NeoBundleLazy 'hachibeeDI/unite-vaxe', {
    \ 'autoload' : {
    \   'filetypes' : ['haxe', 'hxml', 'nmml.xml'],
    \   'unite_sources' : 'vaxe'},
    \ }
  endif

  "  }}}

  " 'mxw/vim-jsx'
  let g:jsx_ext_required = 1
  let g:jsx_pragma_required = 0

  " javascript-libraries-syntax.vim = {{{
  let g:used_javascript_libs = 'jquery,underscore,requirejs,react,flux'
  "}}}

  "  'elzr/vim-json'
  let g:vim_json_syntax_conceal = 0

  " if s:is_neovim
    " LSP completion should be fine than ternjs in idea itselfs. But implementaions are still unstable.
    " NeoBundle 'autozimu/LanguageClient-neovim'
    " set hidden
    "
    " let g:LanguageClient_serverCommands = {
    " \ 'javascript': ['/home/ogura/.nodebrew/current/bin/javascript-typescript-stdio'],
    " \ 'javascript.jsx': ['/home/ogura/.nodebrew/current/bin/javascript-typescript-stdio'],
    " \ }
    "
    " " Automatically start language servers.
    " let g:LanguageClient_autoStart = 1
    "
    " nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    " nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    " nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
  " endif

  " --- style sheets {{{
  " css_color is too heavy... ...
  "" seems more useful then css_color.vim
  "NeoBundleLazy 'skammer/vim-css-color', {
  "    \ 'autoload' : {
  "    \   'filetypes' : ['css', 'less', 'scss', 'sass'] }
  "    \}

  " }}}

  " === }}}
  " NeoBundle 'junegunn/vim-easy-align'
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

  " --- lightline -- {{{
  " 'itchyny/lightline.vim'
  let g:lightline = {
  \   'component': {
  \     'virtualenv': 'venv => %{&filetype=="python"?"":virtualenv#statusline()}',
  \     'readonly': '%{&readonly?"ro":""}',
  \     'cursorsyntax': '%{synIDattr(synID(line("."), col("."), 0), "name")}'
  \   },
  \   'component_function': {
  \     'fugitive': 'MyFugitive',
  \     'filename': 'MyFilename',
  \     'vaxe': 'MyVaxe',
  \   },
  \   'separator': {'left': '', 'right': '' },
  \   'subseparator': {'left': '|', 'right': '|'},
  \   'active': {
  \     'left': [
  \           ['mode', 'paste'], ['readonly', 'filename', 'modified'], ['vaxe', 'virtualenv']],
  \     'right': [['percent', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype'], ['cursorsyntax']],
  \   },
  \   'enable': {
  \     'tabline': 0
  \   },
  \ }

  function! MyModified()
    return &filetype =~# 'help\|vimfiler\|gundo\|qf' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! MyReadonly()
    return &filetype !~? 'help\|vimfiler\|gundo\|qf' && &ro ? '錠' : ''
  endfunction

  function! MyFilename()
    return ('' !=# MyReadonly() ? MyReadonly() . ' ' : '') .
          \ (&filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
          \  &filetype ==# 'unite' ? unite#get_status_string() :
          \  &filetype ==# 'qf' ? 'quickfix' :
          \  &filetype ==# 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
          \ '' !=? expand('%:t') ? expand('%:t') : '[No Name]') .
          \ ('' !=# MyModified() ? ' ' . MyModified() : '')
  endfunction

  function! MyFugitive()
    try
      if &filetype !~? 'vimfiler\|gundo\|qf' && exists('*fugitive#head')
        let _ = fugitive#head()
        return strlen(_) ? '梗'._ : ''
      endif
    catch
    endtry
    return ''
  endfunction

  function! MyVaxe()
    if &filetype ==# 'haxe'
      return pathshorten(fnamemodify(vaxe#CurrentBuild(), ':p:.')) . ' =>[' . vaxe#CurrentBuildPlatform() . ']'
    else
      return ''
    endif
  endfunction
  " lightline }}}

  " NeoBundleLazy 'LeafCage/vimhelpgenerator', {
  " \ 'autoload' : {
  " \   'filetypes' : ['vim'],
  " \   },}
  let g:vimhelpgenerator_version = ''
  let g:vimhelpgenerator_author = 'Author : OGURA_Daiki <8hachibee125+vim @ gmail.com>'
  let g:vimhelpgenerator_contents = {
  \ 'contents': 1, 'introduction': 1, 'usage': 1, 'interface': 1,
  \ 'variables': 1, 'commands': 1, 'key-mappings': 1, 'functions': 1,
  \ 'setting': 0, 'todo': 1, 'changelog': 0
  \ }

  source ~/.vim/plugin.rc.vim

  call g:neobundle#end()
  " Installation check.
  NeoBundleCheck


  if !has('vim_starting')
    " Call on_source hook when reloading .vimrc.
    call g:neobundle#call_hook('on_source')
  endif
  " Neobundle }}}

endif
