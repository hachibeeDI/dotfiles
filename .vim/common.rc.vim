filetype plugin indent on
syntax enable

let s:is_windows = has('win16') || has('win32') || has('win64')

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
set scrolloff=10
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
set undodir=~/.vimcache/undo
set undofile

" for snippet_complete marker
" conceal in insert (i), normal (n) and visual (v) modes
set conceallevel=2 concealcursor=inv
set colorcolumn=79

set relativenumber
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
set winheight=8
" disable auto comment when start a new line
set formatoptions& formatoptions-=ro


"--------
" display settings
"---------

" enable cursorline only focused buffer.
setlocal cursorline
autocmd MyAutoCmd WinEnter * setlocal cursorline
autocmd MyAutoCmd WinLeave * setlocal nocursorline

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

set showmode
set showcmd
" Height of command line.
set cmdheight=2

set title
" Title length.
set titlelen=95
set titlestring=Vim:\ %f\ %h%r%m

" ignore white space, show match lines,
set diffopt=iwhite,filler

set spelllang=en_us
if v:version >= 704
  set spelllang+=cjk
endif


" ---- search behavior ---- {{{
set incsearch
set ignorecase
set smartcase
set wrapscan
set hlsearch
" ------------ }}}

