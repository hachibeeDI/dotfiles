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


NeoBundleFetch 'Shougo/neobundle.vim', {
\   'base': '~/.vim',
\ }
let g:neobundle#log_filename = expand('~/.neobundle/.neobundle/neobundle.log')
"let g:neobundle#install_max_processes = 4
let g:neobundle#install_process_timeout = 180
let g:neobundle#types#git#enable_submodule = 1

call g:neobundle#load_cache()

" gitプロトコルよりもhttpsのほうが高速
"let g:neobundle_default_git_protocol = 'https'
NeoBundle 'Shougo/vimproc.vim', {
\   'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\   }
\ }

if s:is_neovim
  NeoBundleLazy 'Shougo/deoplete.nvim', {
  \   'autoload' : {
  \     'insert' : 1,
  \ },
  \ }
else
  NeoBundleLazy 'Shougo/neocomplete.vim', {
  \   'autoload' : {
  \     'insert' : 1,
  \ },
  \   'depends' : 'Shougo/context_filetype.vim',
  \   'disabled' : !(has('lua') || has('luajit')),
  \   'vim_version' : '7.3.885'
  \ }
endif

NeoBundleLazy 'Shougo/neosnippet', {
\ 'autoload' : {
\   'mappings' : ['<Plug>(neosnippet_'],
\   'commands' : ['NeoSnippetClearMarkers', ],
\   'function_prefix' : 'neosnippet',
\ }}
NeoBundleLazy 'Shougo/neosnippet-snippets', {
\ 'autoload' : {
\   'insert' : 1,
\ },
\ }
" \ 'base': expand('~/Dropbox/development/viml/'),
" \ 'type': 'nosync',
" \ }

NeoBundle 'editorconfig/editorconfig-vim'

NeoBundle 'Shougo/vimfiler', '', 'default'
call g:neobundle#config('vimfiler', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \    'commands' : [
      \                  { 'name' : 'VimFiler',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  { 'name' : 'VimFilerExplorer',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  { 'name' : 'Edit',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  { 'name' : 'Write',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  'Read', 'Source'],
      \    'mappings' : ['<Plug>(vimfiler_switch)'],
      \    'explorer' : 1,
      \ }
      \ })
NeoBundleLazy 'Shougo/vimshell', {
    \ 'autoload' : {
    \   'commands' : ['VimShellPop', 'VimShell'],
    \   }
    \}
" compile and exec the code and pop result on Quickfix-window
NeoBundleLazy 'thinca/vim-quickrun', {
\ 'autoload': {
\   'commands': ['QuickRun'],
\   'mappings': ['nxo', '<Plug>(quickrun)', '<Plug>(quickrun-op)', ],
\ }}

" Git {{{
" runtimepathに追加されていない？ 要調査
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'gregsexton/gitv' , {
\ 'depends' : 'tpope/vim-fugitive',
\ 'autoload' : {
\   'commands' : ['Gitv', 'Gitv!'],
\   }
\}
NeoBundle 'rhysd/committia.vim'
NeoBundleLazy 'rhysd/github-complete.vim', {
\ 'autoload' : {
\   'filetypes' : ['markdown', 'gitcommit'],
\ }
\}
" }}}

"" Quickfixの内容を使ってエラー表示をハイライトしてくれる
"NeoBundleLazy 'jceb/vim-hier'
" imploved
NeoBundle 'cohama/vim-hier'
" quickfixの該当箇所をコマンドラインに出力
NeoBundle 'dannyob/quickfixstatus'
NeoBundleLazy 'airblade/vim-rooter', {
\ 'autoload': {
\   'mappings': ['<Plug>RooterChangeToRootDirectory'],
\   'commands': ['Rooter'],
\ },
\}
let g:rooter_manual_only = 1
let g:rooter_disable_map = 1
nmap <silent> <unique> <Space>rt <Plug>RooterChangeToRootDirectory

"Unite
" if has('nvim')
if 0
  NeoBundle 'Shougo/denite.nvim'

