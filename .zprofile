#read PATH for python _and python's tool
export PYTHONSTARTUP=~/.pythonstartup

#http://toggtc.hatenablog.com/entry/2012/02/06/023807  setting for distribute instead of setuptuools
export VIRTUALENV_USE_DISTRIBUTE=true

# use pip, only in virtualenv enviroments
export PIP_REQUIRE_VIRTUALENV=true

case "${OSTYPE}" in
darwin*)
    export JAVA_OPTS="-Dswank.encoding=utf-8-unix"
;;
esac

