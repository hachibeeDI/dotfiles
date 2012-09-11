# vim:setfiletype=zsh

# -------- prompt setting ------------<<<
nom_prom () {
    local cmd_result="%(?. .%F{red}_ %f)"
    case ${UID} in
    # root
    0)
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

