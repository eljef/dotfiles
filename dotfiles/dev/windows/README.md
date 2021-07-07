# Dev Dot Files

Development configuration file installers for Windows.

## Script Purpose

* `00_configure_neovim.ps1`
  * **OPTIONAL**
  * Requires: `base/windows/00_configure_neovim.ps1`
  * Configures neovim for usage as a development editor

* `01_configure_git.ps1`
  * **OPTIONAL**
  * Configures base git settings

* `02_configure_golang.ps1`
  * **OPTIONAL**
  * Configures:
    * Windows environment settings
    * Neovim plugins

* `03_install_golang_tools.ps1`
  * **OPTIONAL**
  * Requires: `02_configure_golang.ps1`
  * Installs golang tools I use for linting and code analysis.
  * **NOTE**
    * Can be rerun to update installed tools.
