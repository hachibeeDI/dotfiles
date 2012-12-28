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

" snipets for neosnippet's dirctory
NeoBundle 'honza/snipmate-snippets'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mileszs/ack.vim'
"@Deprecated
NeoBundle 'scrooloose/syntastic'

"Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'osyo-manga/unite-quickfix'

" compile and exec the code and pop result on Quickfix-window
NeoBundle 'thinca/vim-quickrun'
" get and read referece on vim
NeoBundle 'thinca/vim-ref'

NeoBundle 'tpope/vim-surround'
" undo history visualizer
NeoBundle 'sjl/gundo.vim'

"TDD plugin for vim
NeoBundle 'reinh/vim-makegreen'

NeoBundle 'git://github.com/vim-scripts/IndentAnything.git'
NeoBundleLazy 'nathanaelkane/vim-indent-guides'
" === Language surpport === {{{
" -- Python {{{
" search invailed code with pyflakes
NeoBundleLazy 'kevinw/pyflakes-vim'
NeoBundleLazy 'davidhalter/jedi-vim'
NeoBundleLazy 'lambdalisue/vim-django-support'
" }}}
" -- C++ {{{
" clang
" C++11's syntax
NeoBundleLazy 'vim-jp/cpp-vim'
NeoBundleLazy 'Rip-Rip/clang_complete'
" }}}
" -- JavaScript {{{
NeoBundleLazy 'pangloss/vim-javascript'
" coffee
NeoBundleLazy 'kchmck/vim-coffee-script'
" }}}
" -- Scala {{{
NeoBundleLazy 'yuroyoro/vim-scala'
" Play2のテンプレートとかのシンタックス
NeoBundleLazy 'gre/play2vim'
" }}}
" -- Lisp {{{
" enable use slime on vim
" ここらへんおかしいのでアレ
"NeoBundleLazy 'slimv.vim' なぜか最新版が入らないのでbitbucketからとってくる
NeoBundleLazy 'https://bitbucket.org/kovisoft/slimv'
" カッコいい言語のカッコをレインボーにする
NeoBundleLazy 'kien/rainbow_parentheses.vim'
"}}}
" -- Java {{{

" }}}
" -- markup and style {{{
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'css_color.vim'
NeoBundle 'groenewege/vim-less'
" }}}
" === }}}
NeoBundleLazy 'SQLUtilities'
    \ , {'depends' :
    \       ['vim-scripts/Align']
    \   }

" == 4GVim {{{
NeoBundleLazy 'Shougo/vimshell'
NeoBundleLazy 'Color-Sampler-Pack'
NeoBundleLazy 'altercation/vim-colors-solarized'
NeoBundleLazy 'ujihisa/unite-colorscheme'
NeoBundleLazy 'ujihisa/unite-font'
" }}}

NeoBundle 'mattn/sonictemplate-vim'
NeoBundle 'Lokaltog/vim-powerline'

NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'motemen/hatena-vim'

NeoBundle 'osyo-manga/vim-watchdogs'
    \ , { 'depends' :
    \       [ 'Shougo/vimproc'
    \       , 'thinca/vim-quickrun'
    \       , 'osyo-manga/shabadou.vim'
    \       ]
    \   }

NeoBundle 'basyura/TweetVim'
    \ , { 'depends' :
    \       [ 'basyura/bitly.vim'
    \       , 'basyura/twibill.vim'
    \       , 'mattn/webapi-vim'
    \       , 'tyru/open-browser.vim'
    \       , 'Shougo/unite.vim'
    \       , 'h1mesuke/unite-outline'
    \       ]
    \   }

filetype plugin indent on

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif
"}}}

"Bram氏の提供する設定例をインクルードしない。Kaoriya版用
let g:no_vimrc_example = 1

"
" common settings
"
"
set visualbell t_vb=
set virtualedit=block

" have to set, before setting colorscheme-command
set t_Co=256

set directory=~/.vimcache/vimswap
set backupdir=~/.vimcache/bak
set viminfo+=n~/.vimcache/viminfo

" settings for infer encoding and formats
set encoding=utf-8 "WindowsだとCygwin以外で問題でるかも? でも使わないので問題なし
set fileencodings=ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,utf-16,utf-16le
set fileformats=unix,dos,mac

" set fold line on {{{, }}}
set foldmethod=marker
set foldenable
"set foldmarker={{{,}}}
"set foldcolumn=3

set list
set listchars=tab:>-,trail:~

set cursorline

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

" ignore white space, show match lines,
set diffopt=iwhite,filler

" }}}

" ======== Key Mapping ======== {{{
" ---- nomal mode ----{{{
"<NPA> means to unset command on keymap
nnoremap q: <NOP>
":はコマンドモードへの移行、;はfind時に次の該当単語へジャンプする
nnoremap ; :
nnoremap : ;
nnoremap <Backspace> :%s/

nnoremap Y y$
" xで削除した文字はblack holeに行ってもらう
nnoremap x "_x
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

if has('path_extra')
    set tags+=.tags;
endif

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

command! DeleteWhite call s:DeleteTrailingSpaces()
function! s:DeleteTrailingSpaces()
    let l:l = line('.')
    let l:c = col('.')
    %s/\s*$//g
    nohl
    call cursor(l, c)
endfunction

