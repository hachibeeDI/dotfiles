
" completions {{{
" TODO: neobundle#hooks.on_source = 'dir/to/rcfile' 方式に書き換える
if g:neobundle#tap('neocomplete.vim')
  " {{{
  let g:acp_enableAtStartup = 0

  function! g:neobundle#hooks.on_source(bundle)
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1

    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    "" default
    "let g:neocomplete#auto_completion_start_length = 2
    "" Set minimum syntax keyword length. default is 4
    "let g:neocomplete#sources#syntax#min_keyword_length = 4
    let g:neocomplete#skip_auto_completion_time = '0.5'
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
    \     'default': '',
    \     'java': $HOME.'/.vim/dict/java.dict',
    \     'javascript': $HOME.'/.vim/dict/javascript.dict',
    \     'typescript': $HOME.'/.vim/dict/javascript.dict',
    \     'coffee': $HOME.'/.vim/dict/javascript.dict',
    \     'python': $HOME.'/.vim/dict/python.dict',
    \     'vim': $HOME.'/.vim/dict/vim.dict',
    \     'cpp': $HOME.'/.vim/dict/cpp.dict',
    \     'vimshell': $HOME.'/.vimshell_hist',
    \     'scheme': $HOME.'/.gosh_completions',
    \     'scala': $HOME.'/.neobundle/vim-scala/dict/scala.dict',
    \     'php': $HOME.'/.vim/dict/php.dict',
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

    inoremap <expr> <CR> pumvisible() ?
    \     neocomplete#close_popup() : "\<CR>"
  " \     neocomplete#close_popup() : "\<Plug>(smartinput_CR)"

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " imap <expr><C-h> neocomplete#smart_close_popup()."\<Plug>(smartinput_C-h)"
    " imap <expr><BS> neocomplete#smart_close_popup()."\<Plug>(smartinput_C-h)"

    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e> pumvisible() ? neocomplete#cancel_popup() : "\<End>"

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    "imap <expr> `  pumvisible() ?
    "      \ "\<Plug>(neocomplete_start_unite_quick_match)" : '`'
    " }}}
    "

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.php =
  		\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
    let g:neocomplete#sources#omni#input_patterns.haxe = '\v([\]''"\)]|\w|(^\s*))(\.|\()'
    " let g:neocomplete#sources#omni#input_patterns.python = '[^. \t]\.\w*'
    let g:neocomplete#sources#omni#input_patterns.go = '\h\w*\.\?'
    let g:neocomplete#sources#omni#input_patterns.c =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#sources#omni#input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    let g:neocomplete#sources#omni#input_patterns.objc =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#sources#omni#input_patterns.objcpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

    " -----------------------------------------------
    " ---  NOTE: some of filetype specific settings is in
    " ---  $HOME/.vim/after/ftplugin/*.vim .
    " ex. setlocal omnifunc * ... ...
    " -----------------------------------------------

    " ================ force omni patterns ======
    let g:neocomplete#force_overwrite_completefunc = 1
    " NOTE: this fearture is heavy.
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    "let g:neocomplete#force_omni_input_patterns.ruby =
    "\ '[^. *\t]\.\w*\|\h\w*::'
    let g:neocomplete#force_omni_input_patterns.haxe =
    \ '\v([\]''"\)]|\w|(^\s*))(\.|\()'
    let g:neocomplete#force_omni_input_patterns.c =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#force_omni_input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    "let g:neocomplete#force_omni_input_patterns.objc =
    "\ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    "let g:neocomplete#force_omni_input_patterns.objcpp =
    "\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

    " let g:neocomplete#sources#omni#input_patterns.typescript = '\h\w*\|[^. \t]\.\w*'

    " customize sort complete candiates
    " call neocomplete#custom#source('_', 'sorters', ['sorter_length'])
  endfunction
  " }}}

  call g:neobundle#untap()
end


if g:neobundle#tap('neocomplete-ios-dictionary')
  function! g:neobundle#hooks.on_source(bundle)
    call g:neocomplete_ios_dictionary#configure_ios_dict()
  endfunction
  call g:neobundle#untap()
end


if g:neobundle#tap('clang_complete')
  " neocomplcacheとの競合を避けるため、自動呼び出しはOff
  let g:clang_complete_auto = 0
  let g:clang_auto_select = 0
  let g:clang_hl_errors = 0
  "let g:clang_snippets = 'clang_complete'
  "libclangを使う
  let g:clang_use_library = 1
  if g:is_mac
    let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
  endif
  call g:neobundle#untap()
