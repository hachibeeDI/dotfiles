
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
let s:vimrc = $HOME."/.vimrc"

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
NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'autoload' : {
    \   'insert' : 1,
    \ }}
NeoBundleLazy 'Shougo/neosnippet', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}
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
\ 'autoload' : {
\   'insert' : 1,
\ }}
"    \ 'autoload' : {
"    \   'commands' : ["QuickRun"],
"    \ 'mappings' : ['nxo', '<Plug>(quickrun)'],
"    \ }}

" snipets for neosnippet's dirctory
NeoBundleLazy 'honza/vim-snippets'

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


NeoBundleLazy 'kien/ctrlp.vim', {
\ 'autoload' : {
\   'commands' : ["CtrlP"],
\ }}
nnoremap <C-P> :<C-u>CtrlP<CR>

"Unite
NeoBundle 'Shougo/unite.vim' ", {
"    \ 'autoload' : {
"    \   'commands' : ["Unite", "UniteWithBufferDir", "QuickRun"],
"    \ }
"    \}
"
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

" get and read referece on vim
NeoBundleLazy 'thinca/vim-ref', { 'autoload' : {
      \ 'commands' : 'Ref'
      \ }}
NeoBundleLazy 'thinca/vim-scouter', '', 'same', { 'autoload' : {
      \ 'commands' : 'Scouter'
      \ }}

NeoBundle 'vim-jp/vital.vim'
"call neobundle#config('vital.vim', {
"      \ 'lazy' : 1,
"      \ 'autoload' : {
"      \     'commands' : ['Vitalize'],
"      \ }})

" ---------- utils for edit {{{
" auto insert end after def scope,
" in ruby, lua, sh, zsh and some languages ... ...
"NeoBundleLazy 'tpope/vim-endwise', {
"\   'autoload' : {
"\   "filetypes" : ["ruby", "lua", "sh", "zsh", "vb"],
"\   }}
"NeoBundle 'tpope/vim-surround'
" forked version : http://www.sopht.jp/blog/index.php?/archives/450-surrounding.html
NeoBundle 'anyakichi/vim-surround', {
  \ 'autoload' : {
  \   'mappings' : [
  \     ['n', '<Plug>Dsurround'], ['n', '<Plug>Csurround'],
  \     ['n', '<Plug>Ysurround'], ['n', '<Plug>YSurround']
  \ ]}}

NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace', {
\   'depends': ['kana/vim-operator-user']
\ }
NeoBundle 'emonkak/vim-operator-comment', {
\   'depends': ['kana/vim-operator-user']
\ }

NeoBundleLazy 'kana/vim-smartchr', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent', {
\   'depends': ['kana/vim-textobj-user']
\ }

NeoBundle 'kana/vim-smartinput'

NeoBundleLazy 'kana/vim-smartword', { 'autoload' : {
      \ 'mappings' : [
      \   '<Plug>(smartword-w)', '<Plug>(smartword-b)', '<Plug>(smartword-ge)']
      \ }}
NeoBundleLazy 'kana/vim-smarttill', { 'autoload' : {
      \ 'mappings' : [
      \   '<Plug>(smarttill-t)', '<Plug>(smarttill-T)']
      \ }}

NeoBundleLazy 'taku-o/vim-toggle', {
\   'autoload': {
\     'mappings': ['<Plug>ToggleI', '<Plug>ToggleN', '<Plug>ToggleV']
\   }}
" }}}

NeoBundle 'rhysd/accelerated-jk'
" search words from two spells matched
NeoBundle 'goldfeld/vim-seek'

