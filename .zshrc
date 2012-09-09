# vim:fdm=marker fmr=<<<,>>>:

# =======================================================
#
# Initial setup file for only interactive zsh
# This file is read after .zshenv file is read.
#
# =======================================================

# load alias
source ~/.zsh/.zrc.alias

### Command Completemente<<<

# setting completion's function path<<<
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U ~/.zsh/functions/Completion/*(:t)
#>>>

# Default Completement
autoload -U compinit
compinit -u

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache true
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=1
# via cdd format
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'

###>>>

## Enable appoint color on name
autoload -Uz colors
colors

## call version check function
autoload -Uz is-at-least

## Enable zmv command
autoload zmv
alias zmv='noglob zmv'

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

# auto ls-command after cd
# function chpwd() { ls }

# ================================================#
# -------- prompt setting ------------<<<
nom_prom () {
    local cmd_result="%(?. .%F{red}_ %f)"
    case ${UID} in
    0) # root
        PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b$cmd_result"
        PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
        SPROMPT="%{${fg[yellow]}%}correct: %R ->  %r [n,y,a,e]? %{${reset_color}%}"
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
            PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
        ;;
    *)
        PROMPT="%{${fg[cyan]}%}[%n@%m]%{${reset_color}%}$cmd_result"
        PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
        SPROMPT="%{${fg[yellow]}%}correct: %R ->  %r [n,y,a,e]? %{${reset_color}%}"
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
            PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
        ;;
    esac
}
nom_prom

# --------- show vcs's branch --------------------
# :=> %s:vcs's name, %b: branch's name, %a: action name
autoload -Uz vcs_info
# autoload -Uz add_zsh_hook -> precmdみたいな機能を実現させる感じ？ これ使うと関数に名前を付けられる

zstyle ':vcs_info:*' formats '[%b]' #_default_ '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]' #'(%s)-[%b|%a]'
if is-at-least 4.3.7; then
    local br_name="%F{yellow}%b%f"
    local stgd="%F{green}%c%f"
    local unst="%F{red}%u%f"
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr '+'
    zstyle ':vcs_info:git:*' unstagedstr '-'
    zstyle ':vcs_info:git:*' formats "($br_name) [$stgd/$unst]"
    zstyle ':vcs_info:git:*' actionformats "[$br_name|%F{red}%a%f] [$stgd/$unst]"
fi

#psvarの中身は%1vとかの形で参照できる
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
    }

# %1vとして指定すると、カラー指定が反映されなくなるので直接参照
RPROMPT='%F{cyan}[%~]%f %1(v|$psvar[1]|)'

# ------------------------------------>>>

#####################
# change Color LS<<<
####################

case "${TERM}" in
kterm*|xterm*)
    export LSCOLORS=gxfxcxdxbxegedabagacad

    export LS_COLORS='di=36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
cons25)
    unset LANG
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

####>>>

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
cd ..
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
#>>>