else
  NeoBundleLazy 'Shougo/unite.vim' , {
  \ 'autoload' : {
  \   'commands' : ['Unite', 'UniteWithBufferDir', 'QuickRun'],
  \ }
  \}

  " unite source {{{
  NeoBundle 'Shougo/neomru.vim'
  " call g:neobundle#config('neomru.vim', {
  " \ 'lazy' : 1,
  " \ 'autoload' : {
  " \   'unite_sources' : 'file_mru'},
  " \ })

  NeoBundleLazy 'lambdalisue/unite-grep-vcs', {
      \ 'autoload': {
      \    'unite_sources': ['grep/git', 'grep/hg'],
      \}}

  NeoBundle 'Shougo/unite-ssh'
  call g:neobundle#config('unite-ssh', {
        \ 'lazy' : 1,
        \ 'autoload' : {
        \   'unite_sources' : 'ssh'},
        \ })
  NeoBundle 'Shougo/unite-build'
  call g:neobundle#config('unite-build', {
        \ 'lazy' : 1,
        \ 'autoload' : {
        \   'unite_sources' : 'build'},
        \ })

  NeoBundle 'Shougo/unite-outline', '', 'default'
  call g:neobundle#config('unite-outline', {
    \ 'lazy' : 1,
    \ 'autoload' : {
    \   'unite_sources' : 'outline'},
    \ })

  NeoBundle 'ryotakato/unite-outline-objc'
  call g:neobundle#config('unite-outline', {
    \ 'lazy' : 1,
    \ 'autoload' : {
    \   'unite_sources' : 'outline'},
    \ })
  NeoBundle 'tsukkee/unite-tag', '', 'default'
  call g:neobundle#config('unite-tag', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'unite_sources' : 'tag'},
  \ })

  NeoBundle 'osyo-manga/unite-quickfix'
  call g:neobundle#config('unite-quickfix', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'unite_sources' : 'quickfix'},
  \ })

  NeoBundleLazy 'hachibeeDI/unite-pypi-classifiers', {
  \ 'autoload' : {
  \   'unite_sources' : 'pypiclassifiers'},
  \ }

  NeoBundle 'rhysd/unite-codic.vim'
  call g:neobundle#config('unite-codic.vim', {
  \ 'lazy' : 1,
  \ 'autoload' : {'unite_sources' : 'codic'},
  \ })

  NeoBundle 'kmnk/vim-unite-giti'
  call g:neobundle#config('vim-unite-giti', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'unite_sources' : 'giti'},
  \ })

  " }}}

endif


NeoBundleLazy 'majutsushi/tagbar', {
\ 'autoload' : {
\   'commands' : ['Tagbar', 'TagbarToggle'],
\ }
\}
nnoremap <Space>T :<C-u>Tagbar<CR>


" get and read referece on vim
NeoBundleLazy 'thinca/vim-ref', { 'autoload' : {
\ 'commands' : 'Ref'
\ }}

" ---------- utils for edit {{{
" vim-operator-user {{{
NeoBundle 'kana/vim-operator-user'
NeoBundleLazy 'kana/vim-operator-replace', {
\   'depends': ['kana/vim-operator-user'],
\   'autoload': {
\     'mappings' : ['<Plug>(operator-replace)'],
\ }}

NeoBundleLazy 'emonkak/vim-operator-comment', {
\ 'depends': ['kana/vim-operator-user'],
\ 'autoload': {
\     'mappings' : ['<Plug>(operator-uncomment)',
\                   '<Plug>(operator-comment', ], }}
NeoBundleLazy 'rhysd/vim-operator-surround', {
\   'depends': ['kana/vim-operator-user', 'osyo-manga/vim-textobj-multiblock', 'thinca/vim-textobj-between'],
\   'autoload': {
\     'mappings' : ['<Plug>(operator-surround-append)',
\                   '<Plug>(operator-surround-delete)',
\                   '<Plug>(operator-surround-replace)', ], }}

NeoBundleLazy 'hachibeeDI/vim-operator-autopep8', {
\   'autoload' : {
\     'filetypes' : ['python'],
\   },
\   'depends': ['kana/vim-operator-user', 'andviro/flake8-vim'],
\ }

" operator-user }}}

" textobj-user {{{
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'kana/vim-textobj-jabraces'