end


if g:neobundle#tap('neosnippet')
  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1
  " tell neosnippet about my snippets
  let g:neosnippet#snippets_directory = '~/.vim/snippets'

  " plugin key-mappings.
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
  autocmd MyAutoCmd InsertLeave * :NeoSnippetClearMarkers

  call g:neobundle#untap()
end

" }}}


if g:neobundle#tap('vimfiler')
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
end


if g:neobundle#tap('vimshell')
  " This go along with vimshell doc's sample.
  " My purpose of using VimShell is lessen stress of Windows and its terrible terminal-emulator!
  function! g:neobundle#hooks.on_source(bundle)
    if has('win32') || has('win64')
      " Display user name on Windows.
      let g:vimshell_prompt = $USERNAME.'% '
    else
      " Display user name on Linux.
      let g:vimshell_prompt = $USER.'% '

      call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
      call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
      let g:vimshell_execute_file_list['zip'] = 'zipinfo'
      call vimshell#set_execute_file('tgz,gz', 'gzcat')
      call vimshell#set_execute_file('tbz,bz2', 'bzcat')
    endif

    let g:vimshell_user_prompt = 'fnamemodify(getcwd(),":~")'
    " let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
  endfunction

  nnoremap <silent> ,vp :<C-u>VimShellPop<CR>
  nnoremap <silent> ,cvp :<C-u>VimShellPop %:p:h<CR>
  nnoremap <silent> ,cvs :<C-u>VimShell %:p:h<CR>
  call g:neobundle#untap()
end


if g:neobundle#tap('unite.vim')
  " buffer local keymap is in s:MY_VIMRUNTIME/after/ftplugin/unite.vim
  function! g:neobundle#hooks.on_source(bundle)
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

    " menu for git {{{
    let g:unite_source_menu_menus = {}
    let g:unite_source_menu_menus.git = {
      \ 'description' : '            gestionar repositorios git
          \                            ⌘ [espacio]g',
      \}
    let g:unite_source_menu_menus.git.command_candidates = [
      \['▷ tig                                                        ⌘ ,gt',
          \'normal ,gt'],
      \['▷ git status       (Fugitive)                                ⌘ ,gs',
          \'Gstatus'],
      \['▷ git diff         (Fugitive)                                ⌘ ,gd',
          \'Gdiff'],
      \['▷ git commit       (Fugitive)                                ⌘ ,gc',
          \'Gcommit'],
      \['▷ git log          (Fugitive)                                ⌘ ,gl',
          \'exe "silent Glog | Unite quickfix"'],
      \['▷ git blame        (Fugitive)                                ⌘ ,gb',
          \'Gblame'],
      \['▷ git stage        (Fugitive)                                ⌘ ,gw',
          \'Gwrite'],
      \['▷ git checkout     (Fugitive)                                ⌘ ,go',
          \'Gread'],
      \['▷ git rm           (Fugitive)                                ⌘ ,gr',
          \'Gremove'],
      \['▷ git mv           (Fugitive)                                ⌘ ,gm',
          \'exe "Gmove " input("destino: ")'],
      \['▷ git push         (Fugitive, salida por buffer)             ⌘ ,gp',
          \'Git! push'],
      \['▷ git pull         (Fugitive, salida por buffer)             ⌘ ,gP',
          \'Git! pull'],
      \['▷ git prompt       (Fugitive, salida por buffer)             ⌘ ,gi',
          \'exe "Git! " input("comando git: ")'],
      \['▷ git cd           (Fugitive)',
          \'Gcd'],
      \]
    " }}}
  endfunction
  call g:neobundle#untap()
end


