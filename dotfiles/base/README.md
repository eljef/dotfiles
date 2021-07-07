# Base Dot Files

Base Configuration Files

The `files` directory contains the actual dotfiles.

## BASH

**This is Linux only.**

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

Configures neovim via multiple configuration files that are sourced from
`init.vim`. The init checks if the development config exists and loads it
if it does.

## TMUX

Configures TMUX via it's main configuration file to load leaf configurations
from `~/.config/tmux/`.
