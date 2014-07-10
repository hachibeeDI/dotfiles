
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


alias ls-ps='ps aux |peco | awk '\''{print $2}'\'' '


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


# git utils {{{
function git-ls-file-edit () {
  TARG=$(git ls-files "$1" | peco --query "$LBUFFER")
  if [ $? = 1 -o "$TARG" = "" ]; then
    echo "no pattern was matched"
    return 1
  fi

  eval "${EDITOR} ${TARG}"
}

function git-del-merged () {
  TARG=$(git branch --merged | awk '/^[^*]/' | peco --query "$LBUFFER")
  if [ $? = 1 -o "$TARG" = "" ]; then
    echo "no pattern was matched"
    return 1
  fi

  eval "git branch -d $TARG"
}

alias -g GS='`git status -s | peco | awk '\''{print $2}'\'' `'
alias -g GF='`git ls-files | peco `'
alias -g GB='`git branch | peco | sed -e "s/^\*//g"`'
# get commit hash -> ex: git rebase -i GLo
alias -g GLo='`git log --oneline | peco | awk '\''{print $1}'\'' `'

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

# https://github.com/hachibeeDI/util-cmdtoolsに移動した
#function codic() {}

# }}}
