# dotfiles: user's configuration files

## Install

Run this following command.
If there were existing settings, the script ask you to replace them or not.

```sh
$ git clone --recursive [this repo's url]
$ ./install.sh
```

## Info

### deoplete.nvim

[deoplete](https://github.com/Shougo/deoplete.nvim/)

Case of failure:

 - at nvim: `:UpdateRemotePlugins`
 - at shell: `pip3 install --upgrade neovim --user`

### nvim/syntax

To install new syntax:

```sh
$ cd nvim/syntax && ln -s /path/sample.vim
```