if g:neobundle#tap('vim-quickrun')
  " {{{
  " url:http://d.hatena.ne.jp/osyo-manga/20111014/1318586711
  function! g:neobundle#hooks.on_source(bundle)
    " default config via http://d.hatena.ne.jp/osyo-manga/20120919/1348054752
    let g:quickrun_config = {
    \    '_': {
    \      'hook/close_buffer/enable_empty_data': 1
    \      , 'hook/inu/enable': 1
    \      , 'hook/inu/wait': 20
    \      , 'outputter/buffer/split': ':botright 8sp'
    \      , 'outputter/error/error': 'quickfix'
    \      , 'outputter/error/success': 'buffer'
    \      , 'runner': 'vimproc'
    \      , 'runner/vimproc/updatetime': 40
    \    },
    \    'run/vimproc': {
    \      'exec': '%s:p:r %a'
    \      , 'output_encode': 'utf-8'
    \      , 'runner': 'vimproc'
    \      , 'outputter': 'buffer'
    \    },
    \    'run/vimproc/pause': {
    \      'exec': '%s:p:r %a && pause'
    \      , 'output_encode': 'utf-8'
    \      , 'runner': 'shell'
    \      , 'outputter': 'buffer'
    \    },
    \    'run/system': {
    \      'exec': '%s:p:r %a'
    \      , 'output_encode': 'utf-8'
    \      , 'runner': 'system'
    \      , 'outputter': 'buffer'
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
    \    'watchdogs_checker/go_build': {
    \      'command': 'go'
    \      , 'exec': '%c build %s:p'
    \      , 'quickfix/errorformat': '%f:%l:%m'
    \    },
    \    'go/watchdogs_checker': {
    \      'type': 'watchdogs_checker/go_build'
    \    },
    \   'vim/watchdogs_checker': {
    \     'type': executable('vint') ? 'watchdogs_checker/vint' : '',
    \   },
    \   'watchdogs_checker/vint': {
    \     'command'   : 'vint',
    \     'exec'      : '%c %o %s:p ',
    \   },
    \   'sh/watchdogs_checker': {
    \     'type': executable('shellcheck') ? 'watchdogs_checker/shellcheck' : '',
    \   },
    \   'ruby/watchdogs_checker': {
    \     'type': executable('rubocop') ? 'watchdogs_checker/rubocop' : 'watchdogs_checker/ruby',
    \   },
    \   'watchdogs_checker/shellcheck': {
    \     'command'   : 'shellcheck',
    \     'cmdopt': '-f gcc',
    \     'exec'      : '%c %o %s:p ',
    \   },
    \ }
    " }}}

    if g:neobundle#tap('vim-watchdogs')
      " < http://d.hatena.ne.jp/osyo-manga/20120924/1348473304
      call watchdogs#setup(g:quickrun_config)
      " 書き込み後にシンタックスチェックを行うかどうか
      let g:watchdogs_check_BufWritePost_enable = 1
      nnoremap <SID>[Show]w :<C-u>WatchdogsRunSilent<CR><Esc>
      autocmd MyAutoCmd BufWritePost .vimrc,*.vim WatchdogsRunSilent
    end
  endfunction

  let g:quickrun_no_default_key_mappings = 1
  "nmap <F5> <Plug>(quickrun)
  nmap <Leader>q <Plug>(quickrun)
  nmap ,q <Plug>(quickrun-op)
  call g:neobundle#untap()
end




if g:neobundle#tap('vim-rooter')
  map <silent> <unique> <Leader>cd <Plug>RooterChangeToRootDirectory
  let g:rooter_patterns = ['.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', 'Rakefile', 'Gruntfile.js', 'Gruntfile.coffee']
  call g:neobundle#untap()
end


if g:neobundle#tap('vim-operator-replace')
  map r <Plug>(operator-replace)
  call g:neobundle#untap()
end


if g:neobundle#tap('vim-operator-comment')
  map M <Plug>(operator-uncomment)
  map m <Plug>(operator-comment)
  call g:neobundle#untap()
end


if g:neobundle#tap('vim-operator-surround')
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
  call g:neobundle#untap()
end


if g:neobundle#tap('vim-operator-autopep8')
  map ,p <Plug>(operator-autopep8)
  call g:neobundle#untap()
end


if g:neobundle#tap('vim-textobj-multiblock')
  omap ab <Plug>(textobj-multiblock-a)
  vmap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  vmap ib <Plug>(textobj-multiblock-i)
  call g:neobundle#untap()
end


if g:neobundle#tap('vim-textobj-between')
  omap a_ <Plug>(textobj-between-a)
  xmap a_ <Plug>(textobj-between-a)
  omap i_ <Plug>(textobj-between-i)
  xmap i_ <Plug>(textobj-between-i)
  call g:neobundle#untap()
end


if g:neobundle#tap('python_hl_lvar.vim')
  let g:enable_python_hl_lvar = 1
  let g:python_hl_lvar_highlight_color = 'guifg=palegreen2 gui=NONE ctermfg=110 cterm=NONE'
  "let g:python_hl_lvar_verbose = 1  for debug
  autocmd MyAutoCmd BufWinEnter  *.py PyHlLVar
  autocmd MyAutoCmd BufWinLeave  *.py PyHlLVar
  autocmd MyAutoCmd WinEnter     *.py PyHlLVar
  autocmd MyAutoCmd BufWritePost *.py PyHlLVar
  autocmd MyAutoCmd WinLeave     *.py PyHlLVar
  autocmd MyAutoCmd TabEnter     *.py PyHlLVar
  autocmd MyAutoCmd TabLeave     *.py PyHlLVar
  call g:neobundle#untap()
end


if g:neobundle#tap('vim-go') && executable('go')
  let g:go_bin_path = expand('~/.go/bin')
  let g:go_fmt_fail_silently = 1
  let g:go_fmt_autosave = 1
  " let g:go_disable_autoinstall = 1
  let g:go_snippet_engine = 'neosnippet'

  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1

  au FileType go nmap <leader>r <Plug>(go-run)
  au FileType go nmap <leader>b <Plug>(go-build)
  au FileType go nmap <leader>t <Plug>(go-test)
  au FileType go nmap <leader>c <Plug>(go-coverage)

  au FileType go nmap <Leader>ds <Plug>(go-def-split)
  au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)

  au FileType go nmap <Leader>e <Plug>(go-rename)

  call g:neobundle#untap()
