" vim:fileencoding=utf-8

set nocompatible
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/.bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/.bundle/'))

"------- set plugins ------- {{{
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \   'windows' : 'echo "X<"',
    \   'cygwin' : 'make -f make_cygwin.mak',
    \   'mac' : 'make -f make_mac.mak',
    \   'unix' : 'make -f make_unix.mak',
    \    },
    \}
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplcache-clang'
NeoBundle 'Shougo/vimshell'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mileszs/ack.vim'
"@Deprecated
NeoBundle 'scrooloose/syntastic'

"Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'

" compile and exec the code and pop result on Quickfix-window
NeoBundle 'thinca/vim-quickrun'
" get and read referece on vim
NeoBundle 'thinca/vim-ref'

NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'git://github.com/vim-scripts/IndentAnything.git'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'css_color.vim'
NeoBundle 'tpope/vim-surround'

"TDD plugin for vim
NeoBundle 'reinh/vim-makegreen'
"syntax hightlight for python, with pyflake
NeoBundle 'mitechie/pyflakes-pathogen'
NeoBundle 'vim-scripts/pythoncomplete'
NeoBundle 'lambdalisue/vim-django-support'

NeoBundle 'vim-scripts/java_getset.vim'
" enable use slim on vim
NeoBundle 'slimv.vim'
" カッコいい言語のカッコをレインボーにする
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'yuroyoro/vim-scala'
NeoBundle 'scala.vim'
" Play2のテンプレートとかのシンタックス
NeoBundle 'gre/play2vim'

NeoBundle 'mattn/sonictemplate-vim'
NeoBundle 'Lokaltog/vim-powerline'

NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'motemen/hatena-vim'

NeoBundle 'osyo-manga/shabadou.vim'
"watchdogs is required vimproc, quickrun, shabadou
NeoBundle 'osyo-manga/vim-watchdogs'


filetype plugin indent on
filetype indent on
"}}}

"
" common settings
"
"
set vb t_vb=

" have to set, before setting colorscheme-command
set t_Co=256

set directory=~/.vimcache/vimswap
set backupdir=~/.vimcache/bak
set viminfo+=n~/.vimcache/viminfo

" settings for infer encoding and formats
set encoding=utf-8 "WindowsだとCygwin以外で問題でるかも? でも使わないので問題なし
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp,default,latin
set fileformats=unix,dos,mac

" set fold line on {{{, }}}
set foldmethod=marker
"set foldenable
"set foldmarker={{{,}}}
"set foldcolumn=3

set linespace=3
" Tabや行末のスペースを表示させる
"set list
"set listchars=tab:>-,trail:~,eol:.,extends:>,precedes:<,nbsp:%
" tab:>-,trail:~,extends:》,precedes:《,nbsp:% 

" enable modeline
set modeline
" number of readble lines
set modelines=5

set pastetoggle=<F10>


" set PEP8 Style
set autoindent
set cindent "clang style indent
set indentkeys-=0# " do not break indent on#
set incsearch
set ignorecase
set ruler
set wildmenu
set commentstring=\ #\ %s
set foldlevel=0
set foldlevel=99
set foldmethod=syntax

set scrolloff=999
set smartcase
set smarttab
set autoread

set splitbelow
set splitright
set previewheight=30

" FileType
" Syntax setting {{{
" ---------------
syntax on

augroup MyAutoCmdFileType
    autocmd! MyAutoCmdFileType
    " VB.NET
    autocmd BufRead,BufNewFile *.vb setlocal filetype=vbnet
    " Scala
    autocmd BufRead,BufNewFile *.scala setlocal filetype=scala

    autocmd FileType scheme :RainbowParenthesesToggle
    autocmd FileType clojure :RainbowParenthesesToggle
    autocmd FileType lisp :RainbowParenthesesToggle
    
augroup END
"}}}

"___________
" indent
"---------
"
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"--------
" display settings
"---------
"
"syntax enable
set background=dark
colorscheme solarized
let g:solarized_termcolors=256

