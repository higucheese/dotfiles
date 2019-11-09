# PATHの設定
PATH=${HOME}/.local/bin:${HOME}/usr/bin:${PATH}
if [ -d ${HOME}/.cargo ]; then # rust
    PATH=${HOME}/.cargo/bin:${PATH}
fi
if [ -d /usr/local/cuda ]; then # cuda
    PATH=/usr/local/cuda/bin:${PATH}
fi
if [ -d /usr/lib/llvm-6.0 ]; then # llvm
    PATH=/usr/lib/llvm-6.0/bin:${PATH}
    export CPLUS_INCLUDE_PATH=/usr/lib/llvm-6.0/include:${CPLUS_INCLUDE_PATH}
fi
if [ -d ${HOME}/anaconda3 ]; then # anaconda3
    PATH=${HOME}/anaconda3/bin:${PATH}
    . ${HOME}/anaconda3/etc/profile.d/conda.sh
elif [ -d ${HOME}/anaconda2 ]; then # anaconda2
    PATH=${HOME}/anaconda2/bin:${PATH}
    . ${HOME}/anaconda2/etc/profile.d/conda.sh
fi
if [ -d ${HOME}/virtualenv ]; then # virtualenv
    PATH=${HOME}/virtualenv:${PATH}
    if [ -f ${HOME}/.local/bin/virtualenvwrapper.sh ]; then
        VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
        export WORKON_HOME=${HOME}/virtualenvs
        source ${HOME}/.local/bin/virtualenvwrapper.sh
    fi
fi
if [ -d /usr/local/go ]; then # go
    export GOPATH=${HOME}/go
    PATH=/usr/local/go/bin:${GOPATH}/bin:${PATH}
fi
export PATH

# LD_LIBRARY_PATH
if [ -d $HOME/opt/OpenBLAS ]; then
    LD_LIBRARY_PATH=$HOME/opt/OpenBLAS/lib:$LD_LIBRARY_PATH
fi
if [ -d $HOME/opt/CLBlast ]; then
    LD_LIBRARY_PATH=$HOME/opt/CLBlast/lib:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

# 便利コマンド
function cl() {
  builtin cd $@ && ls;
}
function emacl(){
    emacsclient -n $@;
    if [ $? -ne 0 ]; then
        /usr/bin/emacs $@ &
    fi
}

## alias
if [ -x "$(command -v git)" ]; then
    alias lg='git log --no-merges --date=short --pretty="format:%C(yellow)%h %C(green)%cd %C(blue)%an%C(red)%d %C(reset)%s"'
    alias lgg='git log --graph --pretty=oneline --decorate --abbrev-commit --name-status'
fi
if [ -x "$(command -v xdg-open)" ]; then
    alias open='xdg-open > /dev/null 2>&1'
fi
if [ -d /opt/firefox ]; then
    alias firefox='/opt/firefox/firefox-bin'
fi
if [ -x "$(command -v nvim)" ]; then
    alias v='nvim'
    alias vi='nvim'
    alias vim='nvim'
fi
alias diff='diff --color'

# 設定の再読込
if [ -d ${HOME}/.xinitrc ]; then
    source ${HOME}/.xinitrc
fi
