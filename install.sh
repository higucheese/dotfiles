#!/bin/bash

dirs=(".emacs.d" ".config/nvim")

for dir in "${dirs[@]}"
do
    mkdir -p "${HOME}/${dir}"
done

dotfiles="${HOME}/dotfiles"
ln -si ${dotfiles}/init.el ${HOME}/.emacs.d
ln -si ${dotfiles}/init.vim ${HOME}/.config/nvim
ln -si ${dotfiles}/.tmux.conf ${HOME}/.tmux.conf
ln -si ${dotfiles}/.zshrc ${HOME}/.zshrc
ln -si ${dotfiles}/.zshrc.linux ${HOME}/.zshrc.linux
ln -si ${dotfiles}/.bashrc ${HOME}/.bashrc
