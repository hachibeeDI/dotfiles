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
# enable cdr {{{
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME:-$HOME/.cache}/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true
# }}}

## call version check function
autoload -Uz is-at-least
## zsh editor
#autoload zed
# prediction Completion
autoload predict-on
# predict-off

# OS ごとのfunction, プラグイン {{{
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
# ---- }}}


### Command Completemente{{{
# Default Completement
# fpathの変更はcompinitを実行する前に行わないと意味がないので注意！
autoload -U compinit; compinit

# }}}

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
zstyle ':completion:*:warnings' format 'No matches for: %d'
## via cdd formaat
zstyle ':completion:*:descriptions' format '%BCompleting%b %F{yellow}%U%d%u'
zstyle ':completion:*' list-separator '-->'
# ../ などとタイプしたとき、現在いるディレクトリを補完候補に出さない
zstyle ':completion:*' ignore-parents parent pwd ..

### }}}

### Set shell options{{{
## カレントディレクトリにサブディレクトリが見つからない場合にcdが検索する場所
#cdpath=($HOME)

setopt no_beep
setopt no_flow_control

setopt auto_menu
setopt auto_list

#glob展開の拡張(正規表現ライクな記法が使えるようになる)
setopt extended_glob
# 補完候補リストを出来るだけコンパクトに表示する
setopt list_packed
setopt list_types
# =以降も補完する(--prefix=/usrなど)
setopt magic_equal_subst
setopt print_eight_bit
setopt auto_cd
# stack cd history
setopt auto_pushd
setopt pushd_ignore_dups
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
## 補完実行時にエイリアスを展開せずにそのままのコマンドとしてエイリアスを扱う
#setopt complete_aliases # あると g で git が補完されなかったりしてうっとおしいだけなので無効
# ファイル名の補完時、ディレクトリにマッチしたら/を付与
setopt mark_dirs
# カッコの対応なども補完
setopt auto_param_keys
# correct slash of a end of name of dir
setopt auto_param_slash
# パスの最後の/を削除しない(勝手に削除されると困るケースもあるので)
setopt noautoremoveslash
# ファイル名一覧を順次表示
setopt always_last_prompt
# 補完候補リストが垂直ではなく水平方向に並ぶようになる
setopt list_rows_first
## 曖昧マッチよりも正確さを優先する？
#setopt rec_exact
# スペルミスを指摘して正しいと思われるコマンドを出してくれる 設定しない
setopt no_correct
setopt no_correctall
# バックグラウンドジョブのスピードを落とさない
setopt no_bg_nice
# ログアウトしてもバックグランドジョブを止めない
setopt no_hup
# ジョブが終了したらただちに知らせる
setopt notify
# rm * を実行する前に確認
setopt rm_star_wait

# }}}

# permission settings
umask 022

# Enable appoint on reserved-word in PROMPT
# ex: $UID $HOME
setopt prompt_subst

# mm?
# limit coredumpsize 0

# if there too many Completementes
export LISTMAX=0

# history settings{{{
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


# hook when commands registered to history
zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  [[ ${#line} -ge 5
      && ${cmd} != (l|l[sal])
      && ${cmd} != (c|cd)
      && ${cmd} != (m|man)
      && ${cmd} != (hub)
  ]]
}


setopt share_history
setopt hist_ignore_all_dups # if there are overlaps on histfile, delete the old one
setopt hist_ignore_dups # disable to save histfile, if its overlaps on just before
setopt HIST_IGNORE_SPACE
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
# append history immediately after commands finished.
setopt inc_append_history
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

# }}}

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

######
# key binds setting {{{
#######
### Binding key ###
# Like vim
#bindkey -v

# Like Emacs
bindkey -e

# Ctrl-u delete line before cursor
bindkey '^U' backward-kill-line
# Ctrl-u delete word before cursor
bindkey "^[h" backward-kill-word

bindkey "^[u" undo
bindkey "^[r" redo
# }}}