NeoBundleLazy 'osyo-manga/vim-textobj-multiblock', {
\ 'depends': ['kana/vim-textobj-user'],
\ 'autoload' : {
\     'mappings' : ['<Plug>(textobj-multiblock-a)', '<Plug>(textobj-multiblock-i)'],
\ }}
NeoBundleLazy 'thinca/vim-textobj-between', {
\ 'depends': ['kana/vim-textobj-user'],
\ 'autoload' : {
\   'mappings' : ['<Plug>(textobj-between-a)', '<Plug>(textobj-between-i)'],
\   }
\ }

NeoBundleLazy 'bps/vim-textobj-python', {
\ 'depends': ['kana/vim-textobj-user'],
\ 'autoload': {
\   'mappings': ['<Plug>(textobj-python-function', ],
\   }
\ }
" --- text-obj-python ---- {{{
  " in $HOME/.vim/after/ftplugin/python.vim
" }}}

" NeoBundle 'hachibeeDI/vim-textobj-continuous-line', {
" \ 'base': expand('~/Dropbox/development/viml/'),
" \ 'type': 'nosync',
" \ }

"textobj-user }}}

NeoBundleLazy 'cohama/lexima.vim', {
\   'autoload' : {'insert' : 1, },
\}
" NeoBundle 'kana/vim-smartinput'
NeoBundleLazy 'hachibeeDI/smartinput-patterns', {
\ 'type': 'nosync',
\ 'depends': 'cohama/lexima.vim',
\ 'autoload' : {'insert' : 1, },
\ }
NeoBundleLazy 'kana/vim-smartchr', {
\ 'autoload' : {
\   'function_prefix' : 'smartchr',
\ }}

NeoBundleLazy 'kana/vim-smartword', { 'autoload' : {
      \ 'mappings' : [
      \   '<Plug>(smartword-w)', '<Plug>(smartword-b)', '<Plug>(smartword-ge)']
      \ }}
NeoBundleLazy 'kana/vim-smarttill', { 'autoload' : {
      \ 'mappings' : [
      \   '<Plug>(smarttill-t)', '<Plug>(smarttill-T)']
      \ }}
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

" search words from two spells matched
NeoBundle 'goldfeld/vim-seek'

" undo history visualizer
NeoBundleLazy 'sjl/gundo.vim', {
\ 'autoload' : {
\   'commands' : ['GundoToggle'],
\ }
\}
" ----- Gundo.vim --- {{{
nnoremap U :<C-u>GundoToggle<CR>
" ---- }}}

NeoBundleLazy 'tpope/vim-classpath', {
\ 'autoload' : {
\   'filetypes' : ['scala', 'clojure', 'java', ],
\ }
\}

NeoBundle 'Yggdroot/indentLine'

NeoBundleLazy 'vim-scripts/IndentAnything', {
\ 'autoload' : {
\   'filetypes' : ['html', 'xhtml', 'htmldjango', 'play2-html'],
\ }
\}
"" add jasmine syntax
"NeoBundleLazy 'claco/jasmine.vim', {
"\ 'autoload' : {
"\   'filetypes' : ['coffee', 'javascript', 'typescript'],
"\ }}

" complete word in English. depends on `look` command.
NeoBundle 'ujihisa/neco-look'
NeoBundleLazy 'koron/codic-vim', {
\ 'autoload': {
\   'commands': ['Codic'],
\   'function_prefix': 'codic',
\   'mappings' : ['<Plug>(operator-codic)'],
\ }}
NeoBundleLazy 'hachibeeDI/vim-operator-codic', {
\ 'autoload': {
\   'mappings' : '<Plug>',
\ }}
map x <Plug>(operator-codic)

NeoBundleLazy 'mattn/excitetranslate-vim', {
      \ 'depends': 'mattn/webapi-vim',
      \ 'autoload' : { 'commands': ['ExciteTranslate']}
      \ }
xnoremap E :ExciteTranslate<CR>

NeoBundleLazy 'LeafCage/foldCC', {
\ 'autoload' : {
\   'functions' : ['FoldCCtext'],
\ }
\}
" via: http://d.hatena.ne.jp/leafcage/20111223/1324705686
set foldtext=FoldCCtext()
"set foldcolumn=5

