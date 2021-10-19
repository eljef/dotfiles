# Extras Dot Files

Extras configuration files installers for Linux.

## Arch Repo

* Install with `00_install_archrepo.sh`

This installs scripts that are used to maintain an Arch Linux repository.

To properly use these scripts, environment variables will need to be set. The
easiest way to do this is to create a file in ~/.bash_exports with the following
information, replacing with your own.

```bash
#!/bin/bash

export ARCHREPO_CHROOT="/home/dev/chroot"
export ARCHREPO_GITS="/home/dev/arch_gits"
export ARCHREPO_GPG_ID="SOME-PGP-KEY-ID"
export ARCHREPO_REPO_BASE="/home/dev/arch"
export ARCHREPO_REPO_REMOTE="someone@somewhere.come:/path/to/http/for/arch/repo"
```

* ARCHREPO_CHROOT
  * The path used for the clean chroot to build packages in.
* ARCHREPO_GITS
  * The path used for storing git repos from the Arch Linux AUR.
* ARCHREPO_GPG_ID
  * The PGP Key ID to use for signing packages.
* ARCHREPO_REPO_BASE
  * The base path on the local system to merge newly compiled packages into.
* ARCHREPO_REPO_REMOTE
  * The path to the remote system to sync completed repo updates to.

### Order of Operations

* archrepo-add-aur
  * Add an AUR git repo to the local cache
* archrepo-update-aur-gits
  * Update all locally stored AUR git repos
* archrepo-chroot-build
  * Build an AUR package in a clean chroot
* archrepo-sign-and-move
  * Sign the newly built AUR packages and move them to the local repo cache
* archrepo-sync
  * Sync te local repo cache with the remote repository

## Conky

* Install with `01_configure_conky.sh`

This installs all configuration files in `~/.config/conky/`

Edit the configuration files, replacing `[{disk_path}]`, `[{fs_path}]` and
`[{net_interface}]` tags with the information for the system. Edit the CPU
percentages and the temperatures, making sure the number of cores is correct
and that the processor model sed commands are correct.

If you want to script the startup of conky, place the conky-start bash script
in your `$PATH` after editing it to contain the paths for your system. Then
symlink it in `~/.config/autostart-scripts`.

To properly use the conky2 script for weather, you will need to obtain an API
key from [OpenWeather](https://openweathermap.org). The API key and city
ID for the area you want temperatures from will need to be added to the
conky2.conf file.
