### Keybind ###
# EDITORがvimでもemacsのキーバインドを使う
bindkey -e
EDITOR="code"
BROWSER="firefox"

### Zsh History ###
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する
alias history='history -E'# 時刻を表示させる

### Completion ###
autoload -Uz compinit; compinit
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt correct           # コマンドのスペルを訂正する
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

### Prompt ###
autoload -Uz add-zsh-hook
autoload -Uz promptinit; promptinit
autoload -U colors; colors
if [[ $TERM = dumb ]]; then
    unset zle_bracketed_paste
fi
# autoload -Uz vcs_info
# setopt prompt_subst
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
# zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
# zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# add-zsh-hook precmd vcs_info
function change_title () {
    print -Pn "\e]0;%n@%m: %~\a"
}
add-zsh-hook precmd change_title
PROMPT="%K{027}%n@%m%k %B%F{green}%44<...<%~
%} %(?.%F{white}.%F{red})%# %b%f%k"
# RPROMPT='${vcs_info_msg_0_}'
RPROMPT="%F{cyan}[%*]%f"
SPROMPT="%{${fg[cyan]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

### Other Settings ###
# Interactive command
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Enable X forwarding
alias ssh='ssh -Y'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

### Local Settings ###
[ -f ${HOME}/.myconfig.sh ] && source ${HOME}/.myconfig.sh
