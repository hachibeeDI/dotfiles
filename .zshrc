# vim:fdm=marker fmr=<<<,>>>:

# =======================================================
#
# Initial setup file for only interactive zsh
# This file is read after .zshenv file is read.
#
# =======================================================

# ===== default autoloads =====
# U option is disable to open alias, in loading functions.
# Default Completement
autoload -U compinit
compinit -u
## Enable appoint color on name
autoload -Uz colors
colors
## Enable zmv command
autoload zmv
alias zmv='noglob zmv'
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

### Command Completemente<<<
# setting completion's function path<<<
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U ~/.zsh/functions/Completion/*(:t)
#>>>

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache true
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=1
# via cdd format
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'

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
setopt NO_hup
setopt ignore_eof
# use '#' as comment on commandloine
setopt interactive_comments
# コマンド実行後は右プロンプトを消す
setopt transient_rprompt
# 右プロンプトがかぶったら消す(デフォルトONじゃね感)
setopt promptcr
# コマンドの終了コードが0以外の場合に表示
# setopt print_exit_value
# 該当するブレース{}展開が存在しない場合、ascii順にソートして展開する
setopt brace_ccl
setopt complete_aliases

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
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# disable to save hist, if it's on RootUser
if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST = 0
fi

setopt share_history
setopt hist_ignore_all_dups # if there are overlaps on histfile, delete the old one
setopt hist_ignore_dups # disable to save histfile, if its overlaps on just before
setopt hist_no_store
setopt hist_reduce_blanks
setopt share_history
# when use zsh on multiwindow, add on history file
setopt append_history
# stack cd history
setopt auto_pushd
setopt pushd_ignore_dups

#>>>


# spell checks on commandline
# setopt corrent

# Ctrl-u  "delete" like windows
bindkey '^U' backward-kill-line


# Ctrl-h  delete fullword
bindkey "^h" backward-kill-word

# http://d.hatena.ne.jp/parasporospa/20061130
# http://d.hatena.ne.jp/tkng/20100712/1278896396
# エラーメッセージ本文出力に色付け{{{
e_normal=`echo -e "¥033[0;30m"`
e_RED=`echo -e "¥033[1;31m"`
e_BLUE=`echo -e "¥033[1;36m"`

function make() {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
function cwaf() {
    LANG=C command ./waf "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
#}}}

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
        cd ~/Dropbox/dotfiles/$1
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
bindkey "^[q" show_buffer_stack # ^[ = ESC ?
#>>>

# ^ => cd ..<<<
function cdup() {
    echo
    cd -
    zle reset-prompt
}
zle -N cdup
bindkey '^\[' cdup
#>>>
#
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
gst() {
    git status -sb | head -n 1
    git status -sb | sed '1d' | grep --line-number '^'
}
gsta() {
    local targfile;
    targfile=`git status -sb |grep -v "^#" | awk '{print$1="";print}' |grep -v "^$" | awk "NR==$1" | sed "s/\s//g"`
    git add $targfile
}
gstd() {
    local targfile;
    targfile=`git status -sb |grep -v "^#" | awk '{print$1="";print}' |grep -v "^$" | awk "NR==$1" | sed "s/\s//g"`
    git diff --color -- $targfile
}
gstv() {
    local targfile;
    targfile=`git status -sb |grep -v "^#" | awk '{print$1="";print}' |grep -v "^$" | awk "NR==$1" | sed "s/\s//g"`
    vim $targfile
}
#>>>

