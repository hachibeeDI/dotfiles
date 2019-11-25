# dotfiles

### myconfig files.

 - vim

     + .vimrc

     + .vim/

 - zsh

     + .zshrc

     + .zshenv

     + .zprofile

     + .zsh/

 - tmux

     + .tmux.conf

     + .tmux.d/

 - sheets

     + .sheets/

 - git

     + git_globalconfig

 - python

     + .pythonstartup


## How to use

```sh
$ git clone git@github.com:hachibeeDI/dotfiles.git

$ ./dotfiles/makeenv.sh
```

### Setup VSCode

```sh
$ ln -s $(pwd)/vscode/settings.json  ~/Library/ApplicationSupport/Code/User/
$ ln -s $(pwd)/vscode/keybindings.json  ~/Library/ApplicationSupport/Code/User/
$ cat vscode/extensions |xargs -L1 code --install-extension

```
