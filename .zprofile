# ===========================================================
#
# put settings, which are enough by loaded once when that is called as login-shell and first time.
#
# ===========================================================

# ====== common PATH ======={{{
# lang
export LANG=ja_JP.UTF-8
# locale
export LC_CTYPE=ja_JP.UTF-8

# editer
export EDITOR=vim

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

## pythonbrew "bashrcとなっているが、問題なし
if [ -d ~/.pythonbrew ]; then
    source $HOME/.pythonbrew/etc/bashrc
fi


#read PATH for python _and python's tool
export PYTHONSTARTUP=~/.pythonstartup

#http://toggtc.hatenablog.com/entry/2012/02/06/023807  setting for distribute instead of setuptuools
export VIRTUALENV_USE_DISTRIBUTE=true

# use pip, only in virtualenv enviroments
export PIP_REQUIRE_VIRTUALENV=true

# Mac & Linux Only Javahome
JAVA_HOME=/Library/Java/Home
export JAVA_HOME

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#}}}

export JAVA_OPTS="-Dswank.encoding=utf-8-unix"

# ================= colored less =======================
# source-highlight入れてないとエラー出そうだけどまーいっか
export LESS='-R'
case "${OSTYPE}" in
freebsd*|darwin*)
# homebrew
    export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
    ;;
linux*)
    export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
    ;;
cygwin*)
    export LESSOPEN='| /bin/src-hilite-lesspipe.sh %s'
    ;;
esac

