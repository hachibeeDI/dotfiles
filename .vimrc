" --------------------------------------------------------
"    _                _     _ _               _
"   | |__   __ _  ___| |__ (_) |__   ___  ___( )___
"   | '_ \ / _` |/ __| '_ \| | '_ \ / _ \/ _ \// __|
"   | | | | (_| | (__| | | | | |_) |  __/  __/ \__ \
"   |_| |_|\__, _|\___|_| |_|_|_.__/ \___|\___| |___/
" vimrc
" --------------------------------------------------------

set nocompatible

" variables ----

let s:MY_VIMRUNTIME = expand('~/.vim')
let s:BUNDLEPATH = expand('~/.neobundle')
let s:vimrc = "~/.vimrc"

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = has('mac') || has('macunix') || has('gui_macvim')


"set autogroup
augroup MyAutoCmd
  autocmd!
augroup END

if has('vim_starting')
  set runtimepath& runtimepath+=~/.vim/neobundle.vim/
endif
call neobundle#rc(s:BUNDLEPATH)


" gitプロトコルよりもhttpsのほうが高速
"let g:neobundle_default_git_protocol = 'https'

"------- set plugins ------- {{{
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\   'windows' : 'echo "X<"',
\   'cygwin' : 'make -f make_cygwin.mak',
\   'mac' : 'make -f make_mac.mak',
\   'unix' : 'make -f make_unix.mak',
\ },
\}
if s:is_mac
  let g:vimproc#dll_path = s:BUNDLEPATH . '/vimproc/autoload/vimproc_mac.so'
endif
NeoBundleLazy 'Shougo/neocomplete.vim', {
\   'autoload' : {
\     'insert' : 1,
\ },
\   'depends' : 'Shougo/context_filetype.vim',
\   'disabled' : !has('lua'),
\   'vim_version' : '7.3.885'
\ }
NeoBundleLazy 'Shougo/neosnippet', {
\ 'autoload' : {
\   'insert' : 1,
\ }}
NeoBundleLazy 'Shougo/neosnippet-snippets', {
\ 'autoload' : {
\   'insert' : 1,
\ },
\ 'base': expand('~/Dropbox/development/viml/'),
\ 'type': 'nosync',
\ }

NeoBundleFetch 'Shougo/neobundle.vim', {
    \ 'base': '~/.vim',
    \ }

NeoBundle 'Shougo/vimfiler', '', 'default'
call neobundle#config('vimfiler', {
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
    \   'commands' : ["VimShellPop", "VimShell"],
    \   }
    \}
" compile and exec the code and pop result on Quickfix-window
NeoBundleLazy 'thinca/vim-quickrun', {
\ 'autoload': {
\   'commands': ["QuickRun"],
\   'mappings': ['nxo', '<Plug>(quickrun)', '<Plug>(quickrun-op)', ],
\ }}

" runtimepathに追加されていない？ 要調査
NeoBundle 'tpope/vim-fugitive' ", {
"\ 'autoload': {
"\   'commands': ["Git", "Gstatus", "Gcommit", "Gedit", "Gwrite", "Ggrep", "Glog", "Gdiff"],
"\ }
"\}
NeoBundleLazy 'gregsexton/gitv' , {
\ 'autoload' : {
\   'commands' : ['Gitv', 'Gitv!'],
\   }
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
map <silent> <unique> <Leader>cd <Plug>RooterChangeToRootDirectory
let g:rooter_patterns = ['.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', 'Rakefile', 'Gruntfile.js', 'Gruntfile.coffee']

"Unite
NeoBundleLazy 'Shougo/unite.vim' , {
\ 'autoload' : {
\   'commands' : ["Unite", "UniteWithBufferDir", "QuickRun"],
\ }
\}
NeoBundle 'Shougo/neomru.vim'
call neobundle#config('unite-ssh', {
\ 'lazy' : 1,
\ 'autoload' : {
\   'unite_sources' : 'file_mru'},
\ })

NeoBundle 'Shougo/unite-ssh'
call neobundle#config('unite-ssh', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'unite_sources' : 'ssh'},
      \ })
NeoBundle 'Shougo/unite-build'
call neobundle#config('unite-build', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'unite_sources' : 'build'},
      \ })
" NeoBundle 'h1mesuke/unite-outline'
" NOTE: Imploved by lua-interface
NeoBundle 'Shougo/unite-outline', '', 'default'
call neobundle#config('unite-outline', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'unite_sources' : 'outline'},
      \ })
NeoBundle 'tsukkee/unite-tag', '', 'default'
call neobundle#config('tsukkee/unite-tag', {
\ 'lazy' : 1,
\ 'autoload' : {
\   'unite_sources' : 'tag'},
\ })
NeoBundleLazy 'majutsushi/tagbar', {
\ 'autoload' : {
\   'commands' : ["TagbarToggle"],
\ }
\}

NeoBundle 'osyo-manga/unite-quickfix'
call neobundle#config('unite-quickfix', {
\ 'lazy' : 1,
\ 'autoload' : {
\   'unite_sources' : 'quickfix'},
\ })

NeoBundleLazy 'hachibeeDI/unite-pypi-classifiers', {
\ 'autoload' : {
\   'unite_sources' : 'pypiclassifiers'},
\ 'base': expand('~/Dropbox/development/viml/'),
\ 'type': 'nosync',
\ }

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
" ------ operator-replace {{{
map r <Plug>(operator-replace)
" }}}
NeoBundleLazy 'emonkak/vim-operator-comment', {
\ 'depends': ['kana/vim-operator-user'],
\ 'autoload': {
\     'mappings' : ['<Plug>(operator-uncomment)',
\                   '<Plug>(operator-comment', ], }}
" operator-comment {{{
map M <Plug>(operator-uncomment)
map m <Plug>(operator-comment)
" }}}
NeoBundleLazy 'rhysd/vim-operator-surround', {
\   'depends': ['kana/vim-operator-user', 'osyo-manga/vim-textobj-multiblock', 'thinca/vim-textobj-between'],
\   'autoload': {
\     'mappings' : ['<Plug>(operator-surround-append)',
\                   '<Plug>(operator-surround-delete)',
\                   '<Plug>(operator-surround-replace)', ], }}
" surround mappings {{{
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

" delete or replace most inner surround
" if you use vim-textobj-multiblock
nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)
" if you use vim-textobj-between
nmap <silent>sdb <Plug>(operator-surround-delete)<Plug>(textobj-between-a)
nmap <silent>srb <Plug>(operator-surround-replace)<Plug>(textobj-between-a)
" }}}

