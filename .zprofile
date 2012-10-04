# ===========================================================
#
# put settings, which are enough by loaded once when that is called as login-shell and first time.
#
# ===========================================================

#　PATH設定用の便利な記法
### -U : 重複したパスは登録しない
#typeset -U path
### (N-/): 存在しないディレクトリは登録しない。
###    パス(...): ...という条件にマッチするパスのみ残す。
###            N: NULL_GLOBオプションを設定。
###               globがマッチしなかったり存在しないパスを無視する。
###            -: シンボリックリンク先のパスを評価。
###            /: ディレクトリのみ残す。
#path=(# システム用
#      /bin(N-/)
#      # 自分用
#      $HOME/local/bin(N-/)
#      # Debian GNU/Linux用
#      /var/lib/gems/*/bin(N-/)
#      # MacPorts用
#      /opt/local/bin(N-/)
#      # Solaris用
#      /opt/csw/bin(N-/)
#      /usr/sfw/bin(N-/)
#      # Cygwin用
#      /cygdrive/c/meadow/bin(N-/)
#      # システム用
#      /usr/local/bin(N-/)
#      /usr/bin(N-/)
#      /usr/games(N-/)) = true
#
# ====================== OS TYPE ============================

# http://www.pochinet.org/linux2L003.htm
# -Xと--quit-if-one-screenの組み合わせで、一画面に収まる時はcatのような動きになる
export LESS='-gj10X --quit-if-one-screen --RAW-CONTROL-CHARS'

case "${OSTYPE}" in
freebsd*|darwin*)
# homebrew
    export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

    # use coreutils from $homebrew that supply gnu style common commands.
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    ;;
linux*)
    export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
    ;;
cygwin*)
    export LESSOPEN='| /bin/src-hilite-lesspipe.sh %s'
    ;;
esac

# ====== common PATH ======={{{
# lang
export LANG=ja_JP.UTF-8
# locale
export LC_CTYPE=ja_JP.UTF-8

# editer
export EDITOR=vim

#
export PAGER=less

# disable make less-hist-file
export LESSHISTFILE=-
#}}}

# ======= language specific ========================{{{
# node.js-npm
if [ -d /usr/local/lib/node_modules ]; then
    export NODE_PATH=/usr/local/lib/node_modules/
fi

if [ -d /usr/local/share/npm/bin ]; then
    export PATH=/usr/local/share/npm/bin:$PATH
fi

if [ -d /usr/local/share/python ]; then
    # use package installed by pip
    export PATH="$PATH:/usr/local/share/python"
fi

#read PATH for python _and python's tool
export PYTHONSTARTUP=~/.pythonstartup

##http://toggtc.hatenablog.com/entry/2012/02/06/023807  setting for distribute instead of setuptuools
#export VIRTUALENV_USE_DISTRIBUTE=true
#
## use pip, only in virtualenv enviroments
#export PIP_REQUIRE_VIRTUALENV=true

# Mac & Linux Only Javahome
JAVA_HOME=/Library/Java/Home
export JAVA_HOME

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#}}}

export JAVA_OPTS="-Dswank.encoding=utf-8-unix"


