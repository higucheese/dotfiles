#!/bin/bash

dirs=(".emacs.d" ".config" ".jupyter")

for dir in "${dirs[@]}"
do
    mkdir -p "${HOME}/${dir}"
done

dotfiles="${HOME}/dotfiles"
ln -si ${dotfiles}/init.el ${HOME}/.emacs.d/init.el
ln -si ${dotfiles}/nvim ${HOME}/.config/nvim
ln -si ${dotfiles}/.tmux.conf ${HOME}/.tmux.conf
ln -si ${dotfiles}/.vimrc ${HOME}/.vimrc
ln -si ${dotfiles}/.zshrc ${HOME}/.zshrc
ln -si ${dotfiles}/.bashrc ${HOME}/.bashrc
ln -si ${dotfiles}/.myconfig.sh ${HOME}/.myconfig.sh
ln -si ${dotfiles}/jupyter_notebook_config.py ${HOME}/.jupyter/jupyter_notebook_config.py
ln -si ${dotfiles}/.xinitrc ${HOME}/.xinitrc
ln -si ${dotfiles}/.gitignore_global ${HOME}/.gitignore_global