command! TabExpand call s:Tab2Space()
function! s:Tab2Space()
    let l:l = line('.')
    let l:c = col('.')
    "ts=tabの見た目上の幅, softtabstop=expandtab::enableのときにTabを押した時に挿入される空白の量
    let l:ts_value = &tabstop
    let l:tmp_space = ' '
    for i in range(0, ts_value)
        let l:tmp_space = tmp_space.' '
    endfor
    execute '%s/\t/'.tmp_space.'/g'
    nohl
    call cursor(l, c)
endfunction

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
" アンダーバーを区切りとした曖昧検索
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
augroup SetOmniCompletionSetting
    autocmd!
" Jediと競合するのでいらない
"    autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php        setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType c          setlocal omnifunc=ccomplete#Complete
    autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete
augroup END

" Enable heavy omni completion, which require computational power and may stall the vim.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" clang {{{
" via - http://d.hatena.ne.jp/osyo-manga/20120911/1347354707
" neocomplcache 側の設定
let g:neocomplcache_force_overwrite_completefunc=1

if !exists("g:neocomplcache_force_omni_patterns")
    let g:neocomplcache_force_omni_patterns = {}
endif

" omnifunc が呼び出される場合の正規表現パターンを設定しておく
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|::'

" clang_complete 側の設定
" clang_complete の自動呼び出しは必ず切っておく
let g:clang_complete_auto=0
" }}}

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


""タグ補完
""タグファイルの場所
"augroup SetTagsFile
"  autocmd!
"  autocmd FileType php set tags=$HOME/.vim/tags/php.tags
"augroup END

"zencoding連携
let g:use_zen_complete_tag = 1

"キャッシュディレクトリの場所を指定
"Linuxはどうしよう
if has('macunix')
    let g:neocomplcache_temporary_dir = '/Volumes/RamDisk/.neocon'
    let g:unite_data_directory = '/Volumes/RamDisk/.unite'
    let g:vimfiler_data_directory = '/Volumes/RamDisk/.vimfiler'
"else
"    let g:neocomplcache_temporary_dir = '/tmp/.neocon'
endif

"============================================================
" ---- neosnippet : {{{

" tell neosnippet about my snippets
let g:neosnippet#snippets_directory = '~/.vim/snippets,~/.vim/.bundle/snipmate-snippets/snippets'

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

" via: http://www.karakaram.com/vimfiler
" ---------Unite.vim--------- {{{
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
au FileType unite nnoremap <silent> <buffer> <esc><esc> <esc>:q<CR>
au FileType unite inoremap <silent> <buffer> <esc><esc> <esc>:q<CR>

"}}}

" ------------- VimFiler ------------------"{{{
" use Vimfiler as default instead of netrw
let g:vimfiler_as_default_explorer =  1
" Enable file operation commands.
let g:vimfiler_safe_mode_by_default = 1
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
nnoremap <silent> ,vf :<C-u>VimFiler -buffer-name=explorer -split -winwidth=35 -toggle -no-quit<CR>
"autocmd! FileType vimfiler call g:my_vimfiler_settings()
"function! g:my_vimfiler_settings()
"    nmap <buffer><expr><Cr> vimfiler#smart_cursor_map
"}}}


" --- quickrun -----{{{
" url:http://d.hatena.ne.jp/osyo-manga/20111014/1318586711

if !exists("g:quickrun_config")
    let g:quickrun_config={}
endif

" default via http://d.hatena.ne.jp/osyo-manga/20120919/1348054752
let g:quickrun_config["_"] = {
            \ "hook/close_unite_quickfix/enable_hook_loaded" : 1,
            \ "hook/unite_quickfix/enable_failure" : 1,
            \ "hook/close_quickfix/enable_exit" : 1,
            \ "hook/close_quickfix/enable_success" : 1,
            \ "hook/close_buffer/enable_failure" : 1,
            \ "hook/close_buffer/enable_empty_data" : 1,
            \ "outputter" : "multi:buffer:quickfix",
            \ "hook/shabadoubi_touch_henshin/enable" : 1,
            \ "hook/shabadoubi_touch_henshin/wait" : 20,
            \ "outputter/buffer/split" : ":botright 8sp",
            \ "runner" : "vimproc",
            \ "runner/vimproc/updatetime" : 40,
            \
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

"--- ack.vim procとか ---  {{{
"そろそろ限界…今後はOSごとに別ファイルでやったほうがよいかも
"for debian /ubuntu
if has('win32')
    let g:vimproc_dll_path = $HOME."/vimfiles/autoload/vimproc_win32.dll"
elseif has('mac')
    let g:vimproc_dll_path = $HOME."/.vim/.bundle/vimproc/autoload/vimproc_mac.so"
else
    let g:vimproc_dll_path = $HOME."/.vim/.bundle/vimproc/autoload/vimproc_unix.so"
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif
"}}}

" ------ TweetVim {{{
let g:tweetvim_async_post = 1
let g:tweetvim_tweet_per_page = 20
let g:tweetvim_cache_size = 30
"let g:tweetvim_footer = ''
let g:tweetvim_say_insert_account = 1
nnoremap <UP> <Plug>(tweetvim_action_page_next)
nnoremap <Down> <Plug>(tweetvim_action_page_previous)

nnoremap <silent> ,tv :<C-u>TweetVimHomeTimeline<CR>
nnoremap <silent> ,tm :<C-u>TweetVimMentions<CR>
nnoremap <silent> ,tp :<C-u>TweetVimSay<CR>
" }}}
