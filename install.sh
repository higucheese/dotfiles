#!/bin/bash

dirs=(".emacs.d" ".config/nvim" ".vim/colors" ".config/nvim/colors")

for dir in "${dirs[@]}"
do
    mkdir -p "${HOME}/${dir}"
done

dotfiles="${HOME}/dotfiles"
ln -si ${dotfiles}/init.el ${HOME}/.emacs.d
ln -si ${dotfiles}/.tmux.conf ${HOME}/.tmux.conf
ln -si ${dotfiles}/init.vim ${HOME}/.config/nvim
ln -si ${dotfiles}/.vimrc ${HOME}/.vimrc
ln -si ${dotfiles}/.zshrc ${HOME}/.zshrc
ln -si ${dotfiles}/.zshrc.linux ${HOME}/.zshrc.linux
ln -si ${dotfiles}/.bashrc ${HOME}/.bashrc
ln -si ${dotfiles}/vim/vim-hybrid/colors/hybrid.vim ${HOME}/.config/nvim/colors/hybrid.vim
ln -si ${dotfiles}/vim/vim-hybrid/colors/hybrid.vim ${HOME}/.vim/colors/hybrid.vim
