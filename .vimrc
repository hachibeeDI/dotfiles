" --------------------------------------------------------
"    _                _     _ _               _
"   | |__   __ _  ___| |__ (_) |__   ___  ___( )___
"   | '_ \ / _` |/ __| '_ \| | '_ \ / _ \/ _ \// __|
"   | | | | (_| | (__| | | | | |_) |  __/  __/ \__ \
"   |_| |_|\__, _|\___|_| |_|_|_.__/ \___|\___| |___/
" vimrc
" --------------------------------------------------------

" variables ----

let s:MY_VIMRUNTIME = expand('~/.vim')
let s:BUNDLEPATH = expand('~/.neobundle')
let s:vimrc = '~/.vimrc'

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let g:is_mac = has('mac') || has('macunix') || has('gui_macvim')

"set autogroup
augroup MyAutoCmd
  autocmd!
augroup END

" Neobundle {{{
if has('vim_starting')
  " via: https://twitter.com/ShougoMatsu/status/541718069010128896
  " set nocompatible
  set runtimepath& runtimepath+=~/.vim/neobundle.vim/

  if executable('gom')
    set rtp+=$HOME/.go/src/github.com/mattn/gom/misc/vim
    autocmd MyAutoCmd Filetype go SetGomEnv
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

NeoBundleLazy 'Shougo/neocomplete.vim', {
\   'autoload' : {
\     'insert' : 1,
\ },
\   'depends' : 'Shougo/context_filetype.vim',
\   'disabled' : !(has('lua') || has('luajit')),
\   'vim_version' : '7.3.885'
\ }
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

NeoBundle 'Shougo/vimfiler', '', 'default'
call g:neobundle#config('vimfiler', {
      \ 'lazy' : 1,
      \ 'depends' : 'Shougo/unite.vim',
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

" runtimepathに追加されていない？ 要調査
NeoBundle 'tpope/vim-fugitive' ", {
"\ 'autoload': {
"\   'commands': ['Git', 'Gstatus', 'Gcommit', 'Gedit', 'Gwrite', 'Ggrep', 'Glog', 'Gdiff'],
"\ }
"\}
NeoBundleLazy 'gregsexton/gitv' , {
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

"Unite
NeoBundleLazy 'Shougo/unite.vim' , {
\ 'autoload' : {
\   'commands' : ['Unite', 'UniteWithBufferDir', 'QuickRun'],
\ }
\}
" unite source {{{
NeoBundle 'Shougo/neomru.vim'
call g:neobundle#config('neomru.vim', {
\ 'lazy' : 1,
\ 'autoload' : {
\   'unite_sources' : 'file_mru'},
\ })

NeoBundle 'sgur/unite-git_grep'
call g:neobundle#config('unite-git_grep', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'unite_sources' : 'vcs_grep'},
  \ })

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

NeoBundleLazy 'majutsushi/tagbar', {
\ 'autoload' : {
\   'commands' : ['TagbarToggle'],
\ }
\}

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
" }}}


" get and read referece on vim
NeoBundleLazy 'thinca/vim-ref', { 'autoload' : {
\ 'commands' : 'Ref'
\ }}
NeoBundleLazy 'thinca/vim-scouter', '', 'same', { 'autoload' : {
\ 'commands' : 'Scouter'
\ }}

