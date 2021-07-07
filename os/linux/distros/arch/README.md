# Arch Linux

Arch Linux installation scripts

## Script Purpose

* `00_configure_pacman.sh`
  * **REQUIRED**
  * Configures pacman options
  * Can add trusted keys to the pacman keyring

* `01_add_eljef_repos.sh`
  * **REQUIRED**
  * Adds the ElJef Arch Linux Repositories
  * Adds the ElJef PGP Key used for signing packages

* `02_install_base_packages.sh`
  * **REQUIRED**
  * Installs base packages that I use for everything

* `03_install_dev_packages.sh`
  * **OPTIONAL**
  * Installs packages used for development

* `04_install_vbox_guest.sh`
  * **OPTIONAL**
  * Installs virtual box guest additions

* `05_install_gui_packages.sh`
  * **OPTIONAL**
  * Installs GUI packages required to run a WM and other applications

* `06_install_media_pakages.sh`
  * **OPTIONAL**
  * Installs media (audio / video / etc...) packages
