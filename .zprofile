# ===========================================================
#
# put settings, which are enough by loaded once when that is called as login-shell and first time.
#
# ===========================================================

# pathの設定は、スクリプト実行時のためにもzshenvに書くべき？
#{{{
#　PATH設定用の便利な記法
### -U : 重複したパスは登録しない
#typeset -U path
### (N-/): 存在しないディレクトリは登録しない。
###    パス(...): ...という条件にマッチするパスのみ残す。
###            N: NULL_GLOBオプションを設定。
###               globがマッチしなかったり存在しないパスを無視する。
###            -: シンボリックリンク先のパスを評価。
###            /: ディレクトリのみ残す。
#

#}}}

# fpath設定
#fpath=(`brew --prefix`/share/zsh/functions(N) `brew --prefix`/share/zsh/site-functions(N) $fpath)

# setting completion's function path<<<
fpath=(
        #自作
        $HOME/.zsh/functions/Completion(N-/)

        #zsh-completions
        /usr/local/share/zsh-completions(N-/)
        /usr/local/share/zsh-completions/src(N-/)

        #homebrew
        /usr/local/share/zsh/functions(N-/)

        #cygwin
        /usr/share/zsh/4.3.12/functions(N-/)
        $HOME/.autojump/functions(N-/)

        $fpath
        )
#autoload -U ~/.zsh/functions/Completion/*(:t)

# ====================== OS TYPE ============================

# http://www.pochinet.org/linux2L003.htm
# -Xと--quit-if-one-screenの組み合わせで、一画面に収まる時はcatのような動きになる
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'

case "${OSTYPE}" in
freebsd*|darwin*)
# homebrew
    source ~/.zsh/.zenv.mac
    #export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
    #export ANDROID_SDK_ROOT="/usr/local/Cellar/android-sdk/r20.0.3"

    # use coreutils from $homebrew that supply gnu style common commands.
    #export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    ;;
linux*)
    #ディストリごとの分岐とか考えたい（debian-fedoraとか、あとarchはくせがあるらしい）
    source ~/.zsh/.zenv.linux
    export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
    ;;
cygwin*)
    source ~/.zsh/.zenv.cyg
    #export LESSOPEN='| /bin/src-hilite-lesspipe.sh %s'
    ;;
esac

#これはただの補完用なのでzshrcの方がいいかも......
## -x: export SUDO_PATHも一緒に行う。
## -T: SUDO_PATHとsudo_pathを連動する。
typeset -xT SUDO_PATH sudo_path
## 重複したパスを登録しない。
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))


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