" undo history visualizer
NeoBundleLazy 'sjl/gundo.vim', {
\ 'autoload' : {
\   'commands' : ["GundoToggle"],
\ }
\}
"TDD plugin for vim
NeoBundleLazy 'reinh/vim-makegreen', {
\ 'autoload' : {
\   'functions' : ["MakeGreen"],
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

" complete word in English. depends on `look` command.
NeoBundle 'ujihisa/neco-look'

NeoBundleLazy 'mattn/excitetranslate-vim', {
      \ 'depends': 'mattn/webapi-vim',
      \ 'autoload' : { 'commands': ['ExciteTranslate']}
      \ }
xnoremap E :ExciteTranslate<CR>

" === Language surpport === {{{
" -- Python {{{
NeoBundleLazy 'Crapworks/python_fn.vim', {
    \ "autoload" : {
    \   "filetypes" : ["python"],
    \ }
    \}

NeoBundleLazy 'jmcantrell/vim-virtualenv', {
    \ "autoload" : {
    \   "filetypes" : ["python"],
    \ }
    \}

" search invailed code with pyflakes
NeoBundleLazy 'kevinw/pyflakes-vim', {
    \ "autoload" : {
    \   "filetypes" : ["python"],
    \ },
    \}

NeoBundleLazy 'davidhalter/jedi-vim', {
    \ "autoload" : {
    \   "filetypes" : ["python"],
    \ }
    \}

NeoBundleLazy 'lambdalisue/vim-django-support', {
    \ "autoload" : {
    \   "filetypes" : ["python"],
    \ }
    \}
NeoBundleLazy 'bps/vim-textobj-python', {
\ 'depends': ['kana/vim-textobj-user'],
\ 'autoload' : {
\   "filetypes" : ["python"],
\   }
\ }

" }}}
" -- haXe {{{
NeoBundleLazy 'jdonaldson/vaxe', {
    \ "autoload" : {
    \   "filetypes" : ["haxe", "hxml", "nmml.xml"],
    \ }
    \}
"NeoBundleLazy 'MarcWeber/vim-haxe', {
"    \ "autoload" : {
"    \   "filetypes" : ["python"],
"    \ }
"    \}

"  }}}
" -- C++ {{{
" clang
" C++11's syntax
NeoBundleLazy 'vim-jp/cpp-vim', {
\ 'script_type': 'syntax',
\ "autoload" : {
\   "filetypes" : ["cpp"] }
\}
"https://github.com/beyondmarc/opengl.vim
" git submodule add git://github.com/beyondmarc/opengl.vim.git bundle/syntax_opengl
NeoBundleLazy 'Rip-Rip/clang_complete', {
    \ "autoload" : {
    \   "filetypes" : ["cpp"] }
    \}
"NeoBundleLazy 'beyondmarc/opengl.vim', {
"\ 'script_type': 'syntax',
"    \ "autoload" : {
"    \   "filetypes" : ["c", "cpp"] }
"    \}

" }}}
" -- JavaScript {{{
NeoBundleLazy 'pangloss/vim-javascript', {
    \ "autoload" : {
    \   "filetypes" : ["javascript"] }
    \}
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
\ 'script_type': 'syntax',
\ "autoload" : {
\   "filetypes" : ["scala"] }
\}
" }}}

" -- Ruby {{{
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

" require `gem install rails_best_practices`
NeoBundleLazy 'taichouchou2/unite-rails_best_practices', {
\  'autoload' : {
\    "filetypes" : ["ruby"] }
\ }

" require `gem install reek`
NeoBundleLazy 'taichouchou2/unite-reek', {
\   'autoload': {
\     'filetypes': ['ruby', 'eruby', 'haml'] },
\ }
"}}}

" -- Lisp {{{
"}}}
" -- Haskell {{{
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

" }}}
" -- VB.NET {{{
NeoBundleLazy 'hachibeeDI/vim-vbnet', {
\"autoload" : {
\   "filetypes" : ["vbnet"],
\   }
\}
" }}}
" -- markup {{{
NeoBundleLazy 'mattn/emmet-vim', {
\ "autoload" : {
\   "filetypes" : ["html", "xhtml", "htmldjango", "play2-html",  "eruby"],
\ }
\}

NeoBundleLazy 'othree/html5.vim', {
\ "autoload" : {
\   "filetypes" : ["html", "xhtml", "htmldjango", "play2-html",  "eruby"],
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
\ 'script_type' : 'syntax',
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
" }}}

" === }}}
NeoBundleLazy 'SQLUtilities', {
    \ 'depends' :
    \   ['vim-scripts/Align'],
    \ "autoload" : {
    \   "filetypes" : ["sql", "sqloracle", "sqlserver"] }
    \}

NeoBundleLazy 'timcharper/textile.vim', {
\ 'script_type' : 'syntax',
\ "autoload" : {
\   "filetypes" : ["textile"] }
\ }

NeoBundle 'godlygeek/tabular'

NeoBundle 'vim-scripts/Colour-Sampler-Pack', {'script_type' : 'colors'}
NeoBundle 'altercation/vim-colors-solarized', {'script_type' : 'colors'}
NeoBundle 'ujihisa/unite-colorscheme', {'gui': 1}
NeoBundle 'ujihisa/unite-font', {'gui': 1}


NeoBundle 'sudo.vim'
NeoBundle 'kana/vim-metarw'
"NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 't9md/vim-quickhl'

" enable use slime on vim
" カッコいい言語のカッコをレインボーにする
" g:lisp_rainbowでもいいような……
NeoBundleLazy 'kien/rainbow_parentheses.vim', {
    \ "autoload" : {
    \   "filetypes" : ["scheme", "lisp", "cpp", "haxe", "javascript", "clojure", "scala"] }
    \}

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
NeoBundle 'hachibeeDI/unite-pythonimport'

"}}}

" --- default bundled plugins ---
" enable prebundled plugin
runtime macros/matchinit.vim

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

" enable command-line completion operates in an enhanced mode.
set wildmenu
" show completion menu in command mode
set wildmode=list:full
" A list of file patterns is ignored when expanding
set wildignore=*.o,*.obj,*.pyc
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
" ======== {{{

" ========== View ======================== {{{
" disable bell
set t_vb=
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

" set fold line on {{{, }}}
set foldmethod=marker
set foldenable
"set foldmarker={{{,}}}
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

" ==== }}}

"--------
" display settings
"---------

" enable cursorline only forcused buffer.
setlocal cursorline
autocmd MyAutoCmd WinEnter * setlocal cursorline
autocmd MyAutoCmd WinLeave * setlocal nocursorline

" 各コマンド後の結果をquickfixへ出力させる
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
autocmd QuickfixCmdPost make call <SID>auto_ccl()

function! s:auto_ccl()
  if &ft != 'qf'
    return
  endif

  " リストが空ならそのまま閉じる
  if getqflist() == []
    :cclose
  endif
endfunction


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
  "" バッファが複数あればバッファ数を表示 # とりあえず今は表示しない
  "let no = len(bufnrs)
  "if no is 1
    let bufcount = ''
  "endif
  let is_modified = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '[+]' : ''
  let spacer = (bufcount . is_modified)  ==# '' ? '' : ' '  " 隙間
" カレントバッファ
  let selected_buffer  =  bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr: number of tabpage, which is current
"   origin
  let fname = pathshorten(bufname(selected_buffer))
  let label = bufcount . is_modified . spacer . fname

  if &ft == 'unite'
    return hightlight_start . a:n . ':[unite] ' . unite#get_status_string() . '%T%#TabLineFill#'
  else
    return hightlight_start . a:n . ':< ' . '%' . a:n . 'T' . label . '%T%#TabLineFill#'
  endif
endfunction

function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' | '  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  " 好きな情報を入れる
  let info = ''
  let info .= fnamemodify(getcwd(), ":~") . ' '

  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfunction

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

" ---- search behavior ---- {{{
set incsearch
set ignorecase
set smartcase
"set nowrapscan
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
nnoremap [Show] <Nop>
nmap <Space>s [Show]
nnoremap [Show]m  :<C-u>Capture marks<CR>
nnoremap [Show]k  :<C-u>Capture map<CR>
nnoremap [Show]r  :<C-u>Capture registers<CR>
nnoremap [Show]e  :<C-u>edit $MYVIMRC<CR>
nnoremap [Show]l  :<C-u>source $MYVIMRC<CR>
nnoremap [Show]q  :<C-u>tab help<Space>
nnoremap [Show]hc  :<C-u>HierClear<CR>
nnoremap [Show]hs  :<C-u>HierStart<CR>
nnoremap [Show]hp  :<C-u>HierStop<CR>
nnoremap [Show]hu  :<C-u>HierUpdate<CR>

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
" toggle set spell
nnoremap [Show]s  :<C-u>setl spell!<CR>

if version >= 703
  nnoremap <silent> [Show]n :<C-u>ToggleNumber<CR>

  command! -nargs=0 ToggleNumber call ToggleNumberOption()

  function! ToggleNumberOption()
    if &number
      set relativenumber
    else
      set number
    endif
  endfunction
else
  nnoremap <silent> [Show]n :<C-u>set number!<CR>
endif


nnoremap [EditSupport] <Nop>
nmap , [EditSupport]

" substitute word is under cursor
nnoremap <expr> [EditSupport]s* ':%substitute/\<' . expand('<cword>') . '\>/'
nnoremap <expr> [EditSupport]e* ':' . line(".") . ',$s/\<' . expand('<cword>') . '\>/'

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

" use accelerated_jk
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"}}}

" ---- insert mode ---- {{{
"emacs like key-bind in insert mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
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

" ----------- operation
" http://vim-users.jp/2011/04/hack214/
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(

onoremap _ t_
vnoremap _ t_

if has('path_extra')
    set tags& tags+=.tags,tags
endif

"command mode
"inoremap <Backspace> <C-o>:
"}}}
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

" preview error line in quickfix
nnoremap <M-p> :<C-u>cp<CR>
" next error line in quickfix
nnoremap <M-n> :<C-u>cn<CR>

command!
\  -nargs=1
\  VimGrepCurrent
\  vimgrep <args> % | cw

nnoremap <expr>* ':<C-u>VimGrepCurrent ' . expand('<cword>') . '<CR>'

" ============}}}

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

nnoremap [Show]j :<C-u>JunkFile

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
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

let bundle = neobundle#get('neocomplete.vim')
function! bundle.hooks.on_source(bundle)

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

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  "inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  " ATTENTION: smart inputの設定を優先させるため、こいつはmap_to_triggerにて設定する
  "imap <silent><expr> <CR> neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"

  "function! s:my_cr_function()
  "  return neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"
  "  " For no inserting <CR> key.
  "  "return pumvisible() ? neocomplete#close_popup() : "\<Plug>(smartinput_CR)"
  "endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  " <C-h>, <BS>: close popup and delete backword char.
  "inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  "inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  imap <expr><C-h> neocomplete#smart_close_popup()."\<Plug>(smartinput_C-h)"
  imap <expr><BS> neocomplete#smart_close_popup()."\<Plug>(smartinput_C-h)"

  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplete#enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplete#enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  imap <expr> `  pumvisible() ?
        \ "\<Plug>(neocomplete_start_unite_quick_match)" : '`'

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
  \ '[^. \t]\.\w*'

  " customize sort complete candiates
  "call neocomplete#custom#source('_', 'sorters', ['sorter_length'])

  " in text-mode, neocomplete will complete and conversion words in English. {{{
  if !exists('g:neocomplete#text_mode_filetypes')
    let g:neocomplete#text_mode_filetypes = {}
  endif
  let g:neocomplete#text_mode_filetypes = {
  \ 'rst': 1,
  \ 'markdown': 1,
  \ 'gitrebase': 1,
  \ 'gitcommit': 1,
  \ 'vcs-commit': 1,
  \ 'hybrid': 1,
  \ 'text': 1,
  \ 'help': 1,
  \ 'tex': 1,
  \ }
  "  }}}
  "}}}
endfunction
unlet bundle
"}}}

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
let g:neosnippet#snippets_directory = '~/.vim/snippets,'.s:BUNDLEPATH.'/vim-snippets/snippets'

" plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

"" SuperTab Like snippets behavior
"imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" :pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"}}}
"}}}

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

" emmet-vim {{{
let g:use_emmet_complete_tag = 1
"}}}

" vim-indentguides ------------{{{
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_color_change_percent=10
nmap <silent> <Leader>ig <Plug>IndentGuidesToggle
"}}}

" ctrlP ------------------------ {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"=========== ===========}}}

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
  let g:unite_winheight=50
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

  " unite-shortcut {{{
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
  " --- }}}
