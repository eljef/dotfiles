# GUI Dot Files

GUI configuration files installers for Linux.

## Script Purpose

* `00_install_fonts.sh`
  * **REQUIRED**
  * Installs fonts I use
  * Installs fontconfig rules for the following:
    * Sets FiraCode Nerd Font as the preferred font where possible
      * The monospace variant is used for fixed width
    * Sets Hack Nerd Font as the secondary preferred font
      * The monospace variant is used for fixed width
    * Make sure Noto Mono Color Emoji is enabled and usable

* `01_configure_default_cursor.sh`
  * **OPTIONAL**
  * Sets the default cursor theme to GT3

* `02_configure_kde.sh`
  * **OPTIONAL**
  * Configures default settings for KDE
    * Sets default browser to Firefox
    * Disables 'Single Click'
      * In favor of double click for everything
    * Sets dolphin to show the full path in the address bar
    * Sets the default dolphin address bar to an editable one
    * Disables the dolphin option to remember opened tabs

* `03_configure_konsole.sh`
  * **OPTIONAL**
  * Adds the dracula theme to konsole
  * Adds a default main configuration to konsole

