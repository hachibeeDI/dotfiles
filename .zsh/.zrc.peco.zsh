function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr
bindkey '^[cd]' peco-cdr

# peco-src-gitdir {{{
function peco-src-gitdir () {
    _dir=$(git rev-parse --show-cdup 2>/dev/null)
    if [ $? -eq 0 ]; then
        BUF=$(
            git ls-files | xargs dirname | sed '/^\.$/d' | sort | uniq | peco
        )
        cd ${BUF}
        zle accept-line
        zle clear-screen
    fi
}
zle -N peco-src-gitdir
bindkey '^ggd' peco-src-gitdir
# }}}
