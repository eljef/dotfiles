# dotfiles

The dotfiles that I like to be common across my setups.
Nothing special or out of the ordinary.

## Installing

### Notes

* Installing will overwrite any current dotfiles you have. Make sure to backup
anything important.

* After installing, you will need to log out and log back in.

### Installers

Installation scripts are separated in a way to allow for installation of
different groups or application specific configurations. These scripts are
operating system specific and require no extra dependencies to be installed
in order to run.

The operating system specific configuration scripts install packages that I
typically use for things.

Operating System specific configuration script locations:

* os/{os_type}
  * eg:
    * os/linux
    * linux is further separated into distros
    * eg:
      * os/linux/arch

Program configuration settings (dotfiles) installation scripts install the
configurations for different programs I use. I tried to break up these
configurations in ways that allow for both regular and development environments,
as well as running on different operating systems.

dotfiles installation script locations:

* dotfiles/group/os
  * eg:
    * dotfiles/base/linux

Each installer location contains a README.md that further explains the
installation scripts.

### Fonts

Fonts are provided by the [Nerd Fonts](https://www.nerdfonts.com/)
project. (Not Affiliated)

[Nerd Fonts on Github]((https://github.com/ryanoasis/nerd-fonts)

* [Caskaydia Code](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode)
* [Fira Code](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
* [Hack](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)
