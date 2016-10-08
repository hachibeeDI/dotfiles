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
let s:vimrc = '~/.vimrc'

let s:is_cygwin = has('win32unix')
let g:is_mac = has('mac') || has('macunix') || has('gui_macvim')

"set autogroup
augroup MyAutoCmd
  autocmd!
augroup END

" It should upgrade to Dein.vim soon
source ~/.vim/neobundle.bootstrap.vim

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

" .h で @interfaceのあるファイルをobjcppではなくobjcとして検出してくれる
" ($VIMRUNTIME/filetype.vim)
let g:c_syntax_for_h = 1

filetype plugin indent on
syntax enable

" vital.vim --- {{{
let g:Vit = vital#of('vital')
"call extend(s:, g:Vit, 'keep') " スクリプトローカルに展開したくなったら
call g:Vit.load('Data.List').load('Data.String').load('Math')
"}}}


source ~/.vim/common.rc.vim
if has('unix')
    set swapsync=
endif
" viminfo binary doesn't seems have compatility with plain vim
set viminfo& viminfo+=n~/.vimcache/viminfo


" 各コマンド後の結果をquickfixへ出力させる
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


autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
autocmd MyAutoCmd QuickfixCmdPost make call <SID>auto_ccl()
" qf系 -> $HOME/.vim/after/ftplugin/qf.vim
" make時に、shellに戻ったりとか余計な表示を出さない
nnoremap <silent> <leader>m :<C-u>silent make<CR>
" Auto-close if quickfix or quickrun window is only in buffer
autocmd MyAutoCmd WinEnter *
\   if (winnr('$') ==# 1) &&
\      (getbufvar(winbufnr(0), '&filetype')) =~? 'qf\|quickrun'
\         | quit | endif


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

" ==== View }}}

source ~/.vim/keymap.rc.vim

" ----------- operation

if has('path_extra')
  set tags& tags+=.tags,tags

  autocmd MyAutoCmd FileType coffee
      \ set tags+=$HOME/coffee.tags
  autocmd MyAutoCmd FileType python
      \ set tags+=$HOME/python.tags
endif


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
nnoremap <silent> <D-p> :<C-u>Unite file_rec/async:!<CR>

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
nnoremap <silent> <SID>[Unite]gg :<C-u>Unite giti<CR>
nnoremap <silent> <SID>[Unite]gs :<C-u>Unite giti/status<CR>
nnoremap <silent> <SID>[Unite]gb :<C-u>Unite giti/branch<CR>
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

  elseif l:lang ==# 'javascript' || l:lang ==# 'javascript.jsx'
    inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
    inoremap <buffer> <expr> -> smartchr#one_of('function', '=>')

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
