# Dev Dot Files

Development configuration files installers for Linux.

## Script Purpose

* `00_configure_bash.sh`
  * **REQUIRED**
  * Requires: `base/01_configure_bash.sh`
  * Configures bash to include script
    * read-md
      * Script, backended by glow, to read md files on the command line

* `01_configure_tmux.sh`
  * **OPTIONAL**
  * Requires: `base/01_configure_tmux.sh`
  * Configures TMUX to show the current git branch in the window pane

* `02_configure_neovim.sh`
  * **OPTIONAL**
  * Requires: `base/01_configure_neovim.sh`
  * Configures neovim for usage as a development editor

* `03_configure_git.sh`
  * **OPTIONAL**
  * Configures base git settings

* `04_configure_golang.sh`
  * **OPTIONAL**
  * Requires: `01_configure_bash.sh`
  * Configures:
    * BASH environment exports
    * Neovim plugins

* `05_install_golang_tools.sh`
  * **OPTIONAL**
  * Requires: `04_configure_golang.sh`
  * Installs golang tools I use for linting and code analysis.
  * **NOTE**
    * Can be rerun to update installed tools.

* `06_configure_rust.sh`
  * **OPTIONAL**
  * Requires: `01_configure_bash.sh`
  * Configures:
    * BASH environment exports
    * Base rust toolchain installer

* `07_install_rust_tools.sh`
  * **OPTIONAL**
  * Requires: `06_configure_rust.sh`
  * Installs rust toolchain and RLS tools.
  * **NOTE**
    * Can be rerun to update toolchain, but you could just use the rust tools.
