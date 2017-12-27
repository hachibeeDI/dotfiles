" If there is vimfiler, disable netrw
let g:loaded_netrwPlugin = 1
" do not show note
let g:netrw_localcopycmd=''

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
endif


if g:neobundle#tap('neocomplete-ios-dictionary')
  function! g:neobundle#hooks.on_source(bundle)
    call g:neocomplete_ios_dictionary#configure_ios_dict()
  endfunction
  call g:neobundle#untap()
endif


if g:neobundle#tap('clang_complete')
  if g:is_mac
    let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
  endif
  call g:neobundle#untap()
endif


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
endif

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
endif

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
  endif

  " if g:neobundle#tap('unite-vaxe')
  "   call g:neobundle#untap()
  " endif
endif



if g:neobundle#tap('lexima.vim')
  " {{{
  " NOTE: http://secret-garden.hatenablog.com/entry/2015/05/06/211712 がいけてたのでleximaに乗り換え実験
  let s:bundle = g:neobundle#get('lexima.vim')
  function! s:bundle.hooks.on_source(bundle)
    let g:lexima_no_default_rules = 1
    call g:lexima#set_default_rules()

    let s:default_ignore_rule = {'syntax': ['String', 'Comment', 'xmlString', 'xmlAttrib', 'xmlTagName', 'jsxRegion']}

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
        call s:add_rule_with_ignores({'at': '\%#',       'char': l:begin, 'input': l:begin, 'input_after': l:end}, s:default_ignore_rule)
        call s:add_rule_with_ignores({'at': '\%#'.l:end, 'char': l:begin, 'input': l:begin}, s:default_ignore_rule)

        " TODO: inputが空の状態でleaveは効かない？ はっきりしたらissueを出そう
        " call s:add_rule_with_ignores({'at': l:begin.'\%#'.l:end, 'char': l:end, 'leave': 1}, s:default_ignore_rule)
        call s:add_rule_with_ignores({'at': '\%#'.l:end, 'char': l:end, 'input': '<Right>'}, s:default_ignore_rule)

        call s:add_rule_with_ignores(
        \  {'at': l:begin.'\%#'.l:end, 'char': l:begin, 'input': l:begin, 'input_after': l:end},
        \  s:default_ignore_rule
        \)
        call s:add_rule_with_ignores({'at': l:begin.'\%#'.l:end, 'char': '<BS>', 'input': '<BS>', 'delete': 1}, s:default_ignore_rule)
        call s:add_rule_with_ignores({'at': l:begin.'\%#'.l:end, 'char': '<Enter>', 'input': '<Enter><Enter><Up><Tab>'}, s:default_ignore_rule)
    endfor


    let s:ignore_for_operator = [
    \   s:default_ignore_rule,
    \   {'filetype': ['rst', 'markdown', 'html', 'jinja', 'json', 'yaml', 'xml', 'css', 'sass', 'scss', 'stylus', 'bash', 'clojure', 'gitcommit']}
    \]
    for l:opr in ['+', '-', '=', '*']
      call s:add_rule_with_ignores(
            \ {'at': '\%#',               'char': l:opr, 'input': '<Space>'.l:opr.'<Space>'},
            \ s:ignore_for_operator)

      " BSした時に両端のスペースを消すやつ
      call s:add_rule_with_ignores(
            \ {'at': ' '.l:opr.' \%#',    'char': '<BS>', 'input': '<BS><Left><BS>', 'leave': 1},
            \ s:ignore_for_operator)

      call s:add_rule_with_ignores(
            \ {'at': '\%# '.l:opr.' ',    'char': '<Del>', 'input': '<Del><Right><Del><Left>'},
            \ s:ignore_for_operator)
    endfor
    call g:lexima#add_rule({
    \   'at'       : ' - \%#',
    \   'char'     : '>',
    \   'input'    : '<BS>><Space>',
    \   })

    call s:add_rule_with_ignores({'at': '=\%#',   'char': '=', 'input': '='}, s:ignore_for_operator)
    call s:add_rule_with_ignores({'at': ' = \%#', 'char': '=', 'input': '<Left>=<Right>'}, s:ignore_for_operator)
    call s:add_rule_with_ignores({'at': ' = \%#', 'char': '<BS>', 'input': '<BS><Left><BS><Right>'}, s:ignore_for_operator)

    call g:lexima#add_rule({
    \   'at'       : '\s===\s\%#',
    \   'char'     : '<BS>',
    \   'input'    : '<Left><BS><Right>',
    \   })
    call g:lexima#add_rule({
    \   'at'       : '\s==\s\%#',
    \   'char'     : '=',
    \   'input'    : '<Left>=<Right><Right>',
    \   })
    call g:lexima#add_rule({
    \   'at'       : '\s==\s\%#',
    \   'char'     : '<BS>',
    \   'input'    : '<Left><BS><Right>',
    \   })
    call g:lexima#add_rule({
    \   'at'       : '\\\%#',
    \   'char'     : '\',
    \   'input'    : '<BS> => ',
    \   'filetype': ['javascript', 'typescript', 'javascript.jsx'],
    \   })
    call g:lexima#add_rule({
    \   'at'       : '\\\%#',
    \   'char'     : '\',
    \   'input'    : '<BS>lambda :<Left>',
    \   'filetype': ['python'],
    \   })

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
    \   'filetype': ['java', 'cpp', 'cs', 'haxe', 'javascript', 'javascript.jsx'],
    \ })
    call g:lexima#add_rule({
    \   'at': '\%#;$',
    \   'char': '<CR>',
    \   'input': '<Right><CR>',
    \   'filetype': ['java', 'cpp', 'cs', 'haxe', 'javascript', 'javascript.jsx'],
    \ })
    call g:lexima#add_rule({
    \   'at': '(\%#;$',
    \   'char': '<CR>',
    \   'input': ')<Left><CR><BS><CR><Up><End><Tab>',
    \   'filetype': ['java', 'cpp', 'cs', 'haxe', 'javascript', 'javascript.jsx'],
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
    let s:filetypes_with_omnifunc = ['python', 'typescript', 'javascript', 'javascript.jsx', 'go']
    call s:add_rule_with_ignores({
    \   'at' : '\w\%#',
    \   'char': '.',
    \   'input': '.<C-x><C-o><C-p>',
    \   'filetype': s:filetypes_with_omnifunc,
    \ },
    \ s:default_ignore_rule
    \ )
  endfunction
  "}}}
  call g:neobundle#untap()
endif
