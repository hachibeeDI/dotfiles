function fzf-gitworktree-cd() {
  local selected
  selected=$(
    git worktree list \
      | awk '{
          path = $1
          branch = $3
          gsub(/[\[\]]/, "", branch)
          printf "%-50s %s\n", path, branch
        }' \
      | fzf --prompt="worktree> " \
      | awk '{print $1}'
  )
  [[ -n "$selected" ]] && cd "$selected"
}

zle -N fzf-gitworktree-cd
bindkey '^gwt' fzf-gitworktree-cd

function fzf-gitworktree-clean() {
  local repo_root
  repo_root="$(git rev-parse --show-toplevel)" || return 1

  # .claude/worktrees/ 配下のものだけを候補にする
  local selected
  selected="$(git -C "$repo_root" worktree list \
    | grep "/.claude/worktrees/" \
    | fzf --prompt "worktree to remove >")"
  [ -z "$selected" ] && { echo "cancelled"; return 0; }

  # 1カラム目がworktreeのフルパス
  local wt_path
  wt_path="$(echo "$selected" | awk '{print $1}')"
  local wt_name
  wt_name="$(basename "$wt_path")"
  local proj_key
  proj_key="$(echo "$wt_path" | sed 's|/|-|g')"

  echo "removing: $wt_path"
  git -C "$repo_root" worktree remove "$wt_path" --force || return 1
  git -C "$repo_root" branch -D "worktree-$wt_name" 2>/dev/null
  rm -rf "$HOME/.claude/projects/$proj_key"
  echo "removed worktree and sessions for: $wt_name"
}

zle -N fzf-gitworktree-clean
bindkey '^gwc' fzf-gitworktree-clean

function fzf-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        fzf --query "$LBUFFER")
    CURSOR=$#BUFFER
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history


alias ls-ps='ps aux | fzf | awk '\''{print $2}'\'' '


# 移動系 {{{
function fzf-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-cdr
bindkey '^gcd' fzf-cdr


function fzf-ghq () {
    local selected_dir=$(ghq list -p | fzf)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-ghq
bindkey '^gh' fzf-ghq


# }}}


# git utils {{{
function fzf-git-co () {
    local selected_dir=$(git branch | grep -v "*" | fzf)
    if [ -n "$selected_dir" ]; then
        BUFFER="git checkout ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-git-co
bindkey '^go' fzf-git-co


function fzf-src-gitdir () {
    local _dir=$(git rev-parse --show-cdup 2>/dev/null)
    if [ $? -eq 0 ]; then
        BUF=$(
            git ls-files | xargs dirname | sed '/^\.$/d' | sort | uniq | fzf
        )
        cd ${BUF}
        zle accept-line
        zle clear-screen
    fi
}
zle -N fzf-src-gitdir
bindkey '^ggd' fzf-src-gitdir


function git-ls-file-edit () {
  local TARG=$(git ls-files "$1" | fzf --query "$LBUFFER")
  if [ $? = 1 -o "$TARG" = "" ]; then
    echo "no pattern was matched"
    return 1
  fi

  eval "${EDITOR} ${TARG}"
}

function git-del-merged () {
  local TARG=$(git branch --merged | awk '/^[^*]/' | fzf --query "$LBUFFER")
  if [ $? = 1 -o "$TARG" = "" ]; then
    echo "no pattern was matched"
    return 1
  fi

  eval "git branch -d $TARG"
}

function git-show-hash() {
   git --no-pager log --oneline --branches | fzf | awk '{print $1}'
 }

alias -g GS='`git status -s | fzf | awk '\''{print $2}'\'' `'
alias -g GF='`git ls-files | fzf `'
alias -g GB='`git branch | fzf | sed -e "s/^\*//g"`'
# get commit hash -> ex: git rebase -i GLo
alias -g GH='$(git-show-hash)'

function git-operation-modified () {
  local TARG=$(git status -s | fzf --query "$LBUFFER" --prompt='File>' | awk '{print $2}')
  if [ $? = 1 -o "$TARG" = "" ]; then
    echo "no pattern was matched"
    return 1
  fi

  # .gitconfigに edit = "!f () { mvim $1; }; f" しておくことで、git edit でMacVimが立ち上がる
  local ACTION=$(printf "add\ndiff\nedit\nrm"| fzf --prompt='Action>')
  if [ "$ACTION" = "" ]; then
    ACTION="diff"
  fi
  BUFFER="git ${ACTION} ${TARG}"
  zle accept-line
}
zle -N git-operation-modified
bindkey '^g^o' git-operation-modified

# }}}


# 検索系 {{{
function agedit () {
  if [ $# -eq 0 ]; then
      echo "you should appoint query pattern"
      return 0
  fi

  TARG=$(ag $@ | fzf --query "$LBUFFER" | awk -F : '{print "+"$2 " " $1}')
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

  TARG=$(git grep -In "$1" | fzf --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
  if [ $? = 1 -o "$TARG" = "" ]; then
    echo "no pattern was matched"
    return 1
  fi

  eval "${EDITOR} ${TARG}"
}

function fzf-installed-pip-open() {
  local PIP_MODULE=$(pip freeze | fzf | sed -e "s/==.\+$//g")
  if [ "$PIP_MODULE" = "" ]; then
    return 1
  fi

  local PKG_LOCATION=$(pip show ${PIP_MODULE} | grep '^Location:\s' | sed -e "s/^Location:\s//g")
  if [ "$PKG_LOCATION" = "" ]; then
    return 1
  fi

  local PATH_TO_PKG_DIR="${PKG_LOCATION}/${PIP_MODULE}"
  if [ -e ${PATH_TO_PKG_DIR} ]; then
    BUFFER="${EDITOR} ${PATH_TO_PKG_DIR}"
  else
    BUFFER="${EDITOR} ${PATH_TO_PKG_DIR}.py"
  fi
  zle accept-line
}
zle -N fzf-installed-pip-open
bindkey '^[;p' fzf-installed-pip-open  # Meta-; p

# https://github.com/hachibeeDI/util-cmdtoolsに移動した
#function codic() {}

# }}}
