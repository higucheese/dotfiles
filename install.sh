#!/bin/bash

installs=(\
    "init.el ${HOME}/.emacs.d/init.el"\
    "nvim ${HOME}/.config/nvim"\
    ".tmux.conf ${HOME}/.tmux.conf"\
    ".vimrc ${HOME}/.vimrc"\
    ".zshrc ${HOME}/.zshrc"\
    ".bashrc ${HOME}/.bashrc"\
    ".common_config.sh ${HOME}/.common_config.sh"\
    "jupyter_notebook_config.py ${HOME}/.jupyter/jupyter_notebook_config.py"\
    ".xinitrc ${HOME}/.xinitrc"\
    ".gitignore_global ${HOME}/.gitignore_global"\
    "alacritty ${HOME}/.config/alacritty"\
)

dirs=(".emacs.d" ".config" ".jupyter")

for dir in "${dirs[@]}"
do
    mkdir -p "${HOME}/${dir}"
done

script_path=$(cd $(dirname $0); pwd)

for install in "${installs[@]}"
do
    ln -si ${script_path}/${install}
done
