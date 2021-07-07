# Dev Dot Files

Development Configuration Files

The `files` directory contains the actual dotfiles.

## BASH

* Adds `read-md` to `~/Bin`
  * Read Markdown files on the CLI

## Neovim

* Adds development plugins to neovim
  * Filetype configurations
  * Omnifunc
  * COC and plugins
    * css
    * diagnostic
    * docker
    * highlight
    * html
    * json
    * markdownlint
    * python
    * sh
    * tsserver
    * vetur
    * yaml

## TMUX

* Adds script to `~/Bin` to determine if current directory is in a git repo
  and what branch it is set to
* Replaces `~/.config/tmux/pane-border-format.conf`
  * Shows git branch in border format

## Git

* Configures git with settings I use

## Golang

* Installs golang tools I use for code analysis and linting
* Installs plugins for neovim

## RUST
* Installs rust toolchain and tools
* Installs neovim plugin coc-rls
