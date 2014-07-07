
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
}
zle -N peco-select-history
bindkey '^r' peco-select-history


# 移動系 {{{
function peco-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr
bindkey '^gcd' peco-cdr


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


# 検索系 {{{
function agedit () {
  if [ $# -eq 0 ]; then
      echo "you should appoint query pattern"
      return 0
  fi

  TARG=$(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "+"$2 " " $1}')
  if [ $? = 1 -o "$TARG" = "" ]; then
    echo "no pattern was matched"
    return 1
  fi

  eval "${EDITOR} ${TARG}"
}

function ggre () {
  if [ $# -eq 0 ]; then
      echo "you should appoint query pattern"
      return 0
  fi

  TARG=$(git grep -In "$1" | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
  if [ $? = 1 -o "$TARG" = "" ]; then
    echo "no pattern was matched"
    return 1
  fi

  eval "${EDITOR} ${TARG}"
}

function glsv () {
  TARG=$(git ls-files "$1" | peco --query "$LBUFFER")
  if [ $? = 1 -o "$TARG" = "" ]; then
    echo "no pattern was matched"
    return 1
  fi

  eval "${EDITOR} ${TARG}"
}
# }}}
