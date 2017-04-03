" NeoVim specific settings

" FIXME: more generic way to set the path
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

source ~/.vim/environments.rc.vim

set termguicolors
"set autogroup
augroup MyAutoCmd
  autocmd!
augroup END

" It should upgrade to Dein.vim soon
source ~/.vim/neobundle.bootstrap.vim

source ~/.vim/common.rc.vim
set viminfo& viminfo+=n~/.vimcache/nviminfo

source ~/.vim/keymap.rc.vim
source ~/.vim/keymap.unite.vim
" source ~/.vim/keymap.unite.vim => denite {{{

" " Change file_rec command.
" call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Change mappings.
call denite#custom#map(
  \ 'insert',
  \ '<C-n>',
  \ '<denite:move_to_next_line>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<C-p>',
  \ '<denite:move_to_previous_line>',
  \ 'noremap'
  \)

" Change matchers.
call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source('file_mru', 'converters', ['converter_relative_word'])
call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
  \ ['.git/', '.ropeproject/', '__pycache__/', 'venv/', 'images/', '*.min.*', 'img/', 'fonts/',
  \  'node_modules/'
  \ ])

" " Add custom menus
" let s:menus = {}
"
" let s:menus.zsh = {
"         \ 'description': 'Edit your import zsh configuration'
"         \ }
" let s:menus.zsh.file_candidates = [
"         \ ['zshrc', '~/.config/zsh/.zshrc'],
"         \ ['zshenv', '~/.zshenv'],
"         \ ]
"
" let s:menus.my_commands = {
"         \ 'description': 'Example commands'
"         \ }
" let s:menus.my_commands.command_candidates = [
"         \ ['Split the window', 'vnew'],
"         \ ['Open zsh menu', 'Denite menu:zsh'],
"         \ ]
"
" call denite#custom#var('menu', 'menus', s:menus)
"
" " " Ack command on grep source
" " call denite#custom#var('grep', 'command', ['ack'])
" " call denite#custom#var('grep', 'recursive_opts', [])
" " call denite#custom#var('grep', 'final_opts', [])
" " call denite#custom#var('grep', 'separator', [])
" " call denite#custom#var('grep', 'default_opts',
" "                 \ ['--ackrc', $HOME.'/.ackrc', '-H',
" "                 \ '--nopager', '--nocolor', '--nogroup', '--column'])
" " " Ripgrep command on grep source
" " call denite#custom#var('grep', 'command', ['rg'])
" " call denite#custom#var('grep', 'recursive_opts', [])
" " call denite#custom#var('grep', 'final_opts', [])
" " call denite#custom#var('grep', 'separator', ['--'])
" " call denite#custom#var('grep', 'default_opts',
" "                 \ ['--vimgrep', '--no-heading'])
" "
"
"
nnoremap <SID>[Denite] <Nop>
nmap ,d <SID>[Denite]
" nnoremap <SID>[UMenu] <Nop>
" nmap [Denite]t <SID>[UMenu]
"
" nnoremap <silent>[UMenu]g :Denite -silent -start-insert menu:git<CR>
"
" バッファ一覧
nnoremap <silent> <SID>[Denite]b :<C-u>Denite buffer<CR>
"
" ファイル一覧
nnoremap <silent> <SID>[Denite]f :<C-u>DeniteBufferDir file_rec<CR>
" .gitを基準にしたプロジェクト一覧 (ctrlp的な)
nnoremap <silent> <SID>[Denite]p :<C-u>Denite `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
nnoremap <silent> <D-p>          :<C-u>Denite `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>

" " レジスタ一覧
" nnoremap <silent> <SID>[Denite]r :<C-u>Denite -buffer-name=register register<CR>
" " 最近使用したファイル一覧
nnoremap <silent> <SID>[Denite]m :<C-u>Denite file_mru<CR>
" " 常用セット
nnoremap <silent> <SID>[Denite]u :<C-u>Denite buffer file_mru<CR>
nnoremap <silent> <D-m>          :<C-u>Denite buffer file_mru<CR>
" " タブ一覧
" nnoremap <silent> <SID>[Denite]t :<C-u>Denite tab<CR>
" " 全部乗せ
" nnoremap <silent> <SID>[Denite]a :<C-u>DeniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
"
" " その他
" nnoremap <silent> <SID>[Denite]` :<C-u>Denite -auto-quit neobundle/update<CR>
" " Outline
" nnoremap <silent> <SID>[Denite]o :<C-u>Denite -vertical outline<CR>
" " grep
" nnoremap <silent> <SID>[Denite]gg :<C-u>Denite giti<CR>
" nnoremap <silent> <SID>[Denite]gs :<C-u>Denite giti/status<CR>
" nnoremap <silent> <SID>[Denite]gb :<C-u>Denite giti/branch<CR>
" " quickfix
" nnoremap <silent> <SID>[Denite]q :<C-u>Denite -no-quit -direction=botright quickfix
" " }}}

if exists('g:nyaovim_version')
  " Write NyaoVim specific code here
  colorscheme hazard
  inoremap <D-v> <C-r>"
  nnoremap <D-v> <C-r>"
  cnoremap <D-v> <C-r>"
  nnoremap <D-t> :<C-u>tabnew<CR>
else
  set background=dark
endif
