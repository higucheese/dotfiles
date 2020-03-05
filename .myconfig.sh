### PATH ###
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

### alias ###
if [ `command -v git` ]; then
    alias lg='git log --no-merges --date=short --pretty="format:%C(yellow)%h %C(green)%cd %C(blue)%an%C(red)%d %C(reset)%s"'
    alias lgg='git log --graph --pretty=oneline --decorate --abbrev-commit --name-status'
fi
if [ `command -v xdg-open` ]; then
    alias open='xdg-open'
fi
if [ `command -v nvim` ]; then
    alias vi='nvim'
    alias vim='nvim'
fi

# Ask before deleting files
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Show outputs in color
alias grep='grep --color=auto'
if [ `command -v colordiff` ]; then
    alias diff='colordiff -u'
else
    alias diff='diff -u --color'
fi

# Some shortcuts for different directory listings
alias ls='ls -hF --color=auto' # classify files in colour
alias ll='ls -tl'              # long list sorted with created time
alias la='ls -A'               # all but . and ..

### LANG ###
export LANG=ja_JP.UTF-8 # Alacritty使用時の文字化け防止