" === Language surpport === {{{
" -- Python {{{
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
\ 'autoload' : {
\   'filetypes' : ['python'],
\ }}
NeoBundleLazy 'Crapworks/python_fn.vim', {
\ 'autoload' : {
\   'filetypes' : ['python'],
\ }}
NeoBundleLazy 'jmcantrell/vim-virtualenv', {
\ 'autoload' : {
\   'filetypes' : ['python'],
\   'commands': [
\     'VirtualEnvDeactivate',
\     'VirtualEnvList',
\     {'name': 'VirtualEnvActivate', 'complete': 'customlist,virtualenv#names'},
\   ],
\ },
\ 'disabled' : !has('python'),
\ }
" --- forked
NeoBundleLazy 'andviro/flake8-vim', {
\ 'autoload' : {
\   'filetypes' : ['python'],
\ }}

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

NeoBundleLazy 'hachibeeDI/rope-vim', {
\ 'autoload' : {
\   'filetypes' : ['python'],
\ },
\ 'disabled' : !has('python'),
\ 'base': expand('~/Dropbox/development/viml/'),
\ 'type': 'nosync',
\}

if s:is_neovim
  NeoBundleLazy 'zchee/deoplete-jedi', {
  \ 'autoload' : {
  \   'filetypes' : ['python'],
  \ },
  \ }
else
  NeoBundleLazy 'davidhalter/jedi-vim', {
  \ 'autoload' : {
  \   'filetypes' : ['python'],
  \ },
  \ 'disabled' : !has('python'),
  \ }
endif
  NeoBundleLazy 'Glench/Vim-Jinja2-Syntax', {
  \ 'autoload' : {
  \   'filetypes' : ['html', 'jinja'],
  \ }}

NeoBundleLazy 'hachibeeDI/python_hl_lvar.vim', {
\ 'autoload' : {
\     'filetypes' : ['python'],
\ },
\ }
" \ 'base': expand('~/Dropbox/development/viml/'),
" \ 'type': 'nosync',
" \ }

" }}}
" - - golang {{{
if executable('go')
  NeoBundleLazy 'fatih/vim-go', {
  \   'autoload': {'filetypes': ['go']},
  \ }
  au MyAutoCmd FileType go nmap <Leader>s <Plug>(go-implements)
  au MyAutoCmd FileType go nmap <Leader>i <Plug>(go-info)
  let g:go_auto_type_info = 1
  let g:go_fmt_command = 'goimports'
endif
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
" -- C++ {{{
" clang
" C++11's syntax
NeoBundleLazy 'vim-jp/cpp-vim', {
\ 'autoload' : {
\   'filetypes' : ['cpp'] }
\}
"https://github.com/beyondmarc/opengl.vim
" git submodule add git://github.com/beyondmarc/opengl.vim.git bundle/syntax_opengl
NeoBundleLazy 'Rip-Rip/clang_complete', {
\ 'autoload' : {
\   'filetypes' : ['c', 'cpp', 'objc', 'objcpp'] }
\}
" -- Objective-C ==
if g:is_mac
  NeoBundleLazy 'tokorom/clang_complete-getopts-ios', {
  \ 'autoload' : {
  \   'filetypes' : ['objc']},
  \}
  NeoBundleLazy 'tokorom/vim-textobj-objc', {
  \ 'autoload' : {
  \   'filetypes' : ['objc']},
  \}
  NeoBundleLazy 'tokorom/xcode-actions.vim', {
  \ 'autoload' : {
  \   'filetypes' : ['objc']},
  \}
  NeoBundleLazy 'b4winckler/vim-objc', {
  \ 'autoload' : {
  \   'filetypes' : ['objc']},
  \}
  NeoBundleLazy 'toyamarinyon/vim-swift', {
  \ 'autoload' : {
  \   'filetypes' : ['swift']},
  \}
endif
" }}}
"
" }}}
" -- JavaScript {{{
" TypeScript
NeoBundleLazy 'leafgarland/typescript-vim', {
\ 'autoload' : {
\   'filetypes' : ['typescript'] }
\}