# ------------------- load plugins ---------------- {{{
# -- zsh syntax highlight ---
source ~/.zsh/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -- zaw.zsh -------- (pecoが入んない環境のみ)
if which peco > /dev/null; then
    echo 'use peco'
    source ~/.zsh/.zrc.peco.zsh
    function _insert_pecopipe() {
        LBUFFER=${LBUFFER}" | peco"
    }
    zle -N _insert_pecopipe
    bindkey '^[p' _insert_pecopipe
else
    echo 'use zaw'
    source ~/.zsh/modules/zaw/zaw.zsh
    source ~/.zsh/.zrc.zaw.zsh
fi

# -- notify if command takes long time
source ~/.zsh/functions/notify_wlonger.zsh
# }}}
# -------------------- settings for plugins ------------ {{{
# {{{
function _delete-char-or-list-expand() {
    if [[ -z "${RBUFFER}" ]]; then
        # the cursor is at the end of the line
        zle list-expand
    else
        zle delete-char
    fi
}
zle -N _delete-char-or-list-expand
bindkey '^D' _delete-char-or-list-expand
# }}}

# }}}
# move dotfiles in Dropbox{{{
function dotf {
    if [ $# != 0 ]; then # 引数が存在するならば
        cd ~/Dropbox/dotfiles
        vim $1
    else
        cd ~/Dropbox/dotfiles
    fi
}
#  }}}

#show buffer stack{{{
show_buffer_stack(){
    POSTDISPLAY="
stacked: $LBUFFER"
    zle push-line-or-edit
}
zle -N show_buffer_stack
# ^[ = ESC
bindkey "q" show_buffer_stack

# }}}

function cdup() {
    echo
    cd ..
    zle reset-prompt
}
zle -N cdup
# Ctrl+] なんかとかぶったら考える
bindkey '^]' cdup

# }}}

# 全履歴の検索
function history-all { history -E 1 }


# --------
# complete sheet{{{
# ------------------
compdef _sheets sheet
function _sheets {
    local -a cmds
    _files -W ~/.sheets/ -P '~/.sheets/'

    cmds=('list' 'edit' 'copy')
    _describe -t commands "subcommand" cmds

    return 1;
}
# }}}

# utils{{{
mkcd() {mkdir -p "$@" && cd "$*[-1]"}
mktmp() {mkdir `date +"%Y%m%d_%H%M%S"`}

showroot() { `git rev-parse --git-dir |sed -e "s/[^\/]*$//g"` }

DELI_ST_LT="%{${fg[green]}%}<%{${fg[reset_color]}%}"
DELI_ST_GT="%{${fg[green]}%}>%{${fg[reset_color]}%}"

CR_cyan="%{${fg[cyan]}%}"

# virtualenvを使っていれば、使っているsandboxの情報を出す
function put_virtualenv_info {
    [ $VIRTUAL_ENV ] && echo "${DELI_ST_LT}%{${fg[blue]}%}venv: %{${fg[cyan]}%}`basename $VIRTUAL_ENV` $DELI_ST_GT"
}

# rbenvでアクチしているRubyのversionを表示する
function rbenv_version() {
    if which rbenv > /dev/null; then
        _ver="$CR_cyan`rbenv version | sed -e "s/\s(.\+$//g"`"
        echo "${DELI_ST_LT}%{${fg[blue]}%}rbenv: $_ver ${DELI_ST_GT}"
    else
        echo ""
    fi
}

# -------------- load prompt ---------------- {{{
source ~/.zsh/themes/hachibee.zsh-theme

# homeに自分で定義したLSCOLORがあれば、それで上書きする
if [ -f ~/.dir_colors ]; then
    echo 'use local .dir_colors'
    eval `dircolors ~/.dir_colors -b`
else
    source ~/.zsh/themes/lscolors.default
fi
# }}}

hash -d drop=~/Dropbox/

if which direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# load alias
source ~/.zsh/.zrc.alias
