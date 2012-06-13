#################################################
#
# Initial setup file for only interactive zsh
# This file is read after .zshenv fie is read.
#
##################################################

# lang
export LANG=ja_JP.UTF-8


# alias settings
case "${OSTYPE}" in
# Mac OS X
freebsd*|darwin*)
    alias ls='ls -GA -w'
    ;;

# Linux
linux*|cygwin*)
    alias ls='ls --color=auto -AF'
    alias rm='rm --interactive=once'
    alias cp='cp --interactive'
    alias mv='mv --interactive'
    ;;
esac

alias ll='ls -ltr'
alias la='ls -a'
alias -g lgrep='| grep'

# -------- git alias --------
alias g='git'
alias gst='git status -sb'

# editer
export EDITOR=vim

# disable make less-hist-file
export LESSHISTFILE=-

### Command Completement
# Default Completement
autoload -U compinit
compinit -u

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=1

## Enable appoint color on name
autoload -Uz colors
colors

## call version check function
autoload -Uz is-at-least

### Set shell options
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

# permission settings
umask 022

# Enable appoint on reserved-word in PROMPT
# ex: $UID $HOME
setopt prompt_subst

# mm?
# limit coredumpsize 0


# if there too many Completementes
export LISTMAX=0



# history settings
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


# use '#' as comment on commandloine
setopt interactive_comments

# spell checks on commandline
# setopt corrent


# Ctrl-u  "delete" like windows
bindkey '^U' backward-kill-line


# Ctrl-h  delete fullword
bindkey "^h" backward-kill-word

# auto ls-command after cd
# function chpwd() { ls }

## pythonbrew "bashrcとなっているが、問題なし
source $HOME/.pythonbrew/etc/bashrc


# ================================================#
# -------- prompt setting ------------
case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{^[[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac


# --------- show vcs's branch --------------------
# :=> %s:vcs's name, %b: branch's name, %a: action name
autoload -Uz vcs_info
# autoload -Uz add_zsh_hook -> precmdみたいな機能を実現させる感じ？ これ使うと関数に名前を付けられる 

zstyle ':vcs_info:*' formats '[%b]' #'(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]' #'(%s)-[%b|%a]'
if is-at-least 4.3.7; then
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "sted"
    zstyle ':vcs_info:git:*' unstagedstr "unst"
    zstyle ':vcs_info:git:*' formats '[%b] ~ %c / %u'
    zstyle ':vcs_info:git:*' actionformats '[%b|%a] ~ %c / %u'
fi

precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
    }
RPROMPT="%1(v|%F{green}%1v%f|)"

# ----------------------------------------------------#

#####################
# change Color LS
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


######
# key binds setting
#######
### Binding key ###
# Like vim
#bindkey -v

# Like Emacs
bindkey -e

# move hjkl
#zmodload zsh/complist
#bindkey -M menuselect '^h' vi-backward-char
#bindkey -M menuselect '^j' vi-down-line-or-history
#bindkey -M menuselect '^k' vi-up-line-or-history
#bindkey -M menuselect '^l' vi-forward-char
#
## =====================================================#
## Set vi mode status bar
##
#
##
## Reads until the given character has been entered.
##
#readuntil () {
#    typeset a
#    while [ "$a" != "$1" ]
#    do
#        read -E -k 1 a
#    done
#}
#
##
## If the $SHOWMODE variable is set, displays the vi mode, specified by
## the $VIMODE variable, under the current command line.
## 
## Arguments:
##
##   1 (optional): Beyond normal calculations, the number of additional
##   lines to move down before printing the mode.  Defaults to zero.
##
#showmode() {
#    typeset movedown
#    typeset row
#
#    # Get number of lines down to print mode
#    movedown=$(($(echo "$RBUFFER" | wc -l) + ${1:-0}))
#    
#    # Get current row position
#    echo -n "\e[6n"
#    row="${${$(readuntil R)#*\[}%;*}"
#    
#    # Are we at the bottom of the terminal?
#    if [ $((row+movedown)) -gt "$LINES" ]
#    then
#        # Scroll terminal up one line
#        echo -n "\e[1S"
#        
#        # Move cursor up one line
#        echo -n "\e[1A"
#    fi
#    
#    # Save cursor position
#    echo -n "\e[s"
#    
#    # Move cursor to start of line $movedown lines down
#    echo -n "\e[$movedown;E"
#    
#    # Change font attributes
#    echo -n "\e[1m"
#    
#    # Has a mode been set?
#    if [ -n "$VIMODE" ]
#    then
#        # Print mode line
#        echo -n "-- $VIMODE -- "
#    else
#        # Clear mode line
#        echo -n "\e[0K"
#    fi
#
#    # Restore font
#    echo -n "\e[0m"
#    
#    # Restore cursor position
#    echo -n "\e[u"
#}
#
#clearmode() {
#    VIMODE= showmode
#}
#
##
## Temporary function to extend built-in widgets to display mode.
##
##   1: The name of the widget.
##
##   2: The mode string.
##
##   3 (optional): Beyond normal calculations, the number of additional
##   lines to move down before printing the mode.  Defaults to zero.
##
#makemodal () {
#    # Create new function
#    eval "$1() { zle .'$1'; ${2:+VIMODE='$2'}; showmode $3 }"
#
#    # Create new widget
#    zle -N "$1"
#}
#
## Extend widgets
#makemodal vi-add-eol           INSERT
#makemodal vi-add-next          INSERT
#makemodal vi-change            INSERT
#makemodal vi-change-eol        INSERT
#makemodal vi-change-whole-line INSERT
#makemodal vi-insert            INSERT
#makemodal vi-insert-bol        INSERT
#makemodal vi-open-line-above   INSERT
#makemodal vi-substitute        INSERT
#makemodal vi-open-line-below   INSERT 1
#makemodal vi-replace           REPLACE
#makemodal vi-cmd-mode          NORMAL
#
#unfunction makemodal
#
# ========================================================#

# google search
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

show_buffer_stack(){
    POSTDISPLAY="
stck: $LBUFFER"
    zle push-line-or-edit
}
zle -N show_buffer_stack
bindkey "^[q" show_buffer_stack # ^[ = ESC ?

# ^ => cd ..
function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
bindkey '^\[' cdup #Ctrl+[ でcd .. のはず。なぜか^単体でも戻ってしまう？ Ctcl+Vを押してから^を押せば入力可能

# -------------
#  source auto-fu.zsh(plugin)
#  ----------------------------------------------------
if [ -f ~/.zsh/auto-fu.zsh ]; then
    source ~/.zsh/auto-fu.zsh
    function zle-line-init () {
        auto-fu-init
    }
    zle -N zle-line-init
    zstyle ':completion:*' completer _oldlist _complete
if