" should exec `npm install -g`
" I dont wanna use 'build' sentence
" NeoBundleLazy 'clausreinke/typescript-tools', {
" \ 'autoload' : {
" \   'filetypes' : ['typescript'] }
" \}
NeoBundleLazy 'Quramy/tsuquyomi', {
\ 'autoload' : {
\   'filetypes' : ['typescript'] }
\}

" Yet Another syntax. not contains indent
NeoBundleLazy 'othree/yajs.vim', {
\ 'autoload': {
\   'filetypes' : ['javascript', 'jsx', 'javascript.jsx'],
\}}
" add proposal syntax e.g. async await
NeoBundleLazy 'othree/es.next.syntax.vim', {
\ 'autoload': {
\   'filetypes' : ['javascript', 'jsx', 'javascript.jsx'],
\}}
NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {
\ 'autoload' : {
\   'filetypes' : ['html', 'xhtml', 'jinja', 'coffee', 'javascript', 'jsx', 'javascript.jsx', 'typescript'],
\ }}
" javascript-libraries-syntax.vim = {{{
let g:used_javascript_libs = 'jquery,underscore,requirejs,react,flux'
"}}}



NeoBundleLazy 'isRuslan/vim-es6', {
\ 'autoload' : {
\   'filetypes' : ['javascript', 'javascript.jsx', 'typescript', 'html'],
\}}
" NeoBundleLazy 'jason0x43/vim-js-indent', {
" \ 'autoload' : {
" \   'filetypes' : ['javascript', 'typescript', 'html'],
" \}}
" let g:js_indent_typescript = 1

NeoBundleLazy 'elzr/vim-json', {'autoload': {'filetypes': ['json']}, }
let g:vim_json_syntax_conceal = 0

" just add jsx syntax so I need base syntax plugin that's yajs
NeoBundleLazy 'mxw/vim-jsx', {
\ 'autoload' : {
\   'filetypes' : ['javascript', 'jsx', 'javascript.jsx', ],
\ }}
let g:jsx_ext_required = 1
let g:jsx_pragma_required = 0


if has('python') && executable('npm')
  NeoBundleLazy 'marijnh/tern_for_vim', {
  \ 'build' : 'npm install',
  \ 'autoload' : {
  \   'functions': ['tern#Complete', 'tern#Enable'],
  \   'filetypes' : ['javascript', 'jsx', 'javascript.jsx']
  \ }}
endif

NeoBundleLazy 'digitaltoad/vim-jade', {
\ 'autoload': {
\    'filetypes': ['jade'],
\ }}
" coffee
NeoBundleLazy 'kchmck/vim-coffee-script', {
    \ 'autoload' : {
    \   'filetypes' : ['coffee'] }
    \}
" -- Scala {{{
NeoBundleLazy 'yuroyoro/vim-scala', {
    \ 'autoload' : {
    \   'filetypes' : ['scala'] }
    \}
" Play2のテンプレートとかのシンタックス
NeoBundleLazy 'gre/play2vim', {
\ 'autoload' : {
\   'filetypes' : ['scala'] }
\}
" }}}

" -- Ruby {{{
NeoBundleLazy 'Shougo/neocomplcache-rsense.vim', {
\ 'autoload' : {
\   'filetypes': ['ruby', 'eruby']},
\ }

NeoBundleLazy 'ruby-matchit', {
\ 'autoload' : {
\   'filetypes': ['ruby', 'eruby', 'haml']},
\ }
NeoBundleLazy 'skwp/vim-rspec', {
\ 'autoload': {
\    'filetypes': ['ruby', 'eruby', 'haml'] }}

NeoBundleLazy 'tpope/vim-rails', {
\  'autoload' : {
\    'filetypes' : ['ruby'] }}

NeoBundleLazy 'ujihisa/unite-rake', {
\  'autoload' : {
\    'filetypes' : ['ruby'] }
\ }

NeoBundleLazy 'basyura/unite-rails', {
\  'autoload' : {
\    'filetypes' : ['ruby'] }
\ }
"}}}

" -- Lisp {{{
NeoBundleLazy "elixir-lang/vim-elixir", {
\  'autoload' : {
\    'filetypes' : ['elixir'] }
\ }
" }}}

