"
" Vundle's settings
"
"--- common settings ----
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"-------------------------
"------- set plugins -------
"Bundle 'Shougo/vimproc'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/neocomplcache'
Bundle 'thinca/vim-quickrun'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'trailing-whitespace'
Bundle 'The-NERD-tree'
Bundle 'reinh/vim-makegreen'
Bundle 'h1mesuke/unite-outline'

filetype plugin indent on

"
" common settings
"
"
set clipboard=unnamed,autoselect

set vb t_vb=

set directory=~/vimswap

set paste

" enable hjkl on INSERT-MODE
imap <C-j><Down>
imap <C-k><Up>
imap <C-l><Right>
imap <C-h><Left>


"" clipboard use in OS
"set clipboard+=unnamed

" set PEP8 Style
set autoindent
set smarttab
set cindent

set foldlevel=99

"___________
" indent
"---------
"
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab



"-----
" search settings
"------
"
set history=100


"--------
" display settings
"---------
"
"colorscheme anotherdark
colorscheme solarized
set background=dark
"set transparency=50
set title
set number

set guifont=inconsolata:h14
set guifontwide=Osaka-Mono:h12

"nmap + :set transparency+=5<CR>
"nmap - :set transparency-=5<CR>

set showcmd
set laststatus=2

syntax on
set hlsearch
highlight Comment ctermfg=LightGreen

set wildmenu

set textwidth=90
set colorcolumn=80
set wrap

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/


"" from  expart Python
set incsearch
set ignorecase
set ruler
set wildmenu
set commentstring=\ #\ %s
set foldlevel=0

"-------------
" plugin
"---------------
"


"" neocomplcache
let g:neocomplcache_enable_at_startup = 1   " enabled when start vim 
let g:neocomplcache_max_list = 30
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_enable_smart_case = 1
"" like AutoComplPop
let g:neocomplcache_enable_auto_select = 1
"" search with camel case like Eclipse
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
"imap <C-k> <Plug>(neocomplcache_snippets_expand)
"smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
"" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"" <CR>: close popup and save indent.
"inoremap <expr><CR> neocomplcache#smart_close_popup() . (&indentexpr != '' ? "\<C-f>\<CR>X\<BS>":"\<CR>")
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

"Define dictonaru
let g:neocomplcache_dictionary_filetype_lists={
\'default':'',
\'java':$HOME.'/.vim/dict/java.dict',
\'javascript':$HOME.'/.vim/dict/javascript.dict',
\'python':$HOME.'/.vim/dict/python.dict',
\'vim':$HOME.'/.vim/dict/vim.dict'
\}


let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2 
let g:indent_guides_color_change_percent=20

" Unite.vim

""" unite.vim
" 入力モードで開始する
" let g:unite_enable_start_insert=1
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
