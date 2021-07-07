# Windows Base Installers

Windows base installer scripts

## Script Purpose

* `00_install_update_powershellget.ps1`
  * **REQUIRED**
  * Installs NuGet and PowershellGet

* `01_install_update_powershell_modules.ps1`
  * **REQUIRED**
  * Installs / Updates PSReadline, posh-git, Get-ChildItemColor, and PsIni

* `02_install_chocolatey.ps1`
  * **REQUIRED**
  * Installs the chocolatey package manager

* `03_install_base_required.ps1`
  * **REQUIRED**
  * Installs basic programs used by all scripting and other programs