NeoBundleLazy 'hachibeeDI/vim-operator-autopep8', {
\   'autoload' : {
\     'filetypes' : ['python'],
\ },
\   'depends': ['kana/vim-operator-user', 'andviro/flake8-vim'],
\   'base': expand('~/Dropbox/development/viml/'),
\   'type': 'nosync',
\ }
map ,p <Plug>(operator-autopep8)

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
" textobj multiblock {{{
omap ab <Plug>(textobj-multiblock-a)
vmap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
vmap ib <Plug>(textobj-multiblock-i)
" }}}
NeoBundleLazy 'thinca/vim-textobj-between', {
\ 'depends': ['kana/vim-textobj-user'],
\ 'autoload' : {
\   'mappings' : ['<Plug>(textobj-between-a)', '<Plug>(textobj-between-i)'],
\   }
\ }
" textobj between {{{
omap a_ <Plug>(textobj-between-a)
xmap a_ <Plug>(textobj-between-a)
omap i_ <Plug>(textobj-between-i)
xmap i_ <Plug>(textobj-between-i)
"}}}

NeoBundleLazy 'bps/vim-textobj-python', {
\ 'depends': ['kana/vim-textobj-user'],
\ 'autoload': {
\   'mappings': ['<Plug>(textobj-python-function-a)', '<Plug>(textobj-python-function-i)'],
\   }
\ }
" --- text-obj-python ---- {{{
  " in $HOME/.vim/after/ftplugin/python.vim
" }}}

NeoBundle 'hachibeeDI/vim-textobj-continuous-line', {
\ 'base': expand('~/Dropbox/development/viml/'),
\ 'type': 'nosync',
\ }

"textobj-user }}}

NeoBundle 'kana/vim-smartinput'
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
\   'commands' : ["GundoToggle"],
\ }
\}

NeoBundleLazy 'nathanaelkane/vim-indent-guides', {
\ "autoload" : {
\   "filetypes" : ["python", "vbnet"],
\ }
\}
NeoBundleLazy 'git://github.com/vim-scripts/IndentAnything.git', {
\ "autoload" : {
\   "filetypes" : ["html", "xhtml", "htmldjango", "play2-html", "javascript"],
\ }
\}
NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {
\ "autoload" : {
\   "filetypes" : ["html", "xhtml", "jinja", "coffee", "javascript", "typescript"],
\ }}

"" add jasmine syntax
"NeoBundleLazy 'claco/jasmine.vim', {
"\ "autoload" : {
"\   "filetypes" : ["coffee", "javascript", "typescript"],
"\ }}

" complete word in English. depends on `look` command.
NeoBundle 'ujihisa/neco-look'
NeoBundleLazy 'koron/codic-vim', {
\ 'autoload': {
\   'commands': ['Codic'],
\   'function_prefix': 'codic',
\ }}
NeoBundle 'rhysd/unite-codic.vim'
call neobundle#config('unite-codic.vim', {
\ 'lazy' : 1,
\ 'autoload' : {
\   'unite_sources' : 'codic'},
\ })

NeoBundleLazy 'mattn/excitetranslate-vim', {
      \ 'depends': 'mattn/webapi-vim',
      \ 'autoload' : { 'commands': ['ExciteTranslate']}
      \ }
xnoremap E :ExciteTranslate<CR>

