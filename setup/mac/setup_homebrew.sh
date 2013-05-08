#!/bin/sh

# homebrew
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

# must
brew install python --with-brewed-openssl
brew install mercurial

brew install readline

brew install --disable-etcdir zsh
brew install zsh-completions

echo 'if you want to use zsh installed from homebrew, have to append its path on /etc/shells.'
echo ''

brew install vim --override-system-vi --with-lua --with-ruby --with-python --with-python3 

for pkg in "automake" "autoconf" "openssl" "sqlite"
do
    brew install $pkg
done

# commons
for pkg in "git" "coreutils" "gnu-sed" "wget" "gawk" "boost"
do
    brew install $pkg
done

# utils
for pkg in "reattach-to-user-namespace" "tig" "source-highlight" "colordiff" "autojump"
do
    brew install $pkg
done

for pkg in "tmux" "ctags" "the_silver_searcher" "sl"
do
    brew install $pkg
done

brew install ruby --with-doc
brew install ruby-build

mkdir ~/Applications
brew linkapps

sl

