### Environment ###
case "${OSTYPE}" in
    darwin*)
        if [ `command -v brew` ]; then
            # GNUのcoreutilsを使う
            export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
        else
            echo "Install Homebrew and coreutils to use GNU commands"
        fi
    ;;
esac

### Keybind ###
bindkey -e # emacs風のキーバインドを使う
EDITOR="vi"

### Zsh History ###
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

### Completion ###
autoload -Uz compinit; compinit
setopt auto_list   # 補完候補を一覧で表示する(d)
setopt auto_menu   # 補完キー連打で補完候補を順に表示する(d)
setopt correct     # コマンドのスペルを訂正する
setopt list_packed # 補完候補をできるだけ詰めて表示する
setopt list_types  # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)" # 環境変数LS_COLORSをセットする (GNUのcoreutils依存)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # ファイル補完候補に色をつける
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
function change_title () {
    print -Pn "\e]0;%n@%m: %~\a" # windowのタイトルを更新する
}
add-zsh-hook precmd change_title
PROMPT="%K{blue}%n@%m%k %B%F{yellow}[%T] %F{green}%44<...<%~
 %(?.%F{white}.%F{red})%# %f%b"
SPROMPT="%F{cyan}%r is correct? [Yes, No, Abort, Edit]:%f"

### Local Settings ###
[ -f ${HOME}/.common_config.sh ] && source ${HOME}/.common_config.sh
[ -f ${HOME}/.local_config.sh ] && source ${HOME}/.local_config.sh