" -- Lisp {{{
if executable('lein')
  " via: http://blog.ieknir.com/blog/beginning-clojure-with-vim/
  NeoBundleLazy 'guns/vim-clojure-static', {
  \ 'autoload' : {
  \   'filetypes' : ['clojure'] }
  \}
  NeoBundleLazy 'tpope/vim-fireplace', {
  \ 'autoload' : {
  \   'filetypes' : ['clojure'] }
  \}
  NeoBundleLazy 'tpope/vim-classpath', {
  \ 'autoload' : {
  \   'filetypes' : ['clojure'] }
  \}

endif
"}}}
" -- Haskell {{{
if executable('ghc')
  NeoBundleLazy 'dag/vim2hs', {
      \ 'autoload' : {
      \   'filetypes' : ['haskell'] }
      \}
  NeoBundleLazy 'pbrisbin/html-template-syntax', {
      \ 'autoload' : {
      \   'filetypes' : ['haskell'] }
      \}
  " NOTE: require 'ghc-mod'. install from `cabal install ghc-mod`.
  NeoBundleLazy 'ujihisa/neco-ghc', {
      \ 'autoload' : {
      \   'filetypes' : ['haskell'] }
      \}
  NeoBundleLazy 'eagletmt/ghcmod-vim', {
      \ 'autoload' : {
      \   'filetypes' : ['haskell'] }
      \}

  "http://vim-users.jp/2011/12/hack241/
  " NOTE: require 'hoogle'
  NeoBundleLazy 'ujihisa/unite-haskellimport', {
      \ 'autoload' : {
      \   'filetypes' : ['haskell'] }
      \}
endif

" }}}
" -- VB.NET {{{
NeoBundleLazy 'hachibeeDI/vim-vbnet', {
\ 'autoload' : {
\   'filetypes' : ['vbnet'],
\   },
\ 'stay_same' : 1,
\}
" }}}

" -- markup {{{
NeoBundleLazy 'mattn/emmet-vim', {
\ 'autoload' : {
\   'filetypes' : ['html', 'xhtml', 'htmldjango', 'play2-html',  'eruby', 'css', 'sass', 'scss',  'stylus', 'jinja', 'jsx', 'javascript.jsx'],
\ }
\}

NeoBundleLazy 'othree/html5.vim', {
\ 'autoload' : {
\   'filetypes' : ['html', 'xhtml', 'htmldjango', 'play2-html',  'eruby', 'jinja'],
\ }
\}

NeoBundleLazy 'hail2u/vim-css3-syntax', {
\ 'autoload' : {
\   'filetypes' : ['css', 'scss', 'sass', 'stylus', ],
\ }
\}

" }}}

" --- style sheets {{{
" css_color is too heavy... ...
"" seems more useful then css_color.vim
"NeoBundleLazy 'skammer/vim-css-color', {
"    \ 'autoload' : {
"    \   'filetypes' : ['css', 'less', 'scss', 'sass'] }
"    \}

NeoBundleLazy 'cakebaker/scss-syntax.vim', {
\ 'autoload' : {
\   'filetypes' : ['scss', 'sass'] }
\ }

" もう少しscssとcompassへの理解を深めてから使う
"NeoBundleLazy 'AtsushiM/sass-compile.vim', {
"\ 'autoload' : {
"\   'filetypes' : ['scss', 'sass'] }
"\ }

NeoBundleLazy 'groenewege/vim-less', {
\ 'autoload' : {
\   'filetypes' : ['less'] }
\ }
NeoBundleLazy 'wavded/vim-stylus', {
\ 'autoload' : {
\   'filetypes' : ['stylus'] }
\ }
" }}}
"
" NeoBundleLazy 'chrisbra/csv.vim', {
" \ 'autoload' : {
" \   'filetypes' : ['csv', ] }
" \ }

" === }}}
NeoBundleLazy 'SQLUtilities', {
    \ 'depends' :
    \   ['vim-scripts/Align'],
    \ 'autoload' : {
    \   'filetypes' : ['sql', 'sqloracle', 'sqlserver'] }
    \}

NeoBundleLazy 'timcharper/textile.vim', {
\ 'autoload' : {
\   'filetypes' : ['textile'] }
\ }