endfunction

unlet bundle

" --- key maps {{{
nnoremap [Unite] <Nop>
nmap ,u [Unite]

" バッファ一覧
nnoremap <silent> [Unite]b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> [Unite]r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> [Unite]m :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> [Unite]u :<C-u>Unite buffer file_mru<CR>
" タブ一覧
nnoremap <silent> [Unite]t :<C-u>Unite tab<CR>
" 全部乗せ
nnoremap <silent> [Unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" output
nnoremap <silent> [Unite]p :<C-u>Unite menu<CR>

" その他
nnoremap <silent> [Unite]` :<C-u>Unite -auto-quit neobundle/update<CR>
" Outline
nnoremap <silent> [Unite]o :<C-u>Unite -vertical outline<CR>
" grep
nnoremap <silent> [Unite]g :<C-u>Unite grep<CR>
" quickfix
nnoremap <silent> [Unite]q :<C-u>Unite -no-quit -direction=botright quickfix

"" neocomplete
"imap <C-i>  <Plug>(neocomplete_start_unite_complete)
"imap <C-w>  <Plug>(neocomplete_start_unite_quick_match)
" }}}
" ------------ Unite }}}

" ------------- VimFiler ------------------"{{{
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
" Use trashbox.
" Windows only and require latest vimproc.
"let g:unite_kind_file_use_trashbox = 1

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
\      "hook/close_unite_quickfix/enable_hook_loaded": 1
\      , "hook/unite_quickfix/enable_failure": 1
\      , "hook/close_quickfix/enable_exit": 1
\      , "hook/close_quickfix/enable_success": 1
\      , "hook/close_buffer/enable_failure": 1
\      , "hook/close_buffer/enable_empty_data": 1
\      , "outputter": "multi:buffer:quickfix"
\      , "hook/inu/enable": 1
\      , "hook/inu/wait": 20
\      , "outputter/buffer/split": ":botright 8sp"
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
\    }
\ }

" < " http://d.hatena.ne.jp/osyo-manga/20120924/1348473304
" < " ---- vim-watchdog --- : {{{
  call watchdogs#setup(g:quickrun_config)
  " 書き込み後にシンタックスチェックを行うかどうか
  let g:watchdogs_check_BufWritePost_enable = 0

endfunction

unlet bundle

let g:quickrun_no_default_key_mappings = 1
nmap <F5> <Plug>(quickrun)
nnoremap [Show]w :<C-u>WatchdogsRunSilent<CR><Esc>

"  }}}

" vim-hier ------------------- {{{
"let g:hier_enabled = 1
"}}}

" quickfixstatus ================ {{{
":QuickfixStatusEnable -- turns on the feature globally
":QuickfixStatusDisable -- turns off the feature globally
" }}}

" ----- slimv.vim --------
if s:is_mac
    let g:slimv_swank_clojure = '!osascript -e "tell app \"iTerm\"" -e "tell the first terminal" -e "set mysession to current session" -e "launch session \"Default Session\"" -e "tell the last session" -e "exec command \"/bin/bash\"" -e "write text \"cd $(pwd)\"" -e "write text \"lein swank\"" -e "end tell" -e "select mysession" -e "end tell" -e "end tell"'
endif

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
nnoremap <silent> [Show]rr :RainbowParenthesesToggle<CR>

"--- procとか ---  {{{
"そろそろ限界…今後はOSごとに別ファイルでやったほうがよいかも
"for debian /ubuntu
if s:is_mac
    let g:vimproc#dll_path = s:BUNDLEPATH."/vimproc/autoload/vimproc_mac.so"
elseif has('win32')
    let g:vimproc#dll_path = s:BUNDLEPATH."/vimproc/autoload/vimproc_win32.dll"
else
    let g:vimproc#dll_path = s:BUNDLEPATH."/vimproc/autoload/vimproc_unix.so"
endif
"}}}

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
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)
" ----- }}}
"
" ------ operato-replace {{{
map R <Plug>(operator-replace)
map r <Plug>(operator-replace)
" }}}

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

"}}}
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
"}}}

autocmd MyAutoCmd
      \ FileType ruby
      \ call s:def_smartchar()

autocmd MyAutoCmd
      \ FileType python
      \ call s:def_smartchar()

autocmd MyAutoCmd
      \ FileType javascript
      \ call s:def_smartchar()

autocmd MyAutoCmd
      \ FileType cpp
      \ call s:def_smartchar()

autocmd MyAutoCmd
      \ FileType haxe
      \ call s:def_smartchar()

function! s:def_smartchar()
  let l:lang = &filetype

  " NOTE: 辞書とかを駆使した方が高速かな？
  if l:lang == 'ruby'
    "inoremap <buffer> <expr> : smartchr#loop(': ', '::', ':')
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')

  elseif l:lang == 'python'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')
    "inoremap <buffer> <expr> > smartchr#loop(' > ', ' >= ')
    "inoremap <buffer> <expr> < smartchr#loop(' < ', ' <= ')
    inoremap <buffer> <expr> + smartchr#loop(' + ', '+')
    inoremap <buffer> <expr> - smartchr#loop(' - ', '-')
    inoremap <buffer> <expr> * smartchr#loop(' * ', '*')
    inoremap <buffer> <expr> & smartchr#loop('&', ' and ')
    inoremap <buffer> <expr> <Bar> smartchr#loop('\|', ' or ')

  elseif l:lang == 'javascript'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
    inoremap <buffer> <expr> -> smartchr#one_of('function', '->')

  elseif l:lang == 'cpp'
    inoremap <buffer> <expr> : smartchr#loop(': ', '::', ':')
    inoremap <buffer> <expr> . smartchr#loop('.', '->')

  elseif l:lang == 'haxe'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', '=')
    inoremap <buffer> <expr> + smartchr#loop(' + ', '+')
    inoremap <buffer> <expr> - smartchr#loop(' - ', '-')
    inoremap <buffer> <expr> * smartchr#loop(' * ', '*')

  endif
endfunction
"  }}}

" --- smartinput --- {{{

" --------------- trigger definitions ------------------{{{
" 他プラグインへの<BS>や<CR>マッピング時に、smartinputの機能を含むソレを提供させる
" via: http://qiita.com/todashuta@github/items/bdad8e28843bfb3cd8bf
call smartinput#map_to_trigger('i', '<Plug>(smartinput_BS)',
      \                        '<BS>',
      \                        '<BS>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-h)',
      \                        '<BS>',
      \                        '<C-h>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)',
      \                        '<Enter>',
      \                        "<C-o>:call neocomplete#smart_close_popup() . '\<Plug>(smartinput_CR)'<CR>")

call smartinput#map_to_trigger('i', '<CR>', '<CR>', '<CR>')
call smartinput#map_to_trigger('i', ':', ':', ':')
call smartinput#map_to_trigger('i', '#', '#', '#')
call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
call smartinput#map_to_trigger('i', '<', '<', '<')
call smartinput#map_to_trigger('i', '>', '>', '>')
call smartinput#map_to_trigger('i', '%', '%', '%')
call smartinput#map_to_trigger('i', '$', '\$', '\$')
" }}}
" smartinputとsmartchrの連携tips
"  -> [http://ac-mopp.blogspot.jp/2013/07/vim-smart-input.html]

"     Note: that only "wide" syntax items are effective.  In other words,
"     syntax items which is linked to another is not effective, and they
"     will never be matched.  For example:

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
\   'at'       : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#:',
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
" 辞書の宣言なことが明らかなケースではsmartchrを呼び出す
call smartinput#define_rule({
\   'at'       : '{.\+\%#',
\   'char'     : ':',
\   'input'    : "<C-R>=smartchr#loop(': ', ':')<CR>",
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

" add bar(`|`) in smartinput definitions and define input rule.
call smartinput#define_rule({
\   'at': '\%#',
\   'char': '<Bar>',
\   'input': '<Bar><Bar><Left>',
\   'filetype': ['ruby'],
\ })

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
" 前が空白以外なら型パタメータ、空白なら演算子だと考えさせる
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

" toggle.vim {{{
"imap <silent>,t <Plug>ToggleI
nmap <silent> ,t <Plug>ToggleN
vmap <silent> ,t <Plug>ToggleV

let g:toggle_pairs = {
\   'and': 'or',
\   'or': 'and',
\   'elsif': 'else',
\   'else': 'elsif',
\   'it': 'specify',
\   'specify': 'it',
\   'describe': "context",
\   'context': "describe",
\   'true': 'false',
\   'false': 'true',
\   'yes': 'no',
\   'no': 'yes',
\   'on': 'off',
\   'off': 'on',
\   'public': 'protected',
\   'protected': 'private',
\   'private': 'public',
\   '&&': '||',
\   '||': '&&'
\ }
" }}}
" --- text-obj-python ---- {{{
" - af: a function
" - if: inner function
" - ac: a class
" - ic: inner class

" this plugin has aditional key-bind
"  -  '[pf', ']pf': move to next/previous function
"  -  '[pc', ']pc': move to next/previous class
xmap aF <Plug>(textobj-python-function-a)
omap aF <Plug>(textobj-python-function-a)
xmap iF <Plug>(textobj-python-function-i)
omap iF <Plug>(textobj-python-function-i)
" }}}

" --- gist-vim -----{{{
let g:gist_use_password_in_gitconfig = 1
"}}}
" --- Tagbar --- {{{
nnoremap [Show]t  :<C-u>TagbarToggle<CR>
"}}}

" --- lightline -- {{{
let g:lightline = {
\   'component': {
\     'virtualenv': '%{&filetype=="python"?"":virtualenv#statusline()}',
\     'readonly': '%{&readonly?"ro":""}',
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
\     'right': [['lineinfo' ], ['percent'], ['fileformat', 'fileencoding', 'filetype']],
\   },
\ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyVaxe()
  if &ft == 'haxe'
    return pathshorten(fnamemodify(vaxe#CurrentBuild(), ':p:.')) . ' [' . vaxe#CurrentBuildPlatform() . ']'
  else
    return ''
  endif
endfunction
"}}}


source ~/.vimrc.local

" vim: foldmethod=marker