NeoBundleLazy 'LeafCage/foldCC', {
\ 'autoload' : {
\   'functions' : ["FoldCCtext"],
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
\ "autoload" : {
\   "filetypes" : ["python"],
\ },
\ 'disabled' : !has('python'),
\ }
" --- forked
" NeoBundleLazy 'andviro/flake8-vim', {
" \ 'autoload' : {
" \   'filetypes' : ['python'],
" \ }}
NeoBundleLazy 'flake8-vim', {
\ 'autoload' : {
\   'filetypes' : ['python'],
\ },
\ 'base': expand('~/Dropbox/development/viml/'),
\ 'type': 'nosync',
\}
NeoBundleLazy 'hachibeeDI/rope-vim', {
\ 'autoload' : {
\   'filetypes' : ['python'],
\ },
\ 'disabled' : !has('python'),
\ 'base': expand('~/Dropbox/development/viml/'),
\ 'type': 'nosync',
\}
NeoBundleLazy 'davidhalter/jedi-vim', {
\ "autoload" : {
\   "filetypes" : ["python"],
\ },
\ 'disabled' : !has('python'),
\ }
NeoBundleLazy 'lambdalisue/vim-django-support', {
\ "autoload" : {
\   "filetypes" : ["python"],
\ }}
NeoBundleLazy 'Glench/Vim-Jinja2-Syntax', {
\ "autoload" : {
\   "filetypes" : ["html", "jinja"],
\ }}

" }}}
" - - golang {{{
if executable('go')
  NeoBundleLazy 'Blackrush/vim-gocode', {
  \ 'build' : {
  \   'mac' : 'go get -u github.com/nsf/gocode && go install -v github.com/nsf/gocode',
  \   'unix' : 'go get -u github.com/nsf/gocode && go install -v github.com/nsf/gocode', },
  \ "autoload": {"filetypes": ['go']},
  \ }
  NeoBundleLazy 'dgryski/vim-godef', {
  \ 'build' : {
  \   'mac' : 'go get -u code.google.com/p/rog-go/exp/cmd/godef && go install -v code.google.com/p/rog-go/exp/cmd/godef',
  \   'unix' : 'go get -u code.google.com/p/rog-go/exp/cmd/godef && go install -v code.google.com/p/rog-go/exp/cmd/godef', },
  \ "autoload": {"filetypes": ['go']},
  \ }
  if $GOROOT != ''
    " 標準でバンドルされてるプラギン
    set rtp+=$GOROOT/misc/vim
    autocmd MyAutoCmd BufWritePre *.go Fmt
    autocmd MyAutoCmd BufWritePre *.go Lint
  endif
endif
" }}}
" -- haXe {{{
NeoBundleLazy 'jdonaldson/vaxe', {
    \ "autoload" : {
    \   "filetypes" : ["haxe", "hxml", "nmml.xml"],
    \ }
    \}
"  }}}
" -- C++ {{{
" clang
" C++11's syntax
NeoBundleLazy 'vim-jp/cpp-vim', {
\ "autoload" : {
\   "filetypes" : ["cpp"] }
\}
"https://github.com/beyondmarc/opengl.vim
" git submodule add git://github.com/beyondmarc/opengl.vim.git bundle/syntax_opengl
NeoBundleLazy 'Rip-Rip/clang_complete', {
    \ "autoload" : {
    \   "filetypes" : ["cpp"] }
    \}

" }}}
" -- JavaScript {{{
NeoBundleLazy 'pangloss/vim-javascript', {
\ "autoload" : {
\   "filetypes" : ["javascript"],
\}}
NeoBundleLazy 'jiangmiao/simple-javascript-indenter', {
\ "autoload" : {
\   'filetypes': ['javascript'],
\ }
\}
" この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1
NeoBundleLazy 'jelera/vim-javascript-syntax', {
\ 'autoload': {
\    'filetypes': ['javascript'],
\ }}
if has('python') && executable('npm')
  NeoBundleLazy 'marijnh/tern_for_vim', {
  \ 'build' : 'npm install',
  \ 'autoload' : {
  \   'functions': ['tern#Complete', 'tern#Enable'],
  \   'filetypes' : 'javascript'
  \ }}
endif
" coffee
NeoBundleLazy 'kchmck/vim-coffee-script', {
    \ "autoload" : {
    \   "filetypes" : ["coffee"] }
    \}
" }}}
" -- Scala {{{
NeoBundleLazy 'yuroyoro/vim-scala', {
    \ "autoload" : {
    \   "filetypes" : ["scala"] }
    \}
" Play2のテンプレートとかのシンタックス
NeoBundleLazy 'gre/play2vim', {
\ "autoload" : {
\   "filetypes" : ["scala"] }
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
\  "autoload" : {
\    "filetypes" : ["ruby"] }}

NeoBundleLazy 'ujihisa/unite-rake', {
\  'autoload' : {
\    "filetypes" : ["ruby"] }
\ }

NeoBundleLazy 'basyura/unite-rails', {
\  'autoload' : {
\    "filetypes" : ["ruby"] }
\ }
"}}}

" -- Lisp {{{
"}}}
" -- Haskell {{{
if executable('ghc')
  NeoBundleLazy 'dag/vim2hs', {
      \ "autoload" : {
      \   "filetypes" : ["haskell"] }
      \}
  NeoBundleLazy 'pbrisbin/html-template-syntax', {
      \ "autoload" : {
      \   "filetypes" : ["haskell"] }
      \}
  " NOTE: require 'ghc-mod'. install from `cabal install ghc-mod`.
  NeoBundleLazy 'ujihisa/neco-ghc', {
      \ "autoload" : {
      \   "filetypes" : ["haskell"] }
      \}
  NeoBundleLazy 'eagletmt/ghcmod-vim', {
      \ "autoload" : {
      \   "filetypes" : ["haskell"] }
      \}

  "http://vim-users.jp/2011/12/hack241/
  " NOTE: require 'hoogle'
  NeoBundleLazy 'ujihisa/unite-haskellimport', {
      \ "autoload" : {
      \   "filetypes" : ["haskell"] }
      \}
endif
" }}}
" -- VB.NET {{{
NeoBundleLazy 'hachibeeDI/vim-vbnet', {
\ "autoload" : {
\   "filetypes" : ["vbnet"],
\   },
\ "stay_same" : 1,
\}
" }}}
" -- markup {{{
NeoBundleLazy 'mattn/emmet-vim', {
\ "autoload" : {
\   "filetypes" : ["html", "xhtml", "htmldjango", "play2-html",  "eruby", "css", "stylus", "jinja"],
\ }
\}

NeoBundleLazy 'othree/html5.vim', {
\ "autoload" : {
\   "filetypes" : ["html", "xhtml", "htmldjango", "play2-html",  "eruby", "jinja"],
\ }
\}

" }}}

" --- style sheets {{{
" css_color is too heavy... ...
"" seems more useful then css_color.vim
"NeoBundleLazy 'skammer/vim-css-color', {
"    \ "autoload" : {
"    \   "filetypes" : ["css", "less", "scss", "sass"] }
"    \}

NeoBundleLazy 'cakebaker/scss-syntax.vim', {
\ "autoload" : {
\   "filetypes" : ["scss", "sass"] }
\ }

" もう少しscssとcompassへの理解を深めてから使う
"NeoBundleLazy 'AtsushiM/sass-compile.vim', {
"\ "autoload" : {
"\   "filetypes" : ["scss", "sass"] }
"\ }

NeoBundleLazy 'groenewege/vim-less', {
\ "autoload" : {
\   "filetypes" : ["less"] }
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

" === }}}
NeoBundleLazy 'SQLUtilities', {
    \ 'depends' :
    \   ['vim-scripts/Align'],
    \ "autoload" : {
    \   "filetypes" : ["sql", "sqloracle", "sqlserver"] }
    \}

NeoBundleLazy 'timcharper/textile.vim', {
\ "autoload" : {
\   "filetypes" : ["textile"] }
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
\ "autoload" : {
\   'commands': ['RainbowParenthesesToggle', 'RainbowParenthesesLoadRound', 'RainbowParenthesesLoadBraces'],
\ }}

NeoBundleLazy 'mattn/gist-vim', {
    \ 'autoload' : {
    \   'commands' : [ "Gist" ]}
    \}
NeoBundle 'mattn/webapi-vim'
NeoBundleLazy 'tyru/open-browser.vim', {
    \ 'autoload' : {
    \     'functions' : "OpenBrowser",
    \     'commands'  : ["OpenBrowser", "OpenBrowserSearch", "OpenBrowserSmartSearch"],
    \     'mappings'  : ["<Plug>(openbrowser-smart-search)", "<Plug>(openbrowser-open)"],
    \ },
    \}

NeoBundleLazy 'osyo-manga/vim-watchdogs', {
    \ 'depends' :
    \       ['osyo-manga/shabadou.vim'],
    \ 'autoload' : {
    \   'commands' : ["WatchdogsRun", "WatchdogsRunSilent", "QuickRun"],
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
    \   'commands' : ["TweetVimSay", "TweetVimHomeTimeline", "TweetVimMentions", "TweetVimSearch"],
    \ }
    \}
NeoBundleLazy 'glidenote/memolist.vim', {
\ 'autoload' : {
\ 'commands' : ["MemoNew", "MemoList", "MemoGrep"],
\ }
\}

" developping
NeoBundleLazy 'hachibeeDI/unite-pythonimport', {
\ 'autoload' : {
\   "filetypes" : ["python"],
\   },
\ "stay_same" : 1,
\ }

"}}}

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

filetype plugin indent on
syntax enable

" Installation check.
NeoBundleCheck
if !has('vim_starting')
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook('on_source')
endif

" vital.vim --- {{{
let g:Vit = vital#of('vital')
"call extend(s:, g:Vit, 'keep') " スクリプトローカルに展開したくなったら
call g:Vit.load('Data.List').load('Data.String').load("Math")

"}}}
"}}}

let s:exist_ramdisk = glob('/Volumes/RamDisk')

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
"set regexpengine=1

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
set complete=.
" Set popup menu max height.
set pumheight=20
" <C-a> <C-x> で英字も増減させる
set nrformats=alpha,octal,hex
" a list of deletable
set backspace=eol,indent,start

" Disable automatically insert comment.
autocmd MyAutoCmd FileType *
      \ setl formatoptions-=ro | setl formatoptions+=mM
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
  set conceallevel=2 concealcursor=iv
  set colorcolumn=79
  set relativenumber
endif
set number
set history=100000

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

" enable cursorline only forcused buffer.
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
  if &ft != 'qf'
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
\   if (winnr('$') == 1) &&
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

  if &ft == 'unite'
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

if version >= 703
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
nnoremap <expr> <SID>[EditSupport]e* ':' . line(".") . ',$s/\<' . expand('<cword>') . '\>/'

" ---- nomal mode ----{{{
":はコマンドモードへの移行、;はfind時に次の該当単語へジャンプする
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <Backspace> :%s/

nnoremap Y y$

" x,y,cで削除した文字はblack holeに行ってもらう.
nnoremap x "_x
nnoremap s "_s
nnoremap c "_c
vnoremap x "_x
vnoremap s "_s
vnoremap c "_c
onoremap c "_c

" adjust buffer size
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
nnoremap <Left> <C-w>>
nnoremap <Right> <C-w><

" Ctrl + C は、`insert modeの強制終了`なので微妙に挙動がかわる。うざいので置き換える
inoremap <C-c> <Esc>

" 行頭と空白抜きの先頭をトグルする
nnoremap <expr> 0
\         col('.') == 1 ? '^' : '0'
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
" http://vim-users.jp/2011/04/hack214/
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
  return type(c) == type("") ? c : nr2char(c)
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

" <expr>は副作用(カーソルの移動とか)を許可しないので使えない
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
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
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
    %s/\s\+$//g
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
  if l:filename != ''
    execute 'edit ' . l:filename
  endif
endfunction

nnoremap <SID>[Show]j :<C-u>JunkFile

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

" kobito
function! s:open_kobito(...)
    if a:0 == 0
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


"}}}

" 指定したエンコードでファイルを開き直すためのエイリアス
command! Utf8 edit ++enc=utf-8
command! Cp932 edit ++enc=cp932
command! Sjis Cp932
command! Utf16b edit ++enc=utf-16
command! Utf16l edit ++enc=utf-16le
command! Iso2022jp edit ++enc=iso-2022-jp
command! Jis Iso2022jp
command! Eucjp edit ++enc=euc-jp
"
" ============= }}}


"-------------
" plugin settings
"---------------

" =======================================================
" ------------ neocomplete.vim -----------------: {{{
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

let bundle = neobundle#get('neocomplete.vim')
function! bundle.hooks.on_source(bundle)
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1

  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  "" default
  "let g:neocomplete#auto_completion_start_length = 2
  "" Set minimum syntax keyword length. default is 4
  "let g:neocomplete#sources#syntax#min_keyword_length = 4
  let g:neocomplete#skip_auto_completion_time = '1'
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
  \     'default': '',
  \     'java': $HOME.'/.vim/dict/java.dict',
  \     'javascript': $HOME.'/.vim/dict/javascript.dict',
  \     'coffee': $HOME.'/.vim/dict/javascript.dict',
  \     'python': $HOME.'/.vim/dict/python.dict',
  \     'vim': $HOME.'/.vim/dict/vim.dict',
  \     'cpp': $HOME.'/.vim/dict/cpp.dict',
  \     'vimshell': $HOME.'/.vimshell_hist',
  \     'scheme': $HOME.'/.gosh_completions',
  \     'scala': s:BUNDLEPATH.'/vim-scala/dict/scala.dict',
  \ }

  "initialize
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  " Define keyword means 日本語をキャッシュしない
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings. {{{
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  imap <expr> <CR> pumvisible() ?
\     neocomplete#close_popup() : "\<Plug>(smartinput_CR)"

  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  " <C-h>, <BS>: close popup and delete backword char.
  "inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  "inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  imap <expr><C-h> neocomplete#smart_close_popup()."\<Plug>(smartinput_C-h)"
  imap <expr><BS> neocomplete#smart_close_popup()."\<Plug>(smartinput_C-h)"

  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e> pumvisible() ? neocomplete#cancel_popup() : "\<End>"

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  "imap <expr> `  pumvisible() ?
  "      \ "\<Plug>(neocomplete_start_unite_quick_match)" : '`'
  " }}}

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  " clang via - http://d.hatena.ne.jp/osyo-manga/20120911/1347354707
  let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.haxe = '\v([\]''"\)]|\w|(^\s*))(\.|\()'
  let g:neocomplete#sources#omni#input_patterns.python = '[^. \t]\.\w*'
  let g:neocomplete#sources#omni#input_patterns.go = '\h\w*\.\?'

  " -----------------------------------------------
  " ---  NOTE: some of filetype specific settings is in
  " ---  $HOME/.vim/after/ftplugin/*.vim .
  " ex. setlocal omnifunc * ... ...
  " -----------------------------------------------

  " ================ force omni patterns ======
  " NOTE: this fearture is heavy.
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.ruby =
  \ '[^. *\t]\.\w*\|\h\w*::'
  let g:neocomplete#force_omni_input_patterns.haxe =
  \ '\v([\]''"\)]|\w|(^\s*))(\.|\()'
  let g:neocomplete#force_omni_input_patterns.python =
  \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  let g:neocomplete#force_omni_input_patterns.go = '\h\w*\.\?'

  " customize sort complete candiates
  "call neocomplete#custom#source('_', 'sorters', ['sorter_length'])
endfunction
unlet bundle
" }}}

" ------------------- clang_complete ------------- {{{
" neocomplcacheとの競合を避けるため、自動呼び出しはOff
let g:clang_complete_auto=0
let g:clang_auto_select=0
"libclangを使う
let g:clang_use_library=1
let g:clang_debug=1
if s:is_mac
  let g:clang_library_path="/usr/lib"
endif
let g:clang_user_options = '-std=c++11'
" }}}

"キャッシュディレクトリの場所を指定
if s:exist_ramdisk
    let g:neocomplcache_temporary_dir = '/Volumes/RamDisk/.neocon'
    let g:unite_data_directory = '/Volumes/RamDisk/.unite'
    let g:vimfiler_data_directory = '/Volumes/RamDisk/.vimfiler'
else
    "let g:neocomplcache_temporary_dir = '/Volumes/RamDisk/.neocon'
    "let g:unite_data_directory = '/Volumes/RamDisk/.unite'
    "let g:vimfiler_data_directory = '/Volumes/RamDisk/.vimfiler'
endif

"============================================================
" ---- neosnippet : {{{
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" tell neosnippet about my snippets
let g:neosnippet#snippets_directory = '~/.vim/snippets'

" plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
autocmd MyAutoCmd InsertLeave * :NeoSnippetClearMarkers

" }}}

" =============== jedi-vim =============== {{{
let bundle = neobundle#get('jedi-vim')
function! bundle.hooks.on_source(bundle)
  let g:jedi#squelch_py_warning = 1

  " do not allow set some configure auto.
  let g:jedi#auto_vim_configuration = 0

  let g:jedi#use_tabs_not_buffers = 1
  " neocomplcacheとコンフリクトを起こすので無効にしておく
  let g:jedi#completions_enabled = 0
  let g:jedi#popup_on_dot = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#show_call_signatures = "1"

  " command mappings
  let g:jedi#goto_assignments_command = "<leader>g"
  let g:jedi#goto_definitions_command = "<leader>d"
  let g:jedi#documentation_command = "K"
  let g:jedi#rename_command = "<leader>r"
  let g:jedi#usages_command = "<leader>n"
  let g:jedi#completions_command = "<C-Space>"
endfunction

unlet bundle
"}}}
" vaxe(haXe's omnicompletion plugin) {{{

"autocmd MyAutoCmd FileType haxe  # move $HOME/.vim/after/ftplugin/haxe.vim
"      \ setl autowrite
autocmd MyAutoCmd FileType hxml
      \ setl autowrite
autocmd MyAutoCmd FileType nmml.xml
      \ setl autowrite

let bundle = neobundle#get('vaxe')
function! bundle.hooks.on_source(bundle)
  let g:vaxe_default_parent_search_patterns = ["project.xml", "*.nmml", "build.hxml"]
  let g:vaxe_haxe_version = 3
  let g:vaxe_completion_write_compiler_output = 1

  function! s:init_vaxe_keymap()
    nnoremap <buffer> ,vo :<C-u>call vaxe#OpenHxml()<CR>
    nnoremap <buffer> ,vc :<C-u>call vaxe#Ctags()<CR>
    nnoremap <buffer> ,vi :<C-u>call vaxe#ImportClass()<CR>
    nnoremap <buffer> ,vx :<C-u>call vaxe#ProjectHxml()<CR>
    nnoremap <buffer> ,vj :<C-u>call vaxe#JumpToDefinition()<CR>
  endfunction

  autocmd MyAutoCmd FileType haxe call s:init_vaxe_keymap()
  autocmd MyAutoCmd FileType hxml call s:init_vaxe_keymap()
  autocmd MyAutoCmd FileType nmml.xml call s:init_vaxe_keymap()
endfunction

unlet bundle
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
" javascript-libraries-syntax.vim = {{{
let g:used_javascript_libs = 'angularjs'
"}}}
" vim-coffeescript {{{
" in $HOME/.vim/after/ftplugin/coffee.vim
" let coffee_make_options = '--bare'
" }}}
" }}}

" emmet-vim {{{
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
\  'indentation' : ' ',
\}
"}}}

" vim-indentguides ------------{{{
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_color_change_percent=10
nmap <silent> <Leader>ig <Plug>IndentGuidesToggle
"}}}

"=========== =========== }}}

" via: http://www.karakaram.com/vimfiler
" ---------Unite.vim--------- {{{
" buffer local keymap is in s:MY_VIMRUNTIME/after/ftplugin/unite.vim

let bundle = neobundle#get('unite.vim')
function! bundle.hooks.on_source(bundle)
  " common settings {{{
  " 入力モードで開始する
  let g:unite_enable_start_insert=1
  " 開くときの横幅
  let g:unite_winwidth=40
  " 縦幅
  let g:unite_winheight=40
  " }}}

  " -- grep
  if executable('ag')
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_default_opts = '--nocolor --nogroup'
      let g:unite_source_grep_recursive_opt = ''
      let g:unite_source_grep_max_candidates = 200
  endif

  " --- Unite menu --- {{{
  " http://d.hatena.ne.jp/osyo-manga/20130225/1361794133
  let g:unite_source_menu_menus = get(g:, 'unite_source_menu_menus', {})

  " unite-shortcut
  let g:unite_source_menu_menus.shortcut = {
  \   "description" : "shortcut"
  \}

  let g:unite_source_menu_menus.shortcut.candidates = [
  \   [ "vimrc"  , s:vimrc ],
  \   [ "bundles", fnamemodify(s:vimrc, ":h")."/bundles.vim" ],
  \   [ "after ft plugin",   s:MY_VIMRUNTIME."/.vim/after/ftplugin/"],
  \   [ "My Blog", "OpenBrowser http://hachibeechan.hateblo.jp" ],
  \   [ "github", "https://github.com/hachibeeDI" ],
  \   [ "neobundles", s:BUNDLEPATH ],
  \   [ "AllMap", "Unite output:AllMap" ],
  \ ]

  function! g:unite_source_menu_menus.shortcut.map(key, value)
      let [word, value] = a:value

      if isdirectory(value)
          return {
  \               "word" : "[directory] ".word,
  \               "kind" : "directory",
  \               "action__directory" : value
  \           }
      elseif !empty(glob(value))
          return {
  \               "word" : "[file] ".word,
  \               "kind" : "file",
  \               "default_action" : "tabdrop",
  \               "action__path" : value,
  \           }
      else
          return {
  \               "word" : "[command] ".word,
  \               "kind" : "command",
  \               "action__command" : value
  \           }
      endif
  endfunction
  " --- menu }}}
endfunction

unlet bundle

" --- key maps {{{
nnoremap <SID>[Unite] <Nop>
nmap ,u <SID>[Unite]

" バッファ一覧
nnoremap <silent> <SID>[Unite]b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> <SID>[Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" .gitを基準にしたプロジェクト一覧 (ctrlp的な)
nnoremap <silent> <C-p>  :<C-u>Unite file_rec/async:!<CR>
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
" output
nnoremap <silent> <SID>[Unite]p :<C-u>Unite menu<CR>

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

" ------------- VimFiler ------------------" {{{
" use Vimfiler as default instead of netrw
let g:vimfiler_as_default_explorer =  1
" Enable file operation commands.
let g:vimfiler_safe_mode_by_default = 0
" Edit file by tabedit.
let g:vimfiler_edit_action = 'tabopen'
" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
" let g:vimfiler_split_rule = 'botright'
" Use trashbox.
" Windows only and require latest vimproc.
"let g:unite_kind_file_use_trashbox = 1
let g:vimfiler_ignore_pattern = '^\%(.git\|.DS_Store\)$'

"<C-u>は、Vimによって挿入される範囲指定を削除するためのもの
"<CR>はキャリッジ・リターンを表すリテラルシーケンス
"そして:VimFilerExplorerでいんじゃね感
nnoremap <silent> ,fe :<C-u>VimFilerExplorer<CR>
nnoremap <silent> ,fb :<C-u>VimFilerBufferDir<CR>
"" }}}

" --- quickrun -----{{{
" url:http://d.hatena.ne.jp/osyo-manga/20111014/1318586711
let bundle = neobundle#get('vim-quickrun')
function! bundle.hooks.on_source(bundle)
  "設定の初期化
  let g:quickrun_config = get(g:, 'quickrun_config', {})

  " default config via http://d.hatena.ne.jp/osyo-manga/20120919/1348054752
  let g:quickrun_config = {
\    '_': {
\      "hook/close_buffer/enable_empty_data": 1
\      , "hook/inu/enable": 1
\      , "hook/inu/wait": 20
\      , "outputter/buffer/split": ":botright 8sp"
\      , "outputter/error/error": "quickfix"
\      , "outputter/error/success": "buffer"
\      , "runner": "vimproc"
\      , "runner/vimproc/updatetime": 40
\    },
\    'run/vimproc': {
\      "exec": "%s:p:r %a"
\      , "output_encode": "utf-8"
\      , "runner": "vimproc"
\      , "outputter": "buffer"
\    },
\    "run/vimproc/pause": {
\      "exec": "%s:p:r %a && pause"
\      , "output_encode": "utf-8"
\      , "runner": "shell"
\      , "outputter": "buffer"
\    },
\    'run/system': {
\      "exec": "%s:p:r %a"
\      , "output_encode": "utf-8"
\      , "runner": "system"
\      , "outputter": "buffer"
\    },
\    'markdown': {
\      'type': 'markdown/pandoc'
\      , 'cmdopt': '-s'
\      , 'outputter': 'browser'
\    },
\    'cpp': {
\      'command': 'clang++'
\      , 'cmdopt': '-std=c++11 -stdlib=libc++'
\    },
\    'watchdogs_checker/pychecker': {
\      'command': 'pychecker'
\      , 'exec': '%c %o %s:p'
\      , 'quickfix/errorformat': '%f:%l:%m'
\    },
\    'python/watchdogs_checker': {
\      'type': 'watchdogs_checker/pychecker'
\    },
\    'watchdogs_checker/go_build': {
\      'command': 'go'
\      , 'exec': '%c build %s:p'
\      , 'quickfix/errorformat': '%f:%l:%m'
\    },
\    'go/watchdogs_checker': {
\      'type': 'watchdogs_checker/go_build'
\    },
\ }

" < " http://d.hatena.ne.jp/osyo-manga/20120924/1348473304
" < " ---- vim-watchdog --- : {{{
  call watchdogs#setup(g:quickrun_config)
  " 書き込み後にシンタックスチェックを行うかどうか
  let g:watchdogs_check_BufWritePost_enable = 0

endfunction

unlet bundle

let g:quickrun_no_default_key_mappings = 1
"nmap <F5> <Plug>(quickrun)
nmap <Leader>q <Plug>(quickrun)
nmap ,q <Plug>(quickrun-op)
nnoremap <SID>[Show]w :<C-u>WatchdogsRunSilent<CR><Esc>
" watchdog }}}
" quickrun }}}


" vim-hier ------------------- {{{
"let g:hier_enabled = 1
"}}}

" quickfixstatus ================ {{{
":QuickfixStatusEnable -- turns on the feature globally
":QuickfixStatusDisable -- turns off the feature globally
" }}}

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
" ハイライトを切り替えるキーマップ
nnoremap <silent> <SID>[Show]rr :RainbowParenthesesToggle<CR>

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
let g:memolist_memo_suffix = "markdown"
let g:memolist_memo_suffix = "markdown"
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
let g:memolist_memo_date = "epoch"
let g:memolist_memo_date = "%D %T"
let g:memolist_prompt_tags = 1
let g:memolist_prompt_categories = 1
let g:memolist_qfixgrep = 1
let g:memolist_vimfiler = 1
let g:memolist_path = "~/Dropbox/memolist"
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

"--- VimShell ----------------{{{
" This go along with vimshell doc's sample.
" My purpose of using VimShell is lessen stress of Windows and its terrible terminal-emulator!

let bundle = neobundle#get('vimshell')
function! bundle.hooks.on_source(bundle)

    if has('win32') || has('win64')
      " Display user name on Windows.
      let g:vimshell_prompt = $USERNAME."% "
    else
      " Display user name on Linux.
      let g:vimshell_prompt = $USER."% "

      call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
      call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
      let g:vimshell_execute_file_list['zip'] = 'zipinfo'
      call vimshell#set_execute_file('tgz,gz', 'gzcat')
      call vimshell#set_execute_file('tbz,bz2', 'bzcat')
    endif

    let g:vimshell_user_prompt = 'fnamemodify(getcwd(),":~")'
    " let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
endfunction
unlet bundle

nnoremap <silent> ,vp :<C-u>VimShellPop<CR>
nnoremap <silent> ,cvp :<C-u>VimShellPop %:p:h<CR>
nnoremap <silent> ,cvs :<C-u>VimShell %:p:h<CR>
" }}}

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
  if l:lang == 'ruby'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')

  elseif l:lang == 'python'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')
    inoremap <buffer> <expr> # smartchr#one_of('# ', '#')
    inoremap <buffer> <expr> & smartchr#loop('&', ' and ')
    inoremap <buffer> <expr> <Bar> smartchr#loop('\|', ' or ')
    inoremap <buffer> <expr> \ smartchr#loop('\', 'lambda ')

  elseif l:lang == 'javascript'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
    inoremap <buffer> <expr> -> smartchr#one_of('function', '->')

  elseif l:lang == 'coffee'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')
    inoremap <buffer> <expr> \ smartchr#one_of('\', ' -> ', ' => ')

  elseif l:lang == 'cpp'
    inoremap <buffer> <expr> : smartchr#loop(': ', '::', ':')
    inoremap <buffer> <expr> . smartchr#loop('.', '->')

  elseif l:lang == 'haxe'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')
    "inoremap <buffer> <expr> + smartchr#loop(' + ', '+')
    "inoremap <buffer> <expr> - smartchr#loop(' - ', '-')
    "inoremap <buffer> <expr> * smartchr#loop(' * ', '*')
  elseif l:lang == 'go'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' := ', ' == ', '=')
    inoremap <buffer> <expr> ! smartchr#one_of(' !', ' != ', '!')
    inoremap <buffer> <expr> < smartchr#one_of('<', '<-')
  endif
endfunction
"  }}}

" --- smartinput --- {{{

" --------------- trigger definitions ------------------{{{
" 以下、neocompleteなどの主要キーマップを書き換えるプラグインとの衝突に留意すること

" 他プラグインへの<BS>や<CR>マッピング時に、smartinputの機能を含むソレを提供させる
" via: http://qiita.com/todashuta@github/items/bdad8e28843bfb3cd8bf
call smartinput#map_to_trigger('i', '<Plug>(smartinput_BS)',
      \                        '<BS>',
      \                        '<BS>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-h)',
      \                        '<BS>',
      \                        '<C-h>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)',
      \                        '<CR>',
      \                        '<CR>')

call smartinput#map_to_trigger('i', '<CR>', '<CR>', '<CR>')
call smartinput#map_to_trigger('i', '<C-j>', '<C-j>', '<C-j>')
call smartinput#map_to_trigger('i', ':', ':', ':')
call smartinput#map_to_trigger('i', '#', '#', '#')
call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
call smartinput#map_to_trigger('i', '-', '-', "<C-R>=smartchr#loop(' - ', '-')<CR>")
call smartinput#map_to_trigger('i', '+', '+', "<C-R>=smartchr#loop(' + ', '+')<CR>")
call smartinput#map_to_trigger('i', '<', '<', '<')
call smartinput#map_to_trigger('i', '>', '>', '>')
call smartinput#map_to_trigger('i', '%', '%', '%')
call smartinput#map_to_trigger('i', '$', '\$', '\$')
call smartinput#map_to_trigger('i', '/', '/', '/')
call smartinput#map_to_trigger('i', '*', '\*', '\*')
" }}}
" smartinputとsmartchrの連携tips
"  -> [http://ac-mopp.blogspot.jp/2013/07/vim-smart-input.html]

"     Note: that only "wide" syntax items are effective.  In other words,
"     syntax items which is linked to another is not effective, and they
"     will never be matched.  For example:
" map(synstack(line('.'), col('.')), 'synIDattr(synIDtrans(v:val), "name")')
" で得られるSyntax名のみ
" TODO: synIDattr(synID(line('.'), col('.'), 0), 'name') ではだめなのかな


"" via: http://rhysd.hatenablog.com/entry/20121017/1350444269
call smartinput#define_rule({
\   'at': '\s\+\%#$',
\   'char': '<CR>',
\   'input': "<C-o>:call setline('.', substitute(getline('.'), '\\s\\+$', '', ''))<CR><CR>",
\   })

call smartinput#define_rule({
\   'at'       : '\%(\<struct\>\|\<class\>\|\<enum\>\)\s*\w\+.*\%#',
\   'char'     : '{',
\   'input'    : '{};<Left><Left>',
\   'filetype' : ['cpp'],
\   })

" 演算子でsmartchrを適用したくない条件を書いていく {{{
call smartinput#define_rule({
\   'at'       : '\%#',
\   'char'     : '-',
\   'input'    : '-',
\   'syntax': ['Constant', 'Special', 'Comment'],
\   })
call smartinput#define_rule({
\   'at'       : '\%#',
\   'char'     : '-',
\   'input'    : '-',
\   'filetype': ['rst', 'markdown', 'html', 'xml', 'css', 'sass', 'scss', 'stylus'],
\   })
call smartinput#define_rule({
\   'at'       : '\%#',
\   'char'     : '+',
\   'input'    : '+',
\   'syntax': ['Constant', 'Special'],
\   })

