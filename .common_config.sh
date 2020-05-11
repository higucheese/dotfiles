### alias ###
if [ `command -v git` ]; then
    alias lg='git log --no-merges --date=short --pretty="format:%C(yellow)%h %C(green)%cd %C(blue)%an%C(red)%d %C(reset)%s"'
    alias lgg='git log --graph --pretty=oneline --decorate --abbrev-commit --name-status'
fi
if [ `command -v xdg-open` ]; then
    alias open='xdg-open'
fi
if [ `command -v nvim` ]; then
    export EDITOR="nvim"
    alias vi='nvim'
    alias vim='nvim'
else
    export EDITOR="vi"
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