NeoBundle 'vim-jp/vital.vim'

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
\   'autoload' : {
\     'insert' : 1,
\ },
\}
" NeoBundle 'kana/vim-smartinput'
NeoBundle 'hachibeeDI/smartinput-patterns', {
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
" }}}

" search words from two spells matched
NeoBundle 'goldfeld/vim-seek'

" undo history visualizer
NeoBundleLazy 'sjl/gundo.vim', {
\ 'autoload' : {
\   'commands' : ['GundoToggle'],
\ }
\}

NeoBundleLazy 'tpope/vim-classpath', {
\ 'autoload' : {
\   'filetypes' : ['scala', 'clojure', 'java', ],
\ }
\}

NeoBundle 'Yggdroot/indentLine'

NeoBundleLazy 'git://github.com/vim-scripts/IndentAnything.git', {
\ 'autoload' : {
\   'filetypes' : ['html', 'xhtml', 'htmldjango', 'play2-html', 'javascript'],
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
NeoBundle 'rhysd/unite-codic.vim'
call g:neobundle#config('unite-codic.vim', {
\ 'lazy' : 1,
\ 'autoload' : {'unite_sources' : 'codic'},
\ })
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

NeoBundleLazy 'davidhalter/jedi-vim', {
\ 'autoload' : {
\   'filetypes' : ['python'],
\ },
\ 'disabled' : !has('python'),
\ }
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
  NeoBundleLazy 'tokorom/neocomplete-ios-dictionary', {
  \ 'depends' : 'Shougo/neocomplete.vim',
  \ 'on_source': 'neocomplete.vim',
  \ }
  NeoBundleLazy 'b4winckler/vim-objc', {
  \ 'autoload' : {
  \   'filetypes' : ['objc']},
  \}
  NeoBundle 'toyamarinyon/vim-swift'
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


" NeoBundleLazy 'pangloss/vim-javascript', {
" \ 'autoload' : {
" \   'filetypes' : ['javascript'],
" \}}
" let g:javascript_enable_domhtmlcss = 1

NeoBundleLazy 'othree/yajs.vim', {
\ 'autoload': {
\   'filetypes' : ['javascript', 'jsx'],
\}}

NeoBundleLazy 'jason0x43/vim-js-indent', {
\ 'autoload' : {
\   'filetypes' : ['javascript', 'typescript', 'html'],
\}}
let g:js_indent_typescript = 1

NeoBundleLazy 'elzr/vim-json', {'autoload': {'filetypes': ['json']}, }
let g:vim_json_syntax_conceal = 0

NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {
\ 'autoload' : {
\   'filetypes' : ['html', 'xhtml', 'jinja', 'coffee', 'javascript', 'typescript'],
\ }}
" javascript-libraries-syntax.vim = {{{
let g:used_javascript_libs = 'jquery,underscore,requirejs,react,flux'
"}}}

NeoBundleLazy 'mxw/vim-jsx', {
\ 'autoload' : {
\   'filetypes' : ['jsx', ],
\ }}
let g:jsx_pragma_required = 1


if has('python') && executable('npm')
  NeoBundleLazy 'marijnh/tern_for_vim', {
  \ 'build' : 'npm install',
  \ 'autoload' : {
  \   'functions': ['tern#Complete', 'tern#Enable'],
  \   'filetypes' : ['javascript', 'jsx']
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
" == PHP {{{
if executable('php-cs-fixer')
  NeoBundleLazy 'stephpy/vim-php-cs-fixer', {
  \ 'autoload' : {
  \   'filetypes' : ['php'],
  \   },
  \}
  NeoBundleLazy 'shawncplus/phpcomplete.vim', {
  \ 'autoload' : {
  \   'filetypes' : ['php'],
  \   },
  \}
  autocmd MyAutoCmd Filetype php setl makeprg=php\ -l\ %
  autocmd MyAutoCmd Filetype php setl errorformat=%m\ in\ %f\ on\ line\ %l
  autocmd MyAutoCmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif
endif
"}}}
" -- markup {{{
NeoBundleLazy 'mattn/emmet-vim', {
\ 'autoload' : {
\   'filetypes' : ['html', 'xhtml', 'htmldjango', 'play2-html',  'eruby', 'css', 'sass', 'scss',  'stylus', 'jinja'],
\ }
\}

NeoBundleLazy 'othree/html5.vim', {
\ 'autoload' : {
\   'filetypes' : ['html', 'xhtml', 'htmldjango', 'play2-html',  'eruby', 'jinja'],
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
NeoBundleLazy 'duganchen/vim-soy', {
\ 'autoload' : {
\   'filetypes' : ['soy'] }
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
NeoBundle 'itchyny/lightline.vim'
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
" Neobundle }}}

" --- default bundled plugins ---
" enable prebundled plugin
source $VIMRUNTIME/macros/matchit.vim

"Bram氏の提供する設定例をインクルードしない。Kaoriya版用
let g:no_vimrc_example = 1
if has('kaoriya')
    "-- Kaoriya版にデフォルトで入っているプラグイン群の無効化 --
    "$VIM/plugins/kaoriya/autodate.vim
    let plugin_autodate_disable  = 1
    " 便利コマンド集
    "let plugin_cmdex_disable     = 1
    " GENE辞書をひける
    let plugin_dicwin_disable    = 1
    "$VIM/plugins/kaoriya/hz_ja.vim
    let plugin_hz_ja_disable     = 1
    "$VIM/plugins/kaoriya/scrnmode.vim
    let plugin_scrnmode_disable  = 1
    "$VIM/plugins/kaoriya/verifyenc.vim
    "let plugin_verifyenc_disable = 1
endif

" Disable GetLatestVimPlugin.vim
let g:loaded_getscriptPlugin = 1
" Disable netrw
let g:loaded_netrwPlugin = 1
" noteを表示させない
let g:netrw_localcopycmd=''

" python.vim (default bundled syntax plugin)
let g:python_highlight_all = 1
" .h で @interfaceのあるファイルをobjcppではなくobjcとして検出してくれる
" ($VIMRUNTIME/filetype.vim)
let g:c_syntax_for_h = 1

filetype plugin indent on
syntax enable

if !has('vim_starting')
  " Call on_source hook when reloading .vimrc.
  call g:neobundle#call_hook('on_source')
endif

" vital.vim --- {{{
let g:Vit = vital#of('vital')
"call extend(s:, g:Vit, 'keep') " スクリプトローカルに展開したくなったら
call g:Vit.load('Data.List').load('Data.String').load('Math')

"}}}
"}}}

" encoding ------ {{{
" settings for infer encoding and formats
set encoding=utf-8 "WindowsだとCygwin以外で問題でるかも? でも使わないので問題なし
scriptencoding utf-8
set fileencodings=ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,utf-16,utf-16le
set fileformats=unix,dos

if s:is_windows
    set termencoding=cp932
else
    "set termencoding=utf-8
endif

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

if exists('+macmeta')
  set macmeta
endif
" }}}

"
" common settings
"
set regexpengine=1

" ======== edit ========= {{{
" indent ---------
set smarttab
set expandtab
set shiftround
" use 4 as default tab width, and will customize in s:MY_VIMRUNTIME/after/ftplugin/*.vim
set shiftwidth=4 softtabstop=4
" -----------

" enable free point cursor when use block select mode
set virtualedit=block
" Display another buffer when current buffer isn't saved.
set hidden
" Auto reload if file is changed.
set autoread
" Ignore case on insert completion.
set infercase
"閉じカッコが入力されたとき、対応するカッコを表示する
set showmatch
" 括弧を入力した時にカーソルが移動しないように設定
set matchtime=0
" 常にカーソルが真ん中
set scrolloff=999
" set default register is unnamed register. (same as OS's clipboard)
set clipboard=unnamed
" mouse surport
set mouse=a
" 新しく開く代わりにすでに開いてあるバッファを開く
set switchbuf=useopen

" enable command-line completion operates in an enhanced mode.
set wildmenu
" show completion menu in command mode
set wildmode=list:full
" -- wildignore -- A list of file patterns is ignored when expanding {{{
set wildignore=*.o,*.obj,*.pyc,*.so,*.dll
" Excluding version control directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Linux/MacOSX
"set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*  " Windows ('noshellslash')
"}}}
set completeopt=menuone,preview
" Don't complete from other buffer.
set complete=.,w,b,t,i  " via: help cpt
" Set popup menu max height.
set pumheight=20
" <C-a> <C-x> で英字も増減させる
set nrformats=alpha,octal,hex
" a list of deletable
set backspace=eol,indent,start

" Disable automatically insert comment.
autocmd MyAutoCmd FileType * setl formatoptions-=ro | setl formatoptions+=mM
"autocmd MyAutoCmd InsertEnter,CmdwinEnter * set noimdisable
"autocmd MyAutoCmd InsertLeave,CmdwinLeave * set imdisable
" ======== edit }}}

" ========== View ======================== {{{
" disable bell
set visualbell t_vb=
set novisualbell

" have to set, before setting colorscheme-command
set t_Co=256

"set directory=~/.vimcache/vimswap
" いい加減うっとおしいのでswapはいらない
set noswapfile
if has('unix')
    set nofsync
    set swapsync=
endif
set backupdir=~/.vimcache/bak
set viminfo& viminfo+=n~/.vimcache/viminfo
if v:version >= 703
    set undodir=~/.vimcache/undo
    set undofile

  " for snippet_complete marker
  " conceal in insert (i), normal (n) and visual (v) modes
  set conceallevel=2 concealcursor=inv
  set colorcolumn=79
  set relativenumber
endif
set number
" set history=100000

set foldmethod=marker
set foldenable
"set foldcolumn=3
set foldlevel=2

set secure

set display=uhex "表示出来ない文字は16進数で表示させる

set list
set listchars=tab:>-,trail:~

set fillchars=vert:\|,fold:-,stl:-

" enable modeline
set modeline
" number of readble lines
set modelines=5

set pastetoggle=<F10>

set ruler

set splitbelow
set splitright
set previewheight=30
" ウィンドウのリサイズを抑える
set noequalalways
" disable auto comment when start a new line
set formatoptions& formatoptions-=ro

"--------
" display settings
"---------

" enable cursorline only focused buffer.
setlocal cursorline
autocmd MyAutoCmd WinEnter * setlocal cursorline
autocmd MyAutoCmd WinLeave * setlocal nocursorline

" 各コマンド後の結果をquickfixへ出力させる
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
autocmd MyAutoCmd QuickfixCmdPost make call <SID>auto_ccl()
" qf系 -> $HOME/.vim/after/ftplugin/qf.vim
" make時に、shellに戻ったりとか余計な表示を出さない
nnoremap <silent> <leader>m :<C-u>silent make<CR>

function! s:auto_ccl()
  if &filetype !=# 'qf'
    return
  endif

  " リストが空ならそのまま閉じる
  if getqflist() == []
    :QuickfixStatusDisable
    :cclose
  else
    :QuickfixStatusEnable
  endif
  :HierUpdate
endfunction

" Auto-close if quickfix or quickrun window is only in buffer
autocmd MyAutoCmd WinEnter *
\   if (winnr('$') ==# 1) &&
\      (getbufvar(winbufnr(0), '&filetype')) =~? 'qf\|quickrun'
\         | quit | endif


set background=dark
"colorscheme solarized
let g:solarized_termcolors=256
let g:solarized_termtrans = 1
let g:solarized_italic = 0

" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag

" disable auto textwraping
set textwidth=0
set wrap

set ambiwidth=double
"コマンド実行中は再描画しない
set lazyredraw
"高速ターミナル接続を行う
set ttyfast
" 読み込んでいるファイルが変更された時自動で読み直す
set autoread
" No equal window size.
set noequalalways

set showmode
set showcmd
" Height of command line.
set cmdheight=2

set title
" Title length.
set titlelen=95
set titlestring=Vim:\ %f\ %h%r%m


" ---------- Cursor -------- {{{
" via: http://blog.remora.cx/2012/10/spotlight-cursor-line.html
"let &t_SI = "\e]50;CursorShape = 1\x7"
"let &t_EI = "\e]50;CursorShape = 0\x7"
"autocmd MyAutoCmd ColorScheme *
"            \ highlight Cursor
"            \ guibg=skyblue gui=NONE ctermbg=117 cterm=NONE
" }}}


"" StatusLine ------------------- {{{
" 2 -> always show statusline, 1 -> only twe windows is here, 0 -> None
set laststatus=2
""set statusline=
"let &statusline = ''
"let &statusline .= ' %F%m%r%h%w %y'
"let &statusline .= "%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}"
"let &statusline .= '%= [height-%l/%L : width-%c]  '
"
"highlight StatusLine
"            \ guifg=gray guibg=lightgoldenrod2 gui=NONE ctermbg=250 ctermfg=235 cterm=NONE
"
"" モードに応じて色を変える(現状Insert modeのみ)
"autocmd MyAutoCmd InsertEnter *
"            \ highlight StatusLine
"            \ guifg=black guibg=skyblue gui=NONE ctermbg=117 cterm=NONE
"autocmd MyAutoCmd InsertLeave *
"            \ highlight StatusLine
"            \ guifg=black guibg=lightgoldenrod2 gui=NONE ctermbg=250 ctermfg=235 cterm=NONE
" ------ status line ----}}}

" tabline {{{
" via:[manbou] http://d.hatena.ne.jp/thinca/20111204/1322932585
set showtabline=2
autocmd MyAutoCmd ColorScheme *
            \ highlight TabLine
            \ guifg=gray guibg=grey16 gui=NONE ctermfg=250 ctermbg=235 cterm=NONE
autocmd MyAutoCmd ColorScheme *
            \ highlight TabLineSel
            \ guifg=lightgoldenrod2 gui=bold ctermfg=186 cterm=bold
autocmd MyAutoCmd ColorScheme *
            \ highlight TabLineFill
            \ guifg=skyblue gui=NONE ctermfg=117 cterm=NONE
doautocmd ColorScheme _

" n 番目のタブのラベルを返す
function! s:tabpage_label(n)
  " t:titleという変数があればそれを使う
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif

  "タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)
  " カレントかどうかをハイライトで区別する
  let hightlight_start = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
  let is_modified = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '[+]' : ''
  let spacer = (is_modified) ==# '' ? '' : ' '  " 隙間
" カレントバッファ
  let selected_buffer = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr: number of tabpage, which is current
"   origin
  let fname = pathshorten(bufname(selected_buffer))
  let label = is_modified . spacer . fname

  if &filetype ==# 'unite'
    return hightlight_start . a:n . ':[unite] ' . unite#get_status_string() . '%T%#TabLineFill#'
  else
    return hightlight_start . a:n . ':< %' . a:n . 'T' . label . '%T%#TabLineFill#'
  endif
endfunction

function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' | '  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  " 好きな情報を入れる
  let info = ''
  let info .= fnamemodify(getcwd(), ':~') . ' '

  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfunction

" lightlineではなくて、自作のを使う
set tabline=%!MakeTabLine()
" Comletion menu ----- {{{
"autocmd MyAutoCmd ColorScheme *
"      \ highlight Pmenu
"      \ ctermbg=8 guibg=#606060
"autocmd MyAutoCmd ColorScheme *
"      \ highlight PmenuSel
"      \ ctermbg=1 guifg=#dddd00 guibg=#1f82cd
"autocmd MyAutoCmd ColorScheme *
"      \ highlight PmenuSbar
"      \ ctermbg=0 guibg=#d6d6d6
"}}}
" }}}

" ignore white space, show match lines,
set diffopt=iwhite,filler
" ==== View }}}

" ---- search behavior ---- {{{
set incsearch
set ignorecase
set smartcase
set wrapscan
set hlsearch
" ------------ }}}

" ======== Key Mapping ======== {{{

" disable unuseful keys
"<NPA> means to unset command on keymap
nnoremap q: <NOP>
nnoremap Q <NOP>
" same as :wq
nnoremap ZZ <NOP>
" same as :q!
nnoremap ZQ <Nop>

" -- mapping to show status
" via: http://vim-users.jp/2010/05/hack-144/
nnoremap <SID>[Show] <Nop>
nmap <Space>s <SID>[Show]
nnoremap <SID>[Show]m  :<C-u>Capture marks<CR>
nnoremap <SID>[Show]k  :<C-u>Capture map<CR>
nnoremap <SID>[Show]r  :<C-u>Capture registers<CR>
nnoremap <SID>[Show]e  :<C-u>edit $MYVIMRC<CR>
nnoremap <SID>[Show]l  :<C-u>source $MYVIMRC<CR>
nnoremap <SID>[Show]q  :<C-u>tab help<Space>
nnoremap <SID>[Show]hc  :<C-u>HierClear<CR>
nnoremap <SID>[Show]hs  :<C-u>HierStart<CR>
nnoremap <SID>[Show]hp  :<C-u>HierStop<CR>
nnoremap <SID>[Show]hu  :<C-u>HierUpdate<CR>

" vim Hack: http://vim-users.jp/2010/07/hack159/ {{{
nnoremap <SID>(split-to-j) :<C-u>execute 'belowright' (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <SID>(split-to-k) :<C-u>execute 'aboveleft'  (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <SID>(split-to-h) :<C-u>execute 'topleft'    (v:count == 0 ? '' : v:count) 'vsplit'<CR>
nnoremap <SID>(split-to-l) :<C-u>execute 'botright'   (v:count == 0 ? '' : v:count) 'vsplit'<CR>

nmap spj <SID>(split-to-j)
nmap spk <SID>(split-to-k)
nmap sph <SID>(split-to-h)
nmap spl <SID>(split-to-l)
" }}}

nnoremap <Esc><Esc> :<C-u>nohlsearch <Bar> cclose<CR><Esc>
"
set spelllang=en_us
if v:version >= 704
  set spelllang+=cjk
endif
"set spell
" toggle set spell
nnoremap <SID>[Show]s  :<C-u>setl spell!<CR>

if v:version >= 703
  nnoremap <silent> <SID>[Show]n :<C-u>ToggleNumber<CR>

  command! -nargs=0 ToggleNumber call ToggleNumberOption()

  function! ToggleNumberOption()
    if &number
      set relativenumber
    else
      set number
    endif
  endfunction
else
  nnoremap <silent> <SID>[Show]n :<C-u>set number!<CR>
endif


nnoremap <SID>[EditSupport] <Nop>
nmap , <SID>[EditSupport]

" substitute word is under cursor
nnoremap <expr> <SID>[EditSupport]s* ':%substitute/\<' . expand('<cword>') . '\>/'
nnoremap <expr> <SID>[EditSupport]e* ':' . line('.') . ',$s/\<' . expand('<cword>') . '\>/'

" ---- nomal mode ----{{{
":はコマンドモードへの移行、;はfind時に次の該当単語へジャンプする
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <Backspace> :%s/

nnoremap Y y$

" x,y,cで削除した文字はblack holeに行ってもらう.
" NOTE: xはいらないので別のkeymapで使う
" nnoremap x "_x
nnoremap s "_s
nnoremap c "_c
" vnoremap x "_x
vnoremap s "_s
vnoremap c "_c
onoremap c "_c

" adjust buffer size
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
nnoremap <Left> <C-w>>
nnoremap <Right> <C-w><


" Ctrl + C は、`insert modeの強制終了`なので微妙に挙動が変わる。直感に反するので統一
inoremap <C-c> <Esc>

" 行頭と空白抜きの先頭をトグルする
nnoremap <expr> 0
\         col('.') ==# 1 ? '^' : '0'
"nnoremap _ 0
onoremap 0 ^
onoremap _ 0

" カーソルを移動せずに改行 http://qiita.com/kentaro/items/42159874a0637d57ae1a
nnoremap go :<C-u>call append('.', '')<CR>
nnoremap gO :normal! O<ESC>j

" Insert Space in normal-mode
nnoremap <Space><Space> i<Space><Esc><Right>
"}}}

" ---- insert mode ---- {{{
"emacs like key-bind in insert mode
inoremap <C-a> <Home>
" inoremap <C-e> <End> neocomplete
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-h> <Backspace>
cnoremap <C-d> <Del>
cnoremap <C-k> <Del><Del><Del><Del><Del><Del><Del><Del><Del><Del><Del><Del><Del><Del><Del>

" ----------- operation
" http://vim-jp.org/vim-users-jp/2011/04/21/Hack-214.html
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(

onoremap ] t]
onoremap [ t[
vnoremap ] t]
vnoremap [ t[

onoremap _ t_
vnoremap _ t_
onoremap , t,
vnoremap , t,

if has('path_extra')
  set tags& tags+=.tags,tags

  autocmd MyAutoCmd FileType coffee
      \ set tags+=$HOME/coffee.tags
  autocmd MyAutoCmd FileType python
      \ set tags+=$HOME/python.tags
endif

"command mode
"inoremap <Backspace> <C-o>:
"}}}

" =================== 既存のキーマップを割と大幅に変えるもの {{{
" Like builtin getchar() but returns string always.
" and do inputsave()/inputrestore() before/after getchar().
function! s:getchar_safe(...)
  let c = s:input_helper('getchar', a:000)
  return type(c) == type('') ? c : nr2char(c)
endfunction

" Like builtin getchar() but
" do inputsave()/inputrestore() before/after input().
function! s:input_safe(...)
    return s:input_helper('input', a:000)
endfunction

" Do inputsave()/inputrestore() before/after calling a:funcname.
function! s:input_helper(funcname, args)
    let success = 0
    if inputsave() !=# success
        throw 'inputsave() failed'
    endif
    try
        return call(a:funcname, a:args)
    finally
        if inputrestore() !=# success
            throw 'inputrestore() failed'
        endif
    endtry
endfunction

nnoremap <expr><silent> f '/\V'.<SID>getchar_safe()."\<CR>:nohlsearch\<CR>"
nnoremap <expr><silent> F '?\V'.<SID>getchar_safe()."\<CR>:nohlsearch\<CR>"
nnoremap <expr><silent> t '/.\ze\V'.<SID>getchar_safe()."\<CR>:nohlsearch\<CR>"
nnoremap <expr><silent> T '?\V'.<SID>getchar_safe().'\v\zs.'."\<CR>:nohlsearch\<CR>"

nnoremap <C-j> *
nnoremap <C-k> #

" NOTE: <expr>は副作用(カーソルの移動とか)を許可しないので使えない
" preview error line in quickfix
nnoremap <M-p> :<C-u>call <SID>loop_qfpreview()<CR>
function! s:loop_qfpreview()
  try
    cprevious
  catch /E553/
    clast
  endtry
endfunction
" next error line in quickfix
nnoremap <M-n> :<C-u>call <SID>loop_qfnext()<CR>
function! s:loop_qfnext()
  try
    cnext
  catch /E553/
    cfirst
  endtry
endfunction

command!
\  -nargs=1
\  VimGrepCurrent
\  vimgrep <args> % | cw

nnoremap <expr>* ':<C-u>VimGrepCurrent ' . expand('<cword>') . '<CR>'

"}}}
" KeyMapping }}}

" ---------
"  Scripts
"  ======================={{{

" move current directory on the above of file is editing.
" via: <http://vim-users.jp/2009/09/hack69/> {{{
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory ==# ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang ==# ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>
" }}}

command! DeleteTrail call s:DeleteTrailingSpaces()
function! s:DeleteTrailingSpaces()
    let l:l = line('.')
    let l:c = col('.')
    execute ':%s/\s\+$//g'
    nohl
    call cursor(l, c)
    echo 'delete trail'
endfunction


" chmod a+xするコマンド
if executable('chmod')
    command! AddPermissionX call s:add_permission_x()

    function! s:add_permission_x()
        let file = expand('%:p')
        if getline(1) =~# '^#!' && !executable(file)
            silent! call vimproc#system('chmod a+x ' . shellescape(file))
        endif
    endfunction
endif


" http://vim-users.jp/2011/02/hack203/
command!
\   -nargs=* -complete=mapping
\   AllMaps
\   map <args> | map! <args> | lmap <args>

" Capture "{{{
" TODO: Unite output: で良いかもしれないのでそのうち消すかも
command!
\   -nargs=+ -complete=command
\   Capture
\   call s:cmd_capture(<q-args>)

function! s:cmd_capture(q_args)
    redir => output
    silent execute a:q_args
    redir END
    let output = substitute(output, '^\n\+', '', '')

    belowright new

    silent file `=printf('[Capture: %s]', a:q_args)`
    setlocal buftype=nofile bufhidden=unload noswapfile nobuflisted
    call setline(1, split(output, '\n'))
endfunction
"}}}

" via: http://vim-users.jp/2010/11/hack181/
" Open junk file. ---------------- {{{
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
  let l:junk_dir = $HOME . '/.vim_junk'. strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
  if l:filename !=# ''
    execute 'edit ' . l:filename
  endif
endfunction

nnoremap <SID>[Show]j :<C-u>JunkFile
" }}}

" GetScriptID {{{
" via: http://mattn.kaoriya.net/software/vim/20090826003359.htm
function! GetScriptID(_fname)
  let fname = tolower(a:_fname)
  let snlist = ''
  redir => snlist
    silent! scriptnames
  redir END
  let sid_name = {}
  let mx = '^\s*\(\d\+\):\s*\(.*\)$'
  for line in split(snlist, "\n")
    let sid_name[tolower(substitute(line, mx, '\2', ''))] = substitute(line, mx, '\1', '')
  endfor
  let ret = sid_name[fname]
  return ret
endfunction
"}}}

if g:is_mac
  " kobito {{{
  function! s:open_kobito(...)
      if a:0 ==# 0
          call system('open -a Kobito '.expand('%:p'))
      else
          call system('open -a Kobito '.join(a:000, ' '))
      endif
  endfunction

  " 引数のファイル(複数指定可)を Kobitoで開く
  " （引数無しのときはカレントバッファを開く
  command! -nargs=* Kobito call s:open_kobito(<f-args>)
  " Kobito を閉じる
  command! -nargs=0 KobitoClose call system("osascript -e 'tell application \"Kobito\" to quit'")
  " Kobito にフォーカスを移す
  command! -nargs=0 KobitoFocus call system("osascript -e 'tell application \"Kobito\" to activate'")
  "  }}}

  " dash {{{
  function! s:dash(...)
    let current_ft = &filetype
    if &filetype ==# 'python'
      let current_ft = current_ft.'2'
    endif
    let current_ft = current_ft.':'
    let word = len(a:000) ==# 0 ? input('Dash search: ', current_ft.expand('<cword>')) : current_ft.join(a:000, ' ')
    call system(printf("open dash://'%s'", word))
  endfunction

  command! -nargs=* Dash call <SID>dash(<f-args>)
  nnoremap <silent> _da :<C-u>call <SID>dash(expand('<cword>'))<CR>
  "}}}
endif

function! ConvertFileEncode(encoding, ...)
  exec('setl fileencoding='.a:encoding)
  exec('setl fileformat='.get(a:, 2, 'unix'))
endfunction
" 指定したエンコードでファイルを開き直すためのエイリアス
command! Utf8      call ConvertFileEncode('utf-8')
command! Cp932     call ConvertFileEncode('cp932')
command! Sjis      Cp932
command! Utf16b    call ConvertFileEncode('utf-16')
command! Utf16l    call ConvertFileEncode('utf-16le')
command! Iso2022jp call ConvertFileEncode('iso-2022-jp')
command! Jis       Iso2022jp
command! Eucjp     call ConvertFileEncode('euc-jp')

" command! Utf8 edit ++enc=utf-8
" command! Cp932 edit ++enc=cp932
" command! Sjis Cp932
" command! Utf16b edit ++enc=utf-16
" command! Utf16l edit ++enc=utf-16le
" command! Iso2022jp edit ++enc=iso-2022-jp
" command! Jis Iso2022jp
" command! Eucjp edit ++enc=euc-jp
"
" ============= }}}


"-------------
" plugin settings
"---------------


" vaxe(haXe's omnicompletion plugin) {{{

"}}}

" haskell -----------------{{{
" neco-ghc --- {{{
let g:necoghc_enable_detailed_browse = 1
"}}}
" vim2hs --- {{{
let g:haskell_conceal_wide = 1
"let g:haskell_quasi          =  0
"let g:haskell_interpolation  =  0
"let g:haskell_regex          =  0
"let g:haskell_jmacro         =  0
"let g:haskell_shqq           =  0
"let g:haskell_sql            =  0
"let g:haskell_json           =  0
"let g:haskell_xml            =  0
let g:haskell_hsp = 0
" }}}
" }}}

" JavaScript ================================= {{{
" vim-coffeescript {{{
" in $HOME/.vim/after/ftplugin/coffee.vim
" let coffee_make_options = '--bare'
" }}}
" }}}

" emmet-vim {{{
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
\  'indentation' : ' ',
\  'stylus': {
\    'extends': 'sass',
\    'snippets': {
\      'abc': 'ababababa',
\    }
\  },
\}
"}}}

" indentLine ------------{{{
"let g:indentLine_color_term = 239
"let g:indentLine_color_gui = '#A4E57E'
"let g:indentLine_color_tty_dark = 2
"let g:indentLine_char = '¦'
"let g:indentLine_faster = 0
let g:indentLine_fileType = ['vim', 'python', ]
nnoremap <Leader>il :IndentLinesToggle
"}}}

"=========== =========== }}}


" --- key maps {{{
nnoremap <SID>[Unite] <Nop>
nmap ,u <SID>[Unite]
nnoremap <SID>[UMenu] <Nop>
nmap [Unite]t <SID>[UMenu]

nnoremap <silent>[UMenu]g :Unite -silent -start-insert menu:git<CR>

" バッファ一覧
nnoremap <silent> <SID>[Unite]b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> <SID>[Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" .gitを基準にしたプロジェクト一覧 (ctrlp的な)
nnoremap <silent> <SID>[Unite]p :<C-u>Unite file_rec/async:!<CR>
" レジスタ一覧
nnoremap <silent> <SID>[Unite]r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> <SID>[Unite]m :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> <SID>[Unite]u :<C-u>Unite buffer file_mru<CR>
" タブ一覧
nnoremap <silent> <SID>[Unite]t :<C-u>Unite tab<CR>
" 全部乗せ
nnoremap <silent> <SID>[Unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" その他
nnoremap <silent> <SID>[Unite]` :<C-u>Unite -auto-quit neobundle/update<CR>
" Outline
nnoremap <silent> <SID>[Unite]o :<C-u>Unite -vertical outline<CR>
" grep
nnoremap <silent> <SID>[Unite]g :<C-u>Unite grep<CR>
" quickfix
nnoremap <silent> <SID>[Unite]q :<C-u>Unite -no-quit -direction=botright quickfix

"" neocomplete
"imap <C-i>  <Plug>(neocomplete_start_unite_complete)
"imap <C-w>  <Plug>(neocomplete_start_unite_quick_match)
" }}}
" ------------ Unite }}}

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

" ------ RainbowParentTheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 15
let g:rbpt_loadcmd_toggle = 0
" enable at startup
:RainbowParenthesesActivate
" ハイライトを切り替えるキーマップ
nnoremap <silent> <SID>[Show]rr :RainbowParenthesesToggle<CR>

autocmd MyAutoCmd Syntax *.clj RainbowParenthesesLoadRound
autocmd MyAutoCmd Syntax *.clj,*.m RainbowParenthesesLoadSquare
autocmd MyAutoCmd Syntax *.m,*.hx,*.cpp,*.scala RainbowParenthesesLoadBraces

" ------ TweetVim {{{
let g:tweetvim_async_post = 1
let g:tweetvim_display_time = 1
let g:tweetvim_include_rts = 1
let g:tweetvim_tweet_per_page = 50
let g:tweetvim_cache_size = 30
"let g:tweetvim_footer = ''
let g:tweetvim_say_insert_account = 1
"nmap <UP> <Plug>(tweetvim_action_page_next)
"nmap <Down> <Plug>(tweetvim_action_page_previous)

nnoremap <silent> ,tv :<C-u>TweetVimHomeTimeline<CR>
nnoremap <silent> ,tm :<C-u>TweetVimMentions<CR>
nnoremap <silent> ,tp :<C-u>TweetVimSay<CR>
" }}}
"
" --- MemoList {{{
let g:memolist_memo_suffix = 'markdown'
let g:memolist_memo_suffix = 'markdown'
let g:memolist_memo_date = '%Y-%m-%d %H:%M'
let g:memolist_memo_date = 'epoch'
let g:memolist_memo_date = '%D %T'
let g:memolist_prompt_tags = 1
let g:memolist_prompt_categories = 1
let g:memolist_qfixgrep = 1
let g:memolist_vimfiler = 1
let g:memolist_path = '~/Dropbox/memolist'
"let g:memolist_template_dir_path =
"}}}
" ------ OpenBrowser {{{
nmap <Space>w <Plug>(openbrowser-smart-search)
" ----}}}

" --------- quickhl {{{
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)

nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

nmap <F9>     <Plug>(quickhl-manual-toggle)
xmap <F9>     <Plug>(quickhl-manual-toggle)

nmap <Space>j <Plug>(quickhl-cword-toggle)

nmap <Space>] <Plug>(quickhl-tag-toggle)

map H <Plug>(operator-quickhl-manual-this-motion)
" ----- }}}

" ----- Gundo.vim --- {{{
nnoremap U :<C-u>GundoToggle<CR>
" ---- }}}


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

" --- smartchr ---- {{{
" commons {{{
inoremap <expr> , smartchr#one_of(', ', ',')
" }}}

autocmd MyAutoCmd
      \ FileType ruby
      \ call s:def_smartchar()

autocmd MyAutoCmd
      \ FileType javascript
      \ call s:def_smartchar()

autocmd MyAutoCmd
      \ FileType coffee
      \ call s:def_smartchar()

autocmd MyAutoCmd
      \ FileType cpp
      \ call s:def_smartchar()

autocmd MyAutoCmd
      \ FileType haxe
      \ call s:def_smartchar()

autocmd MyAutoCmd
      \ FileType go
      \ call s:def_smartchar()

function! s:def_smartchar()
  let l:lang = &filetype

  " NOTE: 辞書とかを駆使した方が高速かな？
  if l:lang ==# 'ruby'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')

  elseif l:lang ==# 'python'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')
    inoremap <buffer> <expr> # smartchr#one_of('# ', '#')
    inoremap <buffer> <expr> & smartchr#loop('&', ' and ')
    inoremap <buffer> <expr> <Bar> smartchr#loop('\|', ' or ')
    inoremap <buffer> <expr> \ smartchr#loop('\', 'lambda ')

  elseif l:lang ==# 'javascript'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
    inoremap <buffer> <expr> -> smartchr#one_of('function', '->')

  elseif l:lang ==# 'coffee'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')
    inoremap <buffer> <expr> \ smartchr#one_of('\', ' -> ', ' => ')

  elseif l:lang ==# 'cpp'
    inoremap <buffer> <expr> : smartchr#loop(': ', '::', ':')
    inoremap <buffer> <expr> . smartchr#loop('.', '->')

  elseif l:lang ==# 'haxe'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')
    inoremap <buffer> <expr> \ smartchr#one_of('\', ' -> ')
  elseif l:lang ==# 'go'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' := ', ' == ', '=')
    inoremap <buffer> <expr> ! smartchr#one_of(' !', ' != ', '!')
    inoremap <buffer> <expr> < smartchr#one_of('<', '<-')
  elseif l:lang ==# 'clojure'
    inoremap <buffer> <expr> . smartchr#loop('.', '..', '->', '-->')
  endif
endfunction
"  }}}


" --- gist-vim -----{{{
let g:gist_use_password_in_gitconfig = 1
"}}}
" --- Tagbar --- {{{
nnoremap <SID>[Show]t  :<C-u>TagbarToggle<CR>
"}}}

" --- lightline -- {{{
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


let g:vimrc_sid = GetScriptID(s:vimrc)

source ~/.vimrc.local


let g:is_dvorak = 0
function! ToggleDvorakMode()
  if g:is_dvorak
    let g:is_dvorak = 0
    set keymap=
  else
    let g:is_dvorak = 1
    set keymap=dvorak
  endif
endfunction
command! ToggleDovorakMode call ToggleDvorakMode()

" vim: foldmethod=marker
