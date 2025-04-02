# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

### Bash History ###
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=1000

### Completion ###
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

### Prompt ###
user_at_machine="\[\e[01;32m\]\u@\h\[\e[m\]"
cwd="\[\e[01;34m\]\w\[\e[m\]"
PS1="${user_at_machine}:${cwd}\$ "

### Local Settings ###
[ -f ${HOME}/.common_config.sh ] && source ${HOME}/.common_config.sh
[ -f ${HOME}/.local_config.sh ] && source ${HOME}/.local_config.sh
