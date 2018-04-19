/bin/sh

dirs=(".emacs.d" ".config/nvim")

for dir in "${dirs[@]}"
do
    mkdir -p "${HOME}/${dir}"
done

ln -s init.el ${HOME}/.emacs.d
ln -s init.vim ${HOME}/.config/nvim
ln -s .tmux.conf ${HOME}/.tmux.conf
ln -s .zshrc ${HOME}/.zshrc
ln -s .zshrc.linux ${HOME}/.zshrc.linux
ln -s .bashrc ${HOME}/.bashrc
ln -s .gitconfig ${HOME}/.gitconfig
