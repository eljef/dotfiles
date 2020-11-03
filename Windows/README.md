# Windows

This folder holds configurations and scripts for Windows 10 and various programs that I use regularly in Windows.

## Installers

* Installers must be run first
* To run the installers:
  * `Set-ExecutionPolicy RemoteSigned`
    * This requires remote scripts to be signed, but local ones to run without signatures
* Installers need to be ran in order.
* Optional installers must be run after `02_install_chocolatey.ps1`
* Optional installers can be run in any order, except for installers that contain multiple parts.
  * ie: `01a_development.ps1` and `01b_development.ps1`

## Applications

This folder holds configurations and packages for Windows specific applications.

## Enablers

This folder holds scripts to enable Windows features that might be wanted.

## Fonts

This folder holds Windows specific versions of the fonts I like to use.

## PowerShell

This folder holds PowerShell modules and the profile I use in powershell. This folder is for use with powershell-core / powershell-7.

* To install:
  * Run `installers/01_powershell_modules.ps1` in powershell-core / powershell-7.
  * Copy folder to `<%USERPROFILE%>\Documents\`

## Registry

This folder holds registry to enable or disable features in Windows.

## Uninstallers

This folder holds scripts to remove default applications built into Windows 10.

