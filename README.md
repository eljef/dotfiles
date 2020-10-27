# dotfiles

The dotfiles that I like to be common across my setups.
Nothing special or out of the ordinary.

## Installing

I don't use anything to manage my dotfiles. I'm simple and uncultured. I use
scripts native to an OS to do my installs for me. You can read more about
each this in each installer script.

Installing will overwrite any current dotfiles you have. Make sure to backup
anything important.

After installing, you will need to log out and log back in.

## Installers

Installation scripts are located in the Linux and Windows directories.

## Extras

Some scripts and program configs I use on systems are stored in the `Extras`
directory.

## Arch Linux Repository Maintenance

I've included some scripts to help with maintaining an Arch Linux repository.
To install them, look at the associated documentation in `Linux/Arch`.

## dependencies

### git

Install your distributions packages for:

* diff-so-fancy

Run `Linux/04_install-git-options.sh`

### Conquer of Completion

Install your distributions packages for:

* node.js
* npm
* shellcheck

Install your distributions packages or use node/npm to install:

* bash-language-server
* markdownlint
* write-good

#### golang

Run `Linux/03_install-go-tools.sh`

#### python

You'll need to install your distributions packages for:

* python-black
* flake8
* pylint

#### neovim / vim

Run the associated script for configure neovim or vim, and the the associated
script to install the plugins.

## Customization

### yakuake

To configure the width of the main pain in the 2k split, you will need to export
`YAKUAKE_DEV_TERM_X` set to the width you desire. (In pixels)

To configure the height of the top right pain in the 2k split, you will need to
export `YAKUAKE_DEV_TERM_Y` set to the height you desire. (In pixels)

