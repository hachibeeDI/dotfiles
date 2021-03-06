#!/bin/sh

dotfile_path=`pwd`
echo "$dotfile_path"

mkdir ~/dotfilebackup

for i in { .vim .vimrc .gvimrc .zshenv .zsh .zprofile .pythonstartup .tmux.conf .gitconfig .gitignore .ctags };
do
    [[ -s "$i" ]] && mv ~/"$i" ~/dotfilebackup/"$i".org
done

echo "move orig-files to ~/dotfilebackup/*"

mkdir -p ~/.vimcache/bak/
mkdir ~/.vimcache/vimswap/
mkdir ~/.vimcache/undo/

# for cdr is contlib script of zsh
mkdir -p ~/.cache/shell


ln -s "$dotfile_path"/.vimrc ~/.vimrc
mkdir -p ~/.config
ln -s "$dotfile_path"/.vim ~/.config/nvim
touch ~/.vimrc.local
ln -s "$dotfile_path"/.gvimrc ~/.gvimrc
ln -s "$dotfile_path"/.zsh ~/.zsh
ln -s "$dotfile_path"/.zprofile ~/.zprofile
ln -s "$dotfile_path"/.zshenv ~/.zshenv
ln -s "$dotfile_path"/.zshrc ~/.zshrc
ln -s "$dotfile_path"/.pythonstartup ~/.pythonstartup
ln -s "$dotfile_path"/.tmux.conf ~/.tmux.conf
ln -s "$dotfile_path"/.gitignore ~/.gitignore
ln -s "$dotfile_path"/.sheets ~/.sheets
ln -s "$dotfile_path"/.ctags ~/.ctags
ln -s "$dotfile_path"/.agignore ~/.agignore
ln -s "$dotfile_path"/.xremap.conf ~/.xremap.conf
ln -s "$dotfile_path"/alacritty ~/.config/alacritty

ln -s "$dotfile_path"/git_globalconfig ~/.gitconfig
touch ~/.gitconfig.local

ln -s "$dotfile_path"/.vim ~/.vim
ln -s "$dotfile_path"/.peco/ ~/.peco
ln -s "$dotfile_path"/.tmux ~/.tmux

ln -s "$dotfile_path"/.zsh/modules/LS_COLORS/LS_COLORS ~/.dircolors

git submodule init && git submodule update

