# vim:set filetype=zsh :

# -------- prompt setting ------------{{{
export VIRTUAL_ENV_DISABLE_PROMPT='1'

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo "<venv: `basename $VIRTUAL_ENV` >"
}


nom_prom () {
    local result_ok='
%F{cyan}CURRENT_DIR %F{green}===___ %F{cyan}[%~] %F{blue}$(virtualenv_info)
%F{cyan} ╹_╹✖  %F{red}:: %f'
    local result_ng='
%F{cyan}CURRENT_DIR %F{red}===___ %F{cyan}[%~] %F{blue}$(virtualenv_info)
%F{cyan} Ծ‸Ծ✖  %F{red}||%f '

    local uname_mname='%F{cyan}[%n@%m]%f'
    case ${UID} in
    # root
    0)
        PROMPT="%F{red}root__%f %(?|${result_ok}|${result_ng})"
        PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
        SPROMPT="%{${fg[yellow]}%}correct: %R ->  %r [n,y,a,e]? %{${reset_color}%}"
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
            PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
        ;;
    *)
        PROMPT="%(?|${result_ok}|${result_ng})"
        PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
        SPROMPT="%{${fg[yellow]}%}correct: %R ->  %r [n,y,a,e]? %{${reset_color}%}"
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
            PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
        ;;
    esac
}
nom_prom

# --------- show vcs's branch --------------------
# :=> %s:vcs's name, %b: branch's name, %a: action name
autoload -Uz vcs_info
# autoload -Uz add_zsh_hook -> precmdみたいな機能を実現させる感じ？ これ使うと関数に名前を付けられる
# %F{_colorname]%hoge%f : %Fから%fで挟んだ文字を指定の色で出力させる

zstyle ':vcs_info:*' formats '[%b]' #_default_ '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]' #'(%s)-[%b|%a]'
if is-at-least 4.3.7; then
    local br_name="%F{yellow}%b%f"
    local stgd="%F{green}%c%f"
    local unst="%F{red}%u%f"
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr '+'
    zstyle ':vcs_info:git:*' unstagedstr '-'
    zstyle ':vcs_info:git:*' formats "($br_name) [$stgd/$unst]"
    zstyle ':vcs_info:git:*' actionformats "($br_name) %F{red}!%f![%F{red}%a%f] [$stgd/$unst]"
fi

#psvarの中身は%1vとかの形で参照できる
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
    }

# %1vとして指定すると、カラー指定が反映されなくなるので直接参照
# [%~] == current dir, psvar[1] == vcs_info
RPROMPT='%1(v|$psvar[1]|)'


# vim:set foldmethod=marker :
