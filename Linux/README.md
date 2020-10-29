# Linux

The following scripts can be used to setup and configure a Linux system.
Distribution specific scripts are located in sub-directory. Documentation
for distributions can be found in the respective sub-directory.

## Order of Operations

Distribution specific scripting should be run before general customization
scripts, unless noted otherwise in the distribution specific documentation.

### After Distribution Specific Actions

* `00_install-dot-files.sh`
  * Installs all base dot files.
* `01_config-neovim.sh` / `01_config-vim.sh`
  * Installs dot files for neovim, or vim, respectively.
* `02_install-neovim-plugins.sh` / `02_install-vim-plugins.sh`
  * Installs plugins for neovim, or vim, respectively.
* `03_install-go-tools.sh`
  * Installs go specific formatters, linters, and testers to the defined GOPATH.
  * This script can be used to update already installed tools as well.
* `04_install-git-options.sh`
  * Configures git.
* `05_config-set-defaults.sh`
  * Configures defaults settings in multiple programs and window managers.
* `06-config-enable-jetbrains-startup-script.sh`
  * Enables a startup script the jetbrains toolbox.
  * This is an alternative to the default startup shortcut created.
  * The default startup mechanism must be disabled in the toolbox's settings.

