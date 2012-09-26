#!/bin/sh
#動作テストしてないよてへぺろ☆
path=`pwd`
echo "$path"

mkdir ~/dotfilebackup

for i in { .vim .vimrc .gvimrc .zshenv .zsh .zprofile .pythonstartup .tmux.conf .gitconfig .gitignore };
do
        mv ~/"$i" ~/dotfilebackup/"$i".org
done

echo "move orig-files to ~/dotfilebackup/*"

mkdir -p ~/.vimcache/bak/
mkdir ~/.vimcache/vimswap/

# 汚い…
ln -s "$path"/.vimrc ~/.vimrc
ln -s "$path"/.gvimrc ~/.gvimrc
ln -s "$path"/.zsh ~/.zsh
ln -s "$path"/.zprofile ~/.zprofile
ln -s "$path"/.zshenv ~/.zshenv
ln -s "$path"/.zshrc ~/.zshrc
ln -s "$path"/.pythonstartup ~/.pythonstartup
ln -s "$path"/.tmux.conf ~/.tmux.conf
ln -s "$path"/.gitignore ~/.gitignore
ln -s "$path"/.sheets ~/.sheets
touch ~/.gitconfig
cat "$path"/git_globalconfig >> ~/.gitconfig
touch ~/.gitconfig.local

ln -s "$path"/.vim ~/.vim
#ln -s "$path"/.vim/syntax ~/.vim/syntax
#ln -s "$path"/.vim/neobundle.vim ~/.vim/neobundle.vim
#ln -s "$path"/.vim/colors ~/.vim/colors
#ln -s "$path"/.vim/.netrwhist ~/.vim/.netrwhist
#ln -s "$path"/.vim/templates ~/.vim/templates

