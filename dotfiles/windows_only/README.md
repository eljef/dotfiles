# Windows Applications

This folder holds configurations, installers, themes, etc... for applications I
use on Windows.

## Applications

* **CursorFX**
  * Cursor theme for CursorFX
* **MediaMonkey**
  * Skin for MediaMonkey
* **Notepad++**
  * Install script for Notepad++ plugins
  * Dracula theme from <https://github.com/dracula/notepad-plus-plus>
  * Installer script for Dracula theme
  * Configuration script for Notepad++ and plugins
  * Installer script to add environment variables to powershell
* **OpenSSH**
  * `00_upgrade_ssh.ps1`
    * Updates the built-in Windows SSH client utilities
  * `01_set_ssh_environment_variables.ps1`
    * Sets required environment variables
      * Variables are system-wide, so they can be overridden by individual
        users.
* **PowerShell**
  * To be used with powershell-core.
  * To install:
    * **REQUIRES**
      * `00_installers_base/04_install_update_powershell_core_modules.ps1`
        * Script might need to be run in powershell-core as well
    * Run `configure_powershell_core.ps1`
* **WindowsBlinds**
  * WindowsBlinds theme.
* Windows Terminal
  * Run `configure-windows-terminal.ps1`
    * Must be run with powershell-core
  * Installs the dracula color scheme
