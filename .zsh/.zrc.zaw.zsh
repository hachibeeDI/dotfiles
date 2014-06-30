# --- zaw --- {{{
# common settings
zstyle ':filter-select' case-insensitive yes

bindkey '^g' zaw
bindkey '^g^h' zaw-history
bindkey '^ggf' zaw-git-files
# zaw-src-gitdir {{{
# via: http://d.hatena.ne.jp/syohex/20120624/1340550154
# zaw source for git command
function zaw-src-gitdir () {
    _dir=$(git rev-parse --show-cdup 2>/dev/null)
    if [ $? -eq 0 ]
    then
        candidates=( $(git ls-files ${_dir} | perl -MFile::Basename -nle \
                       '$a{dirname $_}++; END{delete $a{"."}; print for sort keys %a}') )
    fi
    actions=("zaw-src-gitdir-cd")
    act_descriptions=("change directory in git repos")
}
function zaw-src-gitdir-cd () {
    BUFFER="cd $1"
    zle accept-line
}
zaw-register-src -n gitdir zaw-src-gitdir
bindkey '^ggd' zaw-gitdir
# }}}
## zaw-src-cdd {{{
# http://blog.kentarok.org/entry/2012/03/24/221522
if (( $+functions[cdd] )); then
    function zaw-src-cdd () {
        if [ -r "$CDD_PWD_FILE" ]; then
            for window in `cat $CDD_PWD_FILE | sed '/^$/d'`; do
                candidates+=("${window}")
            done

            actions=(zaw-src-cdd-cd)
            act_descriptions=("cdd for zaw")
        fi
    }
    function zaw-src-cdd-cd () {
        BUFFER="cd `echo $1 | cut -d ':' -f 2`"
        zle accept-line
    }
    zaw-register-src -n cdd zaw-src-cdd
fi
bindkey '^gcd' zaw-cdd
# }}}
# ======= }}}

