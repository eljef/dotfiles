# Arch Linux

The following scripts can be used to setup and configure an Arch Linux system.
These scripts should be run before general Linux configuration and installer
scripts.

* `00_install-arch-eljef-repo.sh`
  * **Required**
  * Installs necessary packages to add the ElJef Arch Linux Repository.
* `01_install-arch-packages.sh`
  * **Required**
  * Installs software packages necessary to use Arch Linux.
* `02_install-arch-pip-modules.sh`
  * **Required**
  * Installs pip modules that do not have an official or unofficial package.
* `03_install-arch-as-vbox-guest.sh`
  * **Optional**
  * If running Arch Linux as a VirtualBox guest, use this script.
  * This script installs guest addons and enables necessary services.
* `04_install-arch-xinit.sh`
  * **Optional**
  * This script enables KDE to run when using startx.
  * This script should be run as the user needing to use KDE.
* `05_install-archrepo.sh`
  * **Optional**
  * This script installs scripts that help to maintain an Arch Linux Repository.
  * This script should be run as the user needing to use the archrepo scripts.