"}}}

call smartinput#define_rule({
\   'at'       : '\s===\s\%#',
\   'char'     : '<BS>',
\   'input'    : '<Left><BS><Right>',
\   })
call smartinput#define_rule({
\   'at'       : '\s==\s\%#',
\   'char'     : '<BS>',
\   'input'    : '<Left><BS><Right>',
\   })
call smartinput#define_rule({
\   'at'       : '\s=\s\%#',
\   'char'     : '<BS>',
\   'input'    : '<BS><Left><BS><Right>',
\   })
call smartinput#define_rule({
\   'at'       : '\s=\%#',
\   'char'     : '=',
\   'input'    : '=<Space>',
\   })


" Python専用 ------------------ {{{
" classとかの定義時に:までを入れる
call smartinput#define_rule({
\   'at'       : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#',
\   'char'     : '(',
\   'input'    : '():<Left><Left>',
\   'filetype' : ['python'],
\   })
" が、すでに:がある場合は重複させない. (smartinputでは、atの定義が長いほど適用の優先度が高くなる)
call smartinput#define_rule({
\   'at'       : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#.*:',
\   'char'     : '(',
\   'input'    : '()<Left>',
\   'filetype' : ['python'],
\   })

call smartinput#define_rule({
\   'at'       : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#:$',
\   'char'     : ':',
\   'input'    : '<Right><CR>',
\   'filetype' : ['python'],
\   })
call smartinput#define_rule({
\   'at'       : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#:$',
\   'char'     : '<CR>',
\   'input'    : '<Right><CR>',
\   'filetype' : ['python'],
\   })
" 辞書の宣言なことが明らかなケースではsmartchrを呼び出す
call smartinput#define_rule({
\   'at'       : '{.\+\%#',
\   'char'     : ':',
\   'input'    : "<C-R>=smartchr#loop(': ', ':')<CR>",
\   'filetype' : ['python'],
\   })
" docstringとかのsphinx形式のアレ
call smartinput#define_rule({
\   'at'       : '^\s*\%#',
\   'char'     : ':',
\   'input'    : "::<Left>",
\   'syntax'   : ["Constant"],
\   'filetype' : ['python'],
\   })
call smartinput#define_rule({
\   'at'       : '^\s*:\%#:',
\   'char'     : '<BS>',
\   'input'    : "<BS><Del>",
\   'syntax'   : ["Constant"],
\   'filetype' : ['python'],
\   })
call smartinput#define_rule({
\   'at'       : '^\s*:.*\%#:',
\   'char'     : ':',
\   'input'    : '<Right>',
\   'syntax'   : ["Constant"],
\   'filetype' : ['python'],
\   })
" ---- }}}

