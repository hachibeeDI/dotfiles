# vim: set fdm=marker :

# =======================================================
#
# Initial setup file for only interactive zsh
# This file is read after .zshenv file is read.
#
# =======================================================

# ===== default autoloads =====
# U option is disable to open alias, in loading functions.

## Enable appoint color on name
autoload -Uz colors
colors
## Enable zmv command
autoload zmv
alias zmv='noglob zmv -W'
## call version check function
autoload -Uz is-at-least
# zsh editor
autoload zed
# prediction Completion
autoload predict-on
# predict-off

# load alias
source ~/.zsh/.zrc.alias
# load prompt
source ~/.zsh/themes/hachibee.zsh-theme

# homeに自分で定義したLSCOLORがあれば、それで上書きする
if [ -f ~/.dir_colors ]; then
    echo 'use local .dir_colors'
    eval `dircolors ~/.dir_colors -b`
else
    source ~/.zsh/themes/lscolors.default
fi

# OS ごとのfunction, プラグイン, fpathの読み込み <<<
case "${OSTYPE}" in
freebsd*|darwin*)
source ~/.zsh/.zrc.mac
    ;;
linux*)
source ~/.zsh/.zrc.linux
    ;;
cygwin*)
source ~/.zsh/.zrc.cyg
   ;;
esac
# ---- >>>


### Command Completemente<<<
# Default Completement
# fpathの変更はcompinitを実行する前に行わないと意味がないので注意！
autoload -U compinit; compinit

#>>>

# ZLS_COLORSの意味って？ とりあえずみんな設定してるくさいからおれもする
export ZLS_COLORS=$LS_COLORS

# 補完方法の設定 指定した順番に実行
### _oldlist 前回の補完結果を再利用する。
### _complete: fpath補完
### _expand: globや変数の展開を行う
### _match: globを展開しないで候補の一覧から補完する。
### _history: ヒストリのコマンドも補完候補とする。
### _ignored: 補完候補にださないと指定したものも補完候補とする。
### _approximate: 似ている補完候補も補完候補とする。
### _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' completer \
    _oldlist _complete _expand _match _history _ignored _approximate _prefix

## sudo時にはsudo用のパスも使う。
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

#補完候補がないときは、より曖昧検索パワーを高める
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}  r:|[._-]=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache true

# 詳細な情報を使う。
zstyle ':completion:*' verbose yes
# 補完リストをグループ分けする
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
# via cdd formaat
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'
zstyle ':completion:*' list-separator '-->'

###>>>

### Set shell options<<<
setopt no_beep

setopt auto_menu
setopt auto_list

setopt list_packed
setopt list_types
setopt noautoremoveslash
setopt magic_equal_subst
setopt print_eight_bit
setopt auto_cd
# stack cd history
setopt auto_pushd
setopt pushd_ignore_dups
setopt NO_hup
setopt ignore_eof
# 明確に.指定なしで.から始まるファイル名を補完
setopt globdots
# use '#' as comment on commandloine
setopt interactive_comments
# コマンド実行後は右プロンプトを消す
#setopt transient_rprompt
# 右プロンプトがかぶったら消す(デフォルトONじゃね感)
setopt promptcr
# コマンドの終了コードが0以外の場合に表示
# setopt print_exit_value
# 該当するブレース{}展開が存在しない場合、ascii順にソートして展開する
setopt brace_ccl
setopt complete_aliases
# ファイル名の補完時、ディレクトリにマッチしたら/を付与
setopt mark_dirs
# カッコの対応なども補完
setopt auto_param_keys
# correct slash of a end of name of dir
setopt auto_param_slash
# ファイル名一覧を順次表示
setopt always_last_prompt

#>>>

# permission settings
umask 022

# Enable appoint on reserved-word in PROMPT
# ex: $UID $HOME
setopt prompt_subst

# mm?
# limit coredumpsize 0

# if there too many Completementes
export LISTMAX=0

# history settings<<<
HISTFILE=~/.zsh_histfile
# history in memory
HISTSIZE=1000000
# history in file
SAVEHIST=1000000

# disable to save hist, if it's on RootUser
if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST = 0
fi

setopt share_history
setopt hist_ignore_all_dups # if there are overlaps on histfile, delete the old one
setopt hist_ignore_dups # disable to save histfile, if its overlaps on just before
# ignore `history` command itselfs
setopt hist_no_store
setopt hist_reduce_blanks
# ignore command is same as old one
setopt hist_save_no_dups
## 補完時にヒストリを自動的に展開する。
setopt hist_expand
setopt share_history
# when use zsh on multiwindow, add on a history file
setopt append_history
# save Begin and End
setopt EXTENDED_HISTORY