NeoBundle 'godlygeek/tabular'

NeoBundle 'vim-scripts/Colour-Sampler-Pack'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'ujihisa/unite-colorscheme', {'gui': 1}
NeoBundle 'ujihisa/unite-font', {'gui': 1}


NeoBundle 'sudo.vim'
NeoBundle 'kana/vim-metarw'
" --- lightline -- {{{
NeoBundle 'itchyny/lightline.vim'
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

NeoBundle 't9md/vim-quickhl'

" カッコいい言語のカッコをレインボーにする
NeoBundleLazy 'kien/rainbow_parentheses.vim', {
\ 'autoload' : {
\   'commands': ['RainbowParenthesesToggle', 'RainbowParenthesesLoadRound', 'RainbowParenthesesLoadBraces', 'RainbowParenthesesActivate', ],
\ }}

NeoBundleLazy 'mattn/gist-vim', {
    \ 'autoload' : {
    \   'commands' : [ 'Gist' ]}
    \}
NeoBundle 'mattn/webapi-vim'
NeoBundleLazy 'tyru/open-browser.vim', {
    \ 'autoload' : {
    \     'functions' : 'OpenBrowser',
    \     'commands'  : ['OpenBrowser', 'OpenBrowserSearch', 'OpenBrowserSmartSearch'],
    \     'mappings'  : ['<Plug>(openbrowser-smart-search)', '<Plug>(openbrowser-open)'],
    \ },
    \}

NeoBundleLazy 'osyo-manga/vim-watchdogs', {
    \ 'depends' :
    \       ['osyo-manga/shabadou.vim'],
    \ 'autoload' : {
    \   'commands' : ['WatchdogsRun', 'WatchdogsRunSilent', 'QuickRun'],
    \   'mappings' : ['nxo', '<Plug>(quickrun)'],
    \}}
NeoBundle 'osyo-manga/shabadou.vim'

" utils {{{
NeoBundleLazy 'basyura/TweetVim', {
    \ 'depends' :
    \       [ 'basyura/bitly.vim'
    \       , 'basyura/twibill.vim'
    \       , 'tyru/open-browser.vim'
    \       ],
    \ 'autoload' : {
    \   'commands' : ['TweetVimSay', 'TweetVimHomeTimeline', 'TweetVimMentions', 'TweetVimSearch'],
    \ }
    \}
NeoBundleLazy 'glidenote/memolist.vim', {
\ 'autoload' : {
\ 'commands' : ['MemoNew', 'MemoList', 'MemoGrep'],
\ }
\}
" }}}

" developping
NeoBundleLazy 'hachibeeDI/unite-pythonimport', {
\ 'autoload' : {
\   'filetypes' : ['python'],
\   },
\ 'stay_same' : 1,
\ }

NeoBundleLazy 'LeafCage/yankround.vim', {
\   'autoload': {
\     'mappings' : ['<Plug>(yankround-p)',
\                   '<Plug>(yankround-P)',
\                   '<Plug>(yankround-gp)',
\                   '<Plug>(yankround-gP)',
\                   '<Plug>(yankround-prev)',
\                   '<Plug>(yankround-next)', ],
\   'unite_sources' : 'yankround',
\}}

NeoBundleLazy 'LeafCage/vimhelpgenerator', {
\ 'autoload' : {
\   'filetypes' : ['vim'],
\   },}
let g:vimhelpgenerator_version = ''
let g:vimhelpgenerator_author = 'Author : OGURA_Daiki <8hachibee125+vim @ gmail.com>'
let g:vimhelpgenerator_contents = {
\ 'contents': 1, 'introduction': 1, 'usage': 1, 'interface': 1,
\ 'variables': 1, 'commands': 1, 'key-mappings': 1, 'functions': 1,
\ 'setting': 0, 'todo': 1, 'changelog': 0
\ }

NeoBundleLazy 'ompugao/uncrustify-vim'

source ~/.vim/plugin.rc.vim

call g:neobundle#end()
" Installation check.
NeoBundleCheck


if !has('vim_starting')
  " Call on_source hook when reloading .vimrc.
  call g:neobundle#call_hook('on_source')
endif
" Neobundle }}}