end


if executable('haxe')
  if g:neobundle#tap('vaxe')
    function! g:neobundle#hooks.on_source(bundle)
      let g:vaxe_default_parent_search_patterns = ['project.xml', '*.nmml', 'build.hxml']
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

      "autocmd MyAutoCmd FileType haxe  # move $HOME/.vim/after/ftplugin/haxe.vim
      "      \ setl autowrite
      autocmd MyAutoCmd FileType hxml
            \ setl autowrite
      autocmd MyAutoCmd FileType nmml.xml
            \ setl autowrite
    endfunction
    call g:neobundle#untap()
  end

  " if g:neobundle#tap('unite-vaxe')
  "   call g:neobundle#untap()
  " end
end



if g:neobundle#tap('jedi-vim')
  function! g:neobundle#hooks.on_source(bundle)
    let g:jedi#squelch_py_warning = 1

    " do not allow set some configure auto.
    let g:jedi#auto_vim_configuration = 0

    let g:jedi#use_tabs_not_buffers = 1
    " neocomplcacheとコンフリクトを起こすので無効にしておく
    let g:jedi#completions_enabled = 0
    let g:jedi#popup_on_dot = 0
    let g:jedi#popup_select_first = 0
    let g:jedi#show_call_signatures = '1'

    " command mappings
    let g:jedi#goto_assignments_command = '<leader>g'
    let g:jedi#goto_definitions_command = '<leader>d'
    let g:jedi#documentation_command = 'K'
    let g:jedi#rename_command = '<leader>r'
    let g:jedi#usages_command = '<leader>n'
    let g:jedi#completions_command = '<C-Space>'
  endfunction
  call g:neobundle#untap()
end

if g:neobundle#tap('yankround.vim')
  nmap p <Plug>(yankround-p)
  xmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap gp <Plug>(yankround-gp)
  xmap gp <Plug>(yankround-gp)
  nmap gP <Plug>(yankround-gP)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
  nnoremap <silent> <C-y> :<C-u>Unite yankround<CR>
  call g:neobundle#untap()
end