# --- 入力済みの文字列にマッチしたコマンドのヒストリを表示させる ---
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# ヒストリ呼び出しから、実行までの間に一度編集を可能にする
setopt hist_verify

#>>>

#クラックされた時に気がつける（かも) #{{{
## 全てのユーザのログイン・ログアウトを監視する。
watch="all"
## ログイン時にはすぐに表示する。
log
#}}}

## 実行したプロセスの消費時間が3秒以上かかったら自動的に消費時間の統計情報を表示する。
REPORTTIME=3

# spell checks on commandline
# setopt corrent

# Ctrl-u  "delete" like windows
bindkey '^U' backward-kill-line


## http://d.hatena.ne.jp/parasporospa/20061130
## http://d.hatena.ne.jp/tkng/20100712/1278896396
## エラーメッセージ本文出力に色付け{{{
#e_normal=`echo -e "¥033[0;30m"`
#e_RED=`echo -e "¥033[1;31m"`
#e_BLUE=`echo -e "¥033[1;36m"`
#
#function make() {
#    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
#}
#function cwaf() {
#    LANG=C command ./waf "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
#}
##}}}

# auto ls-command after cd
# function chpwd() { ls }

######
# key binds setting <<<
#######
### Binding key ###
# Like vim
#bindkey -v

# Like Emacs
bindkey -e

#>>>

# move dotfiles in Dropbox<<<
function dotf {
    if [ $# != 0 ]; then # 引数が存在するならば
        cd ~/Dropbox/dotfiles
        vim $1
    else
        cd ~/Dropbox/dotfiles
    fi
}
# >>>

# use cdd script<<<
. ~/.zsh/functions/cdd

chpwd() {
    _cdd_chpwd
}
#>>>

# google search<<<
function google() {
  local str opt
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  w3m http://www.google.co.jp/$opt
}
#>>>

#show buffer stack<<<
show_buffer_stack(){
    POSTDISPLAY="
stck: $LBUFFER"
    zle push-line-or-edit
}
zle -N show_buffer_stack
# ^[ = ESC
bindkey "q" show_buffer_stack

#>>>

# ^ => cd ..<<<
function cdup() {
    echo
    cd -
    zle reset-prompt
}
zle -N cdup
# delete
bindkey '[3~' cdup

#>>>

# 全履歴の検索
function history-all { history -E l }

# -------------
#  source auto-fu.zsh(plugin)<<<
#
#   if [ -f ~/.zsh/auto-fu.zsh ]; then
#       source ~/.zsh/auto-fu.zsh
#       function zle-line-init () {
#           auto-fu-init
#       }
#       zle -N zle-line-init
#       zstyle ':completion:*' completer _oldlist _complete
#   fi
#---->>>

# -- zsh syntax highlight ----{{{
source ~/.zsh/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# }}}

#読み込み部分は各OSごとのアレ部分

#>>>

# --------
# complete sheet<<<
# ------------------
compdef _sheets sheet
function _sheets {
    local -a cmds
    _files -W ~/.sheets/ -P '~/.sheets/'

    cmds=('list' 'edit' 'copy')
    _describe -t commands "subcommand" cmds

    return 1;
}
#>>>

# utils<<<
mkcd() {mkdir -p "$@" && cd "$*[-1]"}
mktmp() {mkdir `date +"%Y%m%d_%H%M%S"`}

g_root() { cd `git rev-parse --git-dir |sed -e "s/[^\/]*$//g"` }

# arrange a littele: http://qiita.com/items/1f01aa09ccf148542f21
gs() {
    git status -sb && git stash list
}

gst() {
    git status -sb | head -n 1 && git stash list
    git status -sb | sed '1d' | grep --line-number '^'
}

gsa() {
    local targfile;
    targfile=`git status -sb |grep -v "^#" | awk '{print$1="";print}' |grep -v "^$" | awk "NR==$1" | sed "s/\s//g"`
    echo "add $targfile"
    git add $targfile
}
gsap() {
    local targfile;
    targfile=`git status -sb |grep -v "^#" | awk '{print$1="";print}' |grep -v "^$" | awk "NR==$1" | sed "s/\s//g"`
    echo "add $targfile"
    git add -p $targfile
}
gsd() {
    local targfile;
    targfile=`git status -sb |grep -v "^#" | awk '{print$1="";print}' |grep -v "^$" | awk "NR==$1" | sed "s/\s//g"`
    echo "show diff $targfile"
    git diff --color -- $targfile
}
gsv() {
    local targfile;
    targfile=`git status -sb |grep -v "^#" | awk '{print$1="";print}' |grep -v "^$" | awk "NR==$1" | sed "s/\s//g"`
    echo "edit $targfile"
    vim $targfile
}
#>>>