" its in examples in smartinput. insert #{} in a string literal.
call smartinput#define_rule({
\   'at': '\%#',
\   'char': '#',
\   'input': '#{}<Left>',
\   'filetype': ['ruby'],
\   'syntax': ['Constant', 'Special'],
\ })

" add bar(`|`) in smartinput definitions and define input rule. {{{
call smartinput#define_rule({
\   'at': '\%#',
\   'char': '<Bar>',
\   'input': '<Bar><Bar><Left>',
\   'filetype': ['ruby'],
\ })
call smartinput#define_rule({
\   'at': '|\%#|',
\   'char': '<BS>',
\   'input': '<BS><Del>',
\   'filetype': ['ruby'],
\ })
"}}}

" insert <bar> on both side of block argsments.
call smartinput#define_rule({
\   'at': '\({\|\<do\>\)\s*\%#',
\   'char': '<Bar>',
\   'input': '<Bar><Bar><Left>',
\   'filetype': ['ruby'],
\ })

" html and markdown like that -----
call smartinput#define_rule({
\   'at': '\%#',
\   'char': '<',
\   'input': '<><Left>',
\   'filetype': ['xml', 'html', 'eruby'],
\ })
" 前が空白以外なら型パラメータ、空白なら演算子だと考えさせる
call smartinput#define_rule({
\   'at': '[^[:blank:]]\%#',
\   'char': '<',
\   'input': '<><Left>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe'],
\ })
call smartinput#define_rule({
\   'at': '[:blank:]\%#',
\   'char': '<',
\   'input': "<C-R>=smartchr#one_of('< ', '<')<CR>",
\   'filetype': ['java', 'cpp', 'cs', 'haxe'],
\ })