if g:neobundle#tap('lexima.vim')
  " {{{
  " NOTE: http://secret-garden.hatenablog.com/entry/2015/05/06/211712 がいけてたのでleximaに乗り換え実験
  let s:bundle = g:neobundle#get('lexima.vim')
  function! s:bundle.hooks.on_source(bundle)
    let g:lexima_no_default_rules = 1
    call g:lexima#set_default_rules()

    let s:defailt_ignore_rule = {'syntax': ['String', 'Comment']}

    function! s:as_list(a)
        return type(a:a) == type([]) ? a:a : [a:a]
    endfunction

    function! s:add_ignore_rule(rule)
        let l:cp_rule = copy(a:rule)
        let l:cp_rule.input = l:cp_rule.char
        call filter(l:cp_rule, 'v:key != "input_after" || v:key != "leave" || v:key != "delete"')
        let l:cp_rule.priority = 999
        call g:lexima#add_rule(l:cp_rule)
    endfunction


    function! s:add_rule_with_ignores(rule, ...)
        call g:lexima#add_rule(a:rule)
        if a:0 == 0
            return
        endif

        for l:ignore in s:as_list(a:1)
            call s:add_ignore_rule(extend(copy(a:rule), l:ignore))
        endfor
    endfunction


    for [l:begin, l:end] in [['(', ')'], ['{', '}'], ['[', ']']]
        let l:bracket = l:begin.end
        call s:add_rule_with_ignores({'at': '\%#',       'char': l:begin, 'input': l:begin, 'input_after': l:end}, s:defailt_ignore_rule)
        call s:add_rule_with_ignores({'at': '\%#'.l:end, 'char': l:begin, 'input': l:begin}, s:defailt_ignore_rule)

        " TODO: inputが空の状態でleaveは効かない？ はっきりしたらissueを出そう
        " call s:add_rule_with_ignores({'at': l:begin.'\%#'.l:end, 'char': l:end, 'leave': 1}, s:defailt_ignore_rule)
        call s:add_rule_with_ignores({'at':         '\%#'.l:end, 'char': l:end, 'input': '<Right>'}, s:defailt_ignore_rule)

        call s:add_rule_with_ignores({'at': l:begin.'\%#'.l:end, 'char': l:begin, 'input': l:begin, 'input_after': l:end}, s:defailt_ignore_rule)
        call s:add_rule_with_ignores({'at': l:begin.'\%#'.l:end, 'char': '<BS>', 'input': '<BS>', 'delete': 1}, s:defailt_ignore_rule)
    endfor


    let s:template_filetypes = ['rst', 'markdown', 'html', 'xml', 'css', 'sass', 'scss', 'stylus', 'bash', 'clojure', ]
    for l:opr in ['+', '-', '=', '*']
      call s:add_rule_with_ignores(
            \ {'at': '\%#',               'char': l:opr, 'input': '<Space>'.l:opr.'<Space>'},
            \ {'filetype': s:template_filetypes},
            \ s:defailt_ignore_rule)
      " BSした時に両端のスペースを消すやつ
      call s:add_rule_with_ignores(
            \ {'at': ' '.l:opr.' \%#',    'char': '<BS>', 'input': '<BS><Left><BS>', 'leave': 1},
            \ {'filetype': s:template_filetypes},
            \ s:defailt_ignore_rule)

      call s:add_rule_with_ignores(
            \ {'at': '\%# '.l:opr.' ',    'char': '<Del>', 'input': '<Del><Right><Del><Left>'},
            \ {'filetype': s:template_filetypes},
            \ s:defailt_ignore_rule)
    endfor

    call s:add_rule_with_ignores({'at': '=\%#',   'char': '=', 'input': '='}, {'filetype': s:template_filetypes})
    call s:add_rule_with_ignores({'at': ' = \%#', 'char': '=', 'input': '<Left>='}, {'filetype': s:template_filetypes})
    call s:add_rule_with_ignores({'at': ' = \%#', 'char': '<BS>', 'input': '<BS><Left><BS><Right>'}, {'filetype': s:template_filetypes})

    call g:lexima#add_rule({
    \   'at'       : '\s===\s\%#',
    \   'char'     : '<BS>',
    \   'input'    : '<Left><BS><Right>',
    \   })
    call g:lexima#add_rule({
    \   'at'       : '\s==\s\%#',
    \   'char'     : '<BS>',
    \   'input'    : '<Left><BS><Right>',
    \   })
    call s:add_rule_with_ignores({
    \   'at'       : '\\\%#',
    \   'char'     : '\',
    \   'input'    : '<BS> => ',
    \   'filetype': ['javascript', 'typescript', ],
    \   }, s:defailt_ignore_rule)


    " smartinputとsmartchrの連携tips
    "  -> [http://ac-mopp.blogspot.jp/2013/07/vim-smart-input.html]

    "     Note: that only "wide" syntax items are effective.  In other words,
    "     syntax items which is linked to another is not effective, and they
    "     will never be matched.  For example:
    " map(synstack(line('.'), col('.')), 'synIDattr(synIDtrans(v:val), "name")')
    " で得られるSyntax名のみ
    " TODO: synIDattr(synID(line('.'), col('.'), 0), 'name') ではだめなのかな

    "" via: http://rhysd.hatenablog.com/entry/20121017/1350444269
    call g:lexima#add_rule({
    \   'at': '\s\+\%#$',
    \   'char': '<CR>',
    \   'input': "<C-o>:call setline('.', substitute(getline('.'), '\\s\\+$', '', ''))<CR><CR>",
    \   })

    call g:lexima#add_rule({
    \   'at'       : '\%(\<struct\>\|\<class\>\|\<enum\>\)\s*\w\+.*\%#',
    \   'char'     : '{',
    \   'input'    : '{};<Left><Left>',
    \   'filetype' : ['cpp'],
    \   })

    " html and markdown like that -----
    call g:lexima#add_rule({
    \   'at': '\%#',
    \   'char': '<',
    \   'input': '<><Left>',
    \   'filetype': ['xml', 'html', 'eruby'],
    \ })
    " 前が空白以外なら型パラメータ、空白なら演算子だと考えさせる
    call g:lexima#add_rule({
    \   'at': '[^[:blank:]]\%#',
    \   'char': '<',
    \   'input': '<><Left>',
    \   'filetype': ['java', 'cpp', 'cs', 'haxe'],
    \ })
    call g:lexima#add_rule({
    \   'at': '[:blank:]\%#',
    \   'char': '<',
    \   'input': "<C-R>=smartchr#one_of('< ', '<')<CR>",
    \   'filetype': ['java', 'cpp', 'cs', 'haxe'],
    \ })

    call g:lexima#add_rule({
    \   'at': '<\%#>',
    \   'char': '<BS>',
    \   'input': '<Del><BS>',
    \   'filetype': ['xml', 'html', 'eruby', 'java', 'cpp', 'cs', 'haxe'],
    \ })

    call g:lexima#add_rule({
    \   'at': '<.*\%#>',
    \   'char': '>',
    \   'input': '<Right>',
    \   'filetype': ['xml', 'html', 'eruby', 'java', 'cpp', 'cs', 'haxe'],
    \ })

    " セミコロンを要求するうんこシンタックス対応 {{{
    call g:lexima#add_rule({
    \   'at': '\%#;$',
    \   'char': ';',
    \   'input': '<Right>',
    \   'filetype': ['java', 'cpp', 'cs', 'haxe', 'javascript', 'jsx'],
    \ })
    call g:lexima#add_rule({
    \   'at': '\%#;$',
    \   'char': '<CR>',
    \   'input': '<Right><CR>',
    \   'filetype': ['java', 'cpp', 'cs', 'haxe', 'javascript', 'jsx'],
    \ })
    call g:lexima#add_rule({
    \   'at': '(\%#;$',
    \   'char': '<CR>',
    \   'input': ')<Left><CR><BS><CR><Up><End><Tab>',
    \   'filetype': ['java', 'cpp', 'cs', 'haxe', 'javascript', 'jsx'],
    \ })
    " }}}

    " ERB
    call g:lexima#add_rule({
    \   'at': '<\%#',
    \   'char': '%',
    \   'input': '%%<Left>',
    \   'filetype': ['eruby'],
    \ })
    call g:lexima#add_rule({
    \   'at': '%.*\%#%',
    \   'char': '%',
    \   'input': '',
    \   'filetype': ['eruby'],
    \ })

    " Golang {{{

    call g:lexima#add_rule({
    \   'at': '[^[:alnum:]]json\%#',
    \   'char': ':',
    \   'input': '""<Left>',
    \ })
    " }}}
    "
    " omni rules
    let s:filetypes_with_omnifunc = ['python', 'typescript', 'javascript', 'go']
    call s:add_rule_with_ignores({
    \   'at' : '\w\%#',
    \   'char': '.',
    \   'input': '.<C-x><C-o><C-p>',
    \   'filetype': s:filetypes_with_omnifunc,
    \ },
    \ s:defailt_ignore_rule
    \ )


    if g:neobundle#tap('smartinput-patterns')
      call lexima_patterns#init()
    endif

  endfunction
  "}}}
  call g:neobundle#untap()
end
