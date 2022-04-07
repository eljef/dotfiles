# Windows Application Installers

Windows application installer scripts

## Script Purpose

* `00_install_base_apps.ps1`
  * **REQUIRED**
  * Installs powershell-core and Windows Terminal

* `01_install_neovim.ps1`
  * **OPTIONAL**
  * Installs neovim

* `02a_install_development_apps.ps1`
  * **OPTIONAL**
  * (Required if you want to run `02b_install_development_apps.ps1`)
  * Installs development apps via chocolatey

* `02b_install_development_apps.ps1`
  * **OPTIONAL**
  * Installs development apps via npm

* `03_install_multimedia.ps1`
  * **OPTIONAL**
  * Installs multimedia applications

* `04_install_network.ps1`
  * **OPTIONAL**
  * Installs applications that operate over a network

* `05_install_streaming.ps1`
  * **OPTIONAL**
  * Installs obs-studio for streaming

* `06_install_browser.ps1`
  * **OPTIONAL**
  * Installs browsers

* `07_install_jetbrains.ps1`
  * **OPTIONAL**
  * Installs jetbrains toolbox

* `08_install_uto;s.ps1`
  * **OPTIONAL**
  * Installs utilities for working on Windows
