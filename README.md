# dotfiles

The dotfiles that I like to be common across my setups.
Nothing special or out of the ordinary.

## Initialization

Run `./install.py --modules-init` to pull dependencies.

## Installing

I don't use anything to manage my dotfiles. I'm simple and uncultured. I use a
Python script to install them. You can too with `./install.py --install`.

The install script requires Python 3.6 or newer.

Installing will overwrite any current dotfiles you have. Make sure to backup
anything important.

After installing, you will need to log out and log back in.

## scripts

I've also included some scripts that I use for setting up systems and keeping
them up-to-date for my development purposes.

## vim alias

By default, dotfiles assumes you are using neovim. If you would like to alias
vim to always open neovim, run `./install.py --install-vim-alias`

## vim

If you are using vim instead of neovim, you can setup vim for usage by running
`./install.py --install-vim`

## Arch Linux Repository Maintenance

I've included some scripts to help with maintaining an Arch Linux repository.
To install them, run `./install.py --install-archrepo`

## dependencies

### git

Install your distributions packages for:

* diff-so-fancy

Run `install-git-options`

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

Run `install-go-tools`

#### python

You'll need to install your distributions packages for:

* python-black
* flake8
* pylint

#### neovim-coc

Run `install-coc-extensions nvim`

#### vim-coc

Run `install-coc-extensions vim`

Note: This will take a while to run. During running, the screen will appear blank.

## Customization

### yakuake

To configure the width of the main pain in the 2k split, you will need to export
`YAKUAKE_DEV_TERM_X` set to the width you desire. (In pixels)

To configure the height of the top right pain in the 2k split, you will need to
export `YAKUAKE_DEV_TERM_Y` set to the height you desire. (In pixels)

## Extras

### Scripts

Extra random scripts that can be used for various tasks. These must be manually
copied into the $PATH. (~/Bin)
