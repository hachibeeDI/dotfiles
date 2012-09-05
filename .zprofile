#read PATH for python _and python's tool
export PYTHONSTARTUP=~/.pythonstartup

#http://toggtc.hatenablog.com/entry/2012/02/06/023807  setting for distribute instead of setuptuools
export VIRTUALENV_USE_DISTRIBUTE=true

## use pip, only in virtualenv enviroments
#export PIP_REQUIRE_VIRTUALENV=true

export JAVA_OPTS="-Dswank.encoding=utf-8-unix"

# colored less
# source-highlight入れてないとエラー出そうだけどまーいっか
export LESS='-R'
case "${OSTYPE}" in
freebsd*|darwin*)
    export LESSOPEN='| /opt/local/bin/src-hilite-lesspipe.sh %s'
    ;;
linux*)
    export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
    ;; 
cygwin*)
    export LESSOPEN='| /bin/src-hilite-lesspipe.sh %s'
    ;;
esac