call smartinput#define_rule({
\   'at': '<\%#>',
\   'char': '<BS>',
\   'input': '<Del><BS>',
\   'filetype': ['xml', 'html', 'eruby', 'java', 'cpp', 'cs', 'haxe'],
\ })

call smartinput#define_rule({
\   'at': '<.*\%#>',
\   'char': '>',
\   'input': '<Right>',
\   'filetype': ['xml', 'html', 'eruby', 'java', 'cpp', 'cs', 'haxe'],
\ })

" C系syntaxのcomment挿入のスマート {{{
call smartinput#define_rule({
\   'at': '/\%#',
\   'char': '/',
\   'input': '/<Space>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe'],
\ })
call smartinput#define_rule({
\   'at': '// \%#',
\   'char': '<BS>',
\   'input': '<BS><BS>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe'],
\ })
" css用 {{{
call smartinput#define_rule({
\   'at': '/\%#',
\   'char': '/',
\   'input': '*<Space><Space>*/<Left><Left><Left>',
\   'filetype': ['css'],
\ })
" }}}
" one lineコメント後も / 入力でmultiline化
call smartinput#define_rule({
\   'at': '// \%#',
\   'char': '/',
\   'input': '<BS><BS>*<Space><Space>*/<Left><Left><Left>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe'],
\ })
call smartinput#define_rule({
\   'at': '/\%#',
\   'char': '*',
\   'input': '*<Space><Space>*/<Left><Left><Left>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe', 'css'],
\ })
call smartinput#define_rule({
\   'at': '/\* \%# \*/',
\   'char': '<BS>',
\   'input': '<BS><BS><Del><Del><Del>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe', 'css'],
\ })
" javadocっぽい感じに展開してくれる
call smartinput#define_rule({
\   'at': '/\* \%# \*/',
\   'char': '<CR>',
\   'input': '<Del><BS>*<CR><Space>*<CR><Up><End><Space>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe', 'css'],
\ })
" multiline commentの中では改行ごとに頭に*をつけてくれる
call smartinput#define_rule({
\   'at': '^\s*\*\s\+.*\%#$',
\   'char': '<CR>',
\   'input': '<CR>*<Space>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe'],
\   'syntax': ['Comment'],
\ })
" }}}

