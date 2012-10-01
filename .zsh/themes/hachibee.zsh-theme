# vim:setfiletype=zsh :

# -------- prompt setting ------------{{{
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
# [%~] == current dir, psvar[1] == vcs_info
RPROMPT='%F{cyan}[%~]%f %1(v|$psvar[1]|)'

# ------------------------------------}}}

#####################
# change Color LS {{{
####################

# ============ CASE LSCOLORS ==============={{{
# FreeBSD type
# ========= LSCOLORSの各桁の意味 =========={{{
#01: ディレクトリ前景色
#02: ディレクトリ背景色
#03: シンボリックリンク前景色
#04: シンボリックリンク背景色
#05: ソケットファイル前景色
#06: ソケットファイル背景色
#07: FIFOファイル前景色
#08: FIFOファイル背景色
#09: 実行ファイル前景色
#10: 実行ファイル背景色
#11: ブロックスペシャルファイル前景色
#12: ブロックスペシャルファイル背景色
#13: キャラクタスペシャルファイル前景色
#14: キャラクタスペシャルファイル背景色
#15: setuidつき実行ファイル前景色
#16: setuidつき実行ファイル背景色
#17: setgidつき実行ファイル前景色
#18: setgidつき実行ファイル背景色
#19: スティッキビットありother書き込み権限つきディレクトリ前景色
#20: スティッキビットありother書き込み権限つきディレクトリ背景色
#21: スティッキビットなしother書き込み権限つきディレクトリ前景色
#22: スティッキビットなしother書き込み権限つきディレクトリ背景色
#}}}

# ====== LSCOLORSで指定できる色リスト ========== {{{
#a: 黒
#b: 赤
#c: 緑
#d: 茶
#e: 青
#f: マゼンタ
#g: シアン
#h: 白
#A: 黒(太字)
#B: 赤(太字)
#C: 緑(太字)
#D: 茶(太字)
#E: 青(太字)
#F: マゼンタ(太字)
#G: シアン(太字)
#H: 白(太字)
#x: デフォルト色
#}}}
# LSCOLORS }}}

# ================== CASE LS_COLORS ============ {{{
# GNU type
# ===== 指定する主な要素 {{{
#di: ディレクトリ
#ln: シンボリックリンク
#so: ソケットファイル
#pi: FIFOファイル
#ex: 実行ファイル
#bd: ブロックスペシャルファイル
#cd: キャラクタスペシャルファイル
#su: setuidつき実行ファイル
#sg: setgidつき実行ファイル
#tw: スティッキビットありother書き込み権限つきディレクトリ
#ow: スティッキビットなしother書き込み権限つきディレクトリ
# }}}
# ===== 指定する色 {{{
#00: なにもしない
#01: 太字化
#04: 下線
#05: 点滅
#07: 前背色反転
#08: 表示しない
#22: ノーマル化
#24: 下線なし
#25: 点滅なし
#27: 前背色反転なし
#30: 黒(前景色)
#31: 赤(前景色)
#32: 緑(前景色)
#33: 茶(前景色)
#34: 青(前景色)
#35: マゼンタ(前景色)
#36: シアン(前景色)
#37: 白(前景色)
#39: デフォルト(前景色)
#40: 黒(背景色)
#41: 赤(背景色)
#42: 緑(背景色)
#43: 茶(背景色)
#44: 青(背景色)
#45: マゼンタ(背景色)
#46: シアン(背景色)
#47: 白(背景色)
#49: デフォルト(背景色)
# }}}
# LS_COLORS }}}

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

#}}}
# vim:set foldmethod=marker :
