# ===========================================================
#
# put settings, which are enough by loaded once when that is called as login-shell and first time.
#
# ===========================================================
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

# ====================== OS TYPE ============================

# 以下のパスについては重複を削除する
typeset -U path cdpath fpath manpath

# http://www.pochinet.org/linux2L003.htm
# -Xと--quit-if-one-screenの組み合わせで、一画面に収まる時はcatのような動きになる
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'

# Go {{{
export GOPATH="$HOME/.go:$HOME/.ghq"
# }}}


case "${OSTYPE}" in
freebsd*|darwin*)
# homebrew
    source ~/.zsh/.zenv.mac
    ;;
linux*)
    #ディストリごとの分岐とか考えたい（debian-fedoraとか、あとarchはくせがあるらしい）
    source ~/.zsh/.zenv.linux
    ;;
cygwin*)
    source ~/.zsh/.zenv.cyg
    ;;
esac

#これはただの補完用なのでzshrcの方がいいかも......
## -x: export SUDO_PATHも一緒に行う。
## -T: SUDO_PATHとsudo_pathを連動する。
typeset -xT SUDO_PATH sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))


# ====== common PATH ======={{{
# ZLS_COLORSの意味って？ とりあえずみんな設定してるくさいからおれもする
export ZLS_COLORS=$LS_COLORS
# lang
export LANG=ja_JP.UTF-8
# locale
export LC_CTYPE=ja_JP.UTF-8

# editer
export EDITOR=vim

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#
export PAGER=less
# Apply grep color automatically
export GREP_COLOR=auto

# disable make less-hist-file
export LESSHISTFILE=-
#}}}

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


if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

## To use Homebrew's directories rather than ~/.pyenv add to your profile:
#export PYENV_ROOT=/usr/local/opt/pyenv

## Load RVM into a shell session *as a function*
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#}}}

export JAVA_OPTS="-Dswank.encoding=utf-8-unix"

export HAXE_STD_PATH='/usr/lib/haxe/std/'


gcloud_sdk_loader="$HOME/.gcloud/google-cloud-sdk/path.zsh.inc"
# The next line updates PATH for the Google Cloud SDK.
if [ -f $gcloud_sdk_loader ]; then source $gcloud_sdk_loader; fi

gcloud_completion_loader="$HOME/.gcloud/google-cloud-sdk/completion.zsh.inc"
# The next line enables shell command completion for gcloud.
if [ -f $gcloud_completion_loader ]; then source $gcloud_completion_loader; fi