" セミコロンを要求するうんこシンタックス対応 {{{
call smartinput#define_rule({
\   'at': '\%#;$',
\   'char': ';',
\   'input': '<Right>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe'],
\ })
call smartinput#define_rule({
\   'at': '\%#;$',
\   'char': '<CR>',
\   'input': '<Right><CR>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe'],
\ })
call smartinput#define_rule({
\   'at': '(\%#;$',
\   'char': '<CR>',
\   'input': ')<Left><CR><BS><CR><Up><End><Tab>',
\   'filetype': ['java', 'cpp', 'cs', 'haxe'],
\ })
" }}}

" ERB
call smartinput#define_rule({
\   'at': '<\%#',
\   'char': '%',
\   'input': '%%<Left>',
\   'filetype': ['eruby'],
\ })
call smartinput#define_rule({
\   'at': '%.*\%#%',
\   'char': '%',
\   'input': '',
\   'filetype': ['eruby'],
\ })

call smartinput#define_rule({
\   'at': '\s\%#=\s',
\   'char': '<BS>',
\   'input': '<BS><Right><Del><Left>',
\ })

" haxe
" synIDattr(synID(line('.'), col('.'), 0), 'name') == 'haxeSString' ? '${}<Left>' : '$' みたいにしたい
call smartinput#define_rule({
\   'at': '\%#',
\   'char': '$',
\   'input': '${}<Left>',
\   'filetype': ['haxe'],
\   'syntax': ['Constant'],
\ })
" ダブルコーテーションの時はsmartしないように(応急処置)
call smartinput#define_rule({
\   'at': '\".*\%#',
\   'char': '$',
\   'input': '$',
\   'filetype': ['haxe'],
\   'syntax': ['Constant'],
\ })
"---- }}}

" --- gist-vim -----{{{
let g:gist_use_password_in_gitconfig = 1
"}}}
" --- Tagbar --- {{{
nnoremap <SID>[Show]t  :<C-u>TagbarToggle<CR>
"}}}

" --- lightline -- {{{
let g:lightline = {
\   'component': {
\     'virtualenv': '%{&filetype=="python"?"":virtualenv#statusline()}',
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
  return &ft =~ 'help\|vimfiler\|gundo\|qf' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo\|qf' && &ro ? '錠' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'qf' ? 'quickfix' :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo\|qf' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '梗'._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyVaxe()
  if &ft == 'haxe'
    return pathshorten(fnamemodify(vaxe#CurrentBuild(), ':p:.')) . ' =>[' . vaxe#CurrentBuildPlatform() . ']'
  else
    return ''
  endif
endfunction
" lightline }}}


let g:vimrc_sid = GetScriptID(s:vimrc)

source ~/.vimrc.local

" vim: foldmethod=marker