"colorscheme zenburn
"set transparency=50
set title
set number

set showcmd
" disable auto textwraping
set textwidth=0
set colorcolumn=80
set wrap

set showtabline=2

highlight link ZenkakuSpace Error
match ZenkakuSpace /　/

"" StatusLine{{{
"set laststatus=2
"set statusline=%F%m%r%h%w\ [%L]\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L


" }}}


" ----- Syntax Settings -----------
"" Java
let java_highlight_all=1
let java_space_errors=1
let java_highlight_function=1
"4debug highlight
let java_highlight_debug=1


" ======== Key Mapping ======== {{{
" ---- nomal mode ----{{{
"<NPA> means to unset command on keymap
nnoremap q: <NOP>
nnoremap ; :
nnoremap <Backspace> :%s/

"move cursor
nmap 1 ^
nmap 9 $

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
inoremap <C-k> <C-d>D
inoremap <C-u> <C-o>d0
inoremap <C-y> <C-o>P

"command mode
"inoremap <Backspace> <C-o>:
"}}}
"}}}

" ---- Load Templetes ---- <<<
" ゆくゆくはtempletefile.vimみたいなものを検討
"autocmd BufNewFile *.java 0r ~/.vim/templates/javasrc.java
"autocmd BufNewFile *.h 0r ~/.vim/templates/header.h
"autocmd BufNewFile *.c 0r ~/.vim/templates/csrc.c
""autocmd BufNewFile *.cpp 0r ~/.vim/templates/
"autocmd BufNewFile *.cs 0r ~/.vim/templates/csharp.cs
"autocmd BufNewFile *.py 0r ~/.vim/templates/python.py
">>>

"-------------
" plugin settings
"---------------
"

" =======================================================
" ------------ neocomplcache -----------------: {{{
" disable autoComplPop
let g:acp_enableAtStartup = 0

let g:neocomplcache_enable_at_startup = 1   " enabled when start vim 
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_max_list = 1000
let g:neocomplcache_auto_completion_start_length = 2
" set minimum syntax keyword length
let g:neocomplcache_min_syntax_length = 3
"" like AutoComplPop
let g:neocomplcache_enable_auto_select = 1
"" search with camel case like Eclipse
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
" Skip Heavy complete
let g:NeoComplCache_EnableSkipCompletion=1
let g:NeoComplCache_SkipCompletionTime = '0.5'
let g:NeoComplCache_SkipInputTime = '0.1'

inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" FileType毎のOmni補完を設定
autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php        setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c          setlocal omnifunc=ccomplete#Complete
autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete

" ファイルを探す際、この値を末尾に追加してあるファイルも探す
let g:neocomplcache_include_suffixes = {'c':'.h','cpp':'.h'}

" when define include, complete path for include header
let g:neocomplcache_include_paths = {
            \ 'c' : '.,/usr/include',
            \ 'cpp': '.,/usr/include/c++,/usr/include',
        \ }

let g:neocomplcache_include_patterns = {
            \ 'c':'^\s#\s*include',
            \ 'cpp':'^\s#\s*include',
        \ }

"Define dictonaru
"scalaの設定は @yuroyoro 氏のプラギンのを拝借
let g:neocomplcache_dictionary_filetype_lists={
        \ 'default':'',
        \ 'java':$HOME.'/.vim/dict/java.dict',
        \ 'javascript':$HOME.'/.vim/dict/javascript.dict',
        \ 'python':$HOME.'/.vim/dict/python.dict',
        \ 'vim':$HOME.'/.vim/dict/vim.dict',
        \ 'vimshell':$HOME.'/.vim/dict/vimshell.dict',
        \ 'cpp':$HOME.'/.vim/dict/cpp.dict',
        \ 'scala':$HOME.'/.vim/.bundle/vim-scala/dict/scala.dict'
    \}

"============================================================
" ---- neosnippet : {{{

" tell neosnippet about my snippets
let g:neosnippet#snippets_directory = '~/.vim/snippets'
" plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

"" SuperTab Like snippets behavior
"imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" :pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" for snippet_complete marker
if has ('conceal')
    set conceallevel=2 concealcursor=i
endif

"}}}

"}}}

" vim-indentguides ------------{{{
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_color_change_percent=20
"}}}
" ---------Unite.vim---------

""" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
" 開くときの横幅
let g:unite_winwidth=40
" 縦幅
let g:unite_winheight=50

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" --- quickrun -----{{{
" url:http://d.hatena.ne.jp/osyo-manga/20111014/1318586711

if !exists("g:quickrun_config")
    let g:quickrun_config={}
endif

" default
let g:quickrun_config["_"] = {
            \ 'outputter' : 'quickfix',
            \ 'split' : 'rightbelow 10sp',
            \ }

let g:quickrun_config["cpp"] = {
    \ 'command' : 'clang++',
    \ 'cmdopt' : '-std=c++11 -stdlib=libc++',
    \ }
"  }}}

" ===============================================================
" < " http://d.hatena.ne.jp/osyo-manga/20120924/1348473304
" < " ---- vim-watchdog --- : {{{

call watchdogs#setup(g:quickrun_config)

" }}}

" =============================================================
" --- Syntastic --- : {{{

" active_filetypes -> 自動でチェックして欲しいファイル・タイプ
" passive_filetypes -> :SyntasticCheck で手動で呼び出すファイル
let g:syntastic_mode_map = {'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['html', 'zsh', 'scala', 'c', 'cpp']
    \ }
" エラーがあったら、自動的にQuickfixが立ち上がる
let g:syntastic_auto_loc_list = 1

"}}}

"---- netrw(default filer) ----
" set treeview
let g:netrw_liststyle = 3
" push 'v' open a pane on right side
let g:netrw_altv = 1
" push 'o' open a pane on under
let g:netrw_alto = 1

" ------------- VimFiler ------------------"
"<C-u>は、Vimによって挿入される範囲指定を削除するためのもの
"<CR>はキャリッジ・リターンを表すリテラルシーケンス
"そして:VimFilerExplorerでいんじゃね感
nnoremap <silent> ,vf :<C-u>VimFiler -buffer-name=explorer -split -winwidth=35 -toggle -no-quit<CR>
"autocmd! FileType vimfiler call g:my_vimfiler_settings()
"function! g:my_vimfiler_settings()
"    nmap <buffer><expr><Cr> vimfiler#smart_cursor_map


" ----- slimv.vim --------
if has('mac')
    let g:slimv_swank_clojure = '!osascript -e "tell app \"iTerm\"" -e "tell the first terminal" -e "set mysession to current session" -e "launch session \"Default Session\"" -e "tell the last session" -e "exec command \"/bin/bash\"" -e "write text \"cd $(pwd)\"" -e "write text \"lein swank\"" -e "end tell" -e "select mysession" -e "end tell" -e "end tell"'
endif

" ------- sonictemplate.vim -----{{{
let g:sonictemplate_vim_template_dir = [
\ '$HOME/.vim/templates'
\]

"}}}

" ----- hatena-vim ----
let g:hatena_user='hachibeechan'

" ------ power line ----
let g:Powerline_symbols = 'fancy'

" ------ RainbowParentTheses
let g:rbpt_max = 7
let g:rbpt_loadcmd_toggle = 0

"--- ack.vim procとか ---  {{{
"そろそろ限界…今後はOSごとに別ファイルでやったほうがよいかも
"for debian /ubuntu
if has('win32')
    let g:vimproc_dll_path = $HOME."/vimfiles/autoload/proc.dll"
elseif has('mac')
    let g:vimproc_dll_path = $HOME."/.vim/autoload/vimproc_mac.so"
else
    let g:vimproc_dll_path = $HOME."/.vim/autoload/vimproc_unix.so"
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif
"}}}

