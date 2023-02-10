# Base Dot Files

Base Configuration Files

The `files` directory contains the actual dotfiles.

## BASH

> **_NOTE:_** Linux Only

Configures BASH how I like it.

* `~/.bashrc`
  * Loads system-wide defaults
  * Adds `~/Bin` to `$PATH`
  * Sets `$BASH_COMPLETION_USER_DIR` to `${HOME}/.local/share/bash-completion`
  * Loads configs from `${HOME}/.bash_exports`
* `~/.bash_profile`
  * Loads `~/.bashrc`
* `~/profile`
  * Loads `~/.bashrc`
* `~/bash_exports`
  * Individual aliases and exports can be placed in this directory
  * Will be sourced at startup
* `Bin/include/eljef-bash-common`
  * Common functions I use in my scripts
* `Bin/fix-perms`
  * Fixes directory and file permissions in a folder

## Neovim

> **_NOTE:_** Linux and Windows

Configures neovim via multiple configuration files that are sourced from
`init.vim`. The init checks if the development config exists and loads it
if it does.

## TMUX

> **_NOTE:_** Linux Only

Configures TMUX via it's main configuration file to load leaf configurations
from `~/.config/tmux/conf.d`.

The configurations require the terminal emulator that is running tmux is using
a font with powerline support. Powerline specific fonts or Nerd fonts work.

Extra configurations can be added to `~/.config/tmux/conf.d/` and they will be
loaded by the default configuration file.
