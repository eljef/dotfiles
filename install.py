#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
# Copyright (C) 2020 Jef Oliver.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
# SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
# IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# Authors:
# Jef Oliver <jef@eljef.me>
#
# install.py : Installation Script
"""Installation Script

Installation script for ElJef Dotfiles
"""

import argparse
import os
import shutil
import subprocess

from pathlib import Path

_VERSION = '1.7.2'
_HOME = str(Path.home())

_CMD_LINE_ARGS = [
    {'long': '--install',
     'opts': {'dest': 'install', 'action': 'store_true',
              'help': 'Install ElJef Dotfiles. (Does not include addons.)'}},
    {'long': '--install-archrepo',
     'opts': {'dest': 'install_archrepo', 'action': 'store_true',
              'help': 'Install Arch Linux repository maintenance scripts'}},
    {'long': '--install-vim',
     'opts': {'dest': 'install_vim', 'action': 'store_true',
              'help': 'Install configuration for vim'}},
    {'long': '--install-vim-alias',
     'opts': {'dest': 'install_vim_alias', 'action': 'store_true',
              'help': 'Install alias file for vim, aliasing vim to nvim'}},
    {'long': '--modules-init',
     'opts': {'dest': 'modules_init', 'action': 'store_true',
              'help': 'Initialize / Pull Git Submodules'}},
    {'long': '--modules-update',
     'opts': {'dest': 'modules_update', 'action': 'store_true',
              'help': 'Update Git Submodules to Upstream HEAD'}},
    {'long': '--version',
     'opts': {'dest': 'version_out', 'action': 'store_true',
              'help': 'Prints version and exists'}}
]

_INSTALL_GROUPS = {
    'archrepo': {
        'install_files': [
            {'dot': 'Arch/repo/archrepo-add-aur',
             'target': os.path.join(_HOME, 'Bin/archrepo-add-aur'),
             'exec': True},
            {'dot': 'Arch/repo/archrepo-chroot-build',
             'target': os.path.join(_HOME, 'Bin/archrepo-chroot-build'),
             'exec': True},
            {'dot': 'Arch/repo/archrepo-sign-and-move',
             'target': os.path.join(_HOME, 'Bin/archrepo-sign-and-move'),
             'exec': True},
            {'dot': 'Arch/repo/archrepo-update-aur-gits',
             'target': os.path.join(_HOME, 'Bin/archrepo-update-aur-gits'),
             'exec': True}
        ]
    },
    'bashcommon': {
        'create_dirs': [
            os.path.join(_HOME, '.bash_exports'),
            os.path.join(_HOME, 'Bin/include')
        ],
        'install_files': [
            {'dot': 'Bin/include/eljef-bash-common',
             'target': os.path.join(_HOME, 'Bin/include/eljef-bash-common')}
        ]
    },
    'bashexports': {
        'install_files': [
            {'dot': 'dotfiles/bash_exports/alias_grep',
             'target': os.path.join(_HOME, '.bash_exports/alias_grep')},
            {'dot': 'dotfiles/bash_exports/alias_ls',
             'target': os.path.join(_HOME, '.bash_exports/alias_ls')},
            {'dot': 'dotfiles/bash_exports/export_editor',
             'target': os.path.join(_HOME, '.bash_exports/export_editor')},
            {'dot': 'dotfiles/bash_exports/export_ps1',
             'target': os.path.join(_HOME, '.bash_exports/export_ps1')},
            {'dot': 'dotfiles/bash_exports/export_visual',
             'target': os.path.join(_HOME, '.bash_exports/export_visual')}
        ]
    },
    'binfiles': {
        'install_files': [
            {'dot': 'Bin/convert-to-mp3',
             'target': os.path.join(_HOME, 'Bin/convert-to-mp3'),
             'exec': True},
            {'dot': 'Bin/install-coc-extensions',
             'target': os.path.join(_HOME, 'Bin/install-coc-extensions'),
             'exec': True},
            {'dot': 'Bin/install-git-options',
             'target': os.path.join(_HOME, 'Bin/install-git-options'),
             'exec': True},
            {'dot': 'Bin/install-go-tools',
             'target': os.path.join(_HOME, 'Bin/install-go-tools'),
             'exec': True},
            {'dot': 'Bin/read-md',
             'target': os.path.join(_HOME, 'Bin/read-md'),
             'exec': True},
            {'dot': 'Bin/tmux-git-branch',
             'target': os.path.join(_HOME, 'Bin/tmux-git-branch'),
             'exec': True},
            {'dot': 'Bin/yakuake-init-session',
             'target': os.path.join(_HOME, 'Bin/yakuake-init-session'),
             'exec': True},
            {'dot': 'Bin/yakuake-send',
             'target': os.path.join(_HOME, 'Bin/yakuake-send'),
             'exec': True},
            {'dot': 'Bin/yakuake-split-dev-2k',
             'target': os.path.join(_HOME, 'Bin/yakuake-split-dev-2k'),
             'exec': True}
        ]
    },
    'dotfiles': {
        'install_files': [
            {'dot': 'dotfiles/bash_profile',
             'target': os.path.join(_HOME, '.bash_profile')},
            {'dot': 'dotfiles/bashrc',
             'target': os.path.join(_HOME, '.bashrc')},
            {'dot': 'dotfiles/profile',
             'target': os.path.join(_HOME, '.profile')},
            {'dot': 'dotfiles/tmux.conf',
             'target': os.path.join(_HOME, '.tmux.conf')},
            {'dot': 'dotfiles/tmux.dev.conf',
             'target': os.path.join(_HOME, '.tmux.dev.conf')},
            {'dot': 'dotfiles/tmux.split.conf',
             'target': os.path.join(_HOME, '.tmux.split.conf')},
            {'dot': 'dotfiles/tmux.split.2k.conf',
             'target': os.path.join(_HOME, '.tmux.split.2k.conf')}
        ]
    },
    'fonts': {
        'create_dirs': [
            os.path.join(_HOME, '.fonts')
        ],
        'install_files': [
            {'dot': 'dotfiles/fonts/Caskaydia Cove Nerd Font Complete Mono.ttf',
             'target': os.path.join(_HOME, '.fonts/Caskaydia Cove Nerd Font Complete Mono.ttf')},
            {'dot': 'dotfiles/fonts/Caskaydia Cove Nerd Font Complete.ttf',
             'target': os.path.join(_HOME, '.fonts/Caskaydia Cove Nerd Font Complete.ttf')},
            {'dot': 'dotfiles/fonts/Fira Code Bold Nerd Font Complete Mono.otf',
             'target': os.path.join(_HOME, '.fonts/Fira Code Bold Nerd Font Complete Mono.otf')},
            {'dot': 'dotfiles/fonts/Fira Code Bold Nerd Font Complete.otf',
             'target': os.path.join(_HOME, '.fonts/Fira Code Bold Nerd Font Complete.otf')},
            {'dot': 'dotfiles/fonts/Fira Code Light Nerd Font Complete Mono.otf',
             'target': os.path.join(_HOME, '.fonts/Fira Code Light Nerd Font Complete Mono.otf')},
            {'dot': 'dotfiles/fonts/Fira Code Light Nerd Font Complete.otf',
             'target': os.path.join(_HOME, '.fonts/Fira Code Light Nerd Font Complete.otf')},
            {'dot': 'dotfiles/fonts/Fira Code Medium Nerd Font Complete Mono.otf',
             'target': os.path.join(_HOME, '.fonts/Fira Code Medium Nerd Font Complete Mono.otf')},
            {'dot': 'dotfiles/fonts/Fira Code Medium Nerd Font Complete.otf',
             'target': os.path.join(_HOME, '.fonts/Fira Code Medium Nerd Font Complete.otf')},
            {'dot': 'dotfiles/fonts/Fira Code Regular Nerd Font Complete Mono.otf',
             'target': os.path.join(_HOME, '.fonts/Fira Code Regular Nerd Font Complete Mono.otf')},
            {'dot': 'dotfiles/fonts/Fira Code Regular Nerd Font Complete.otf',
             'target': os.path.join(_HOME, '.fonts/Fira Code Regular Nerd Font Complete.otf')},
            {'dot': 'dotfiles/fonts/Fira Code Retina Nerd Font Complete Mono.otf',
             'target': os.path.join(_HOME, '.fonts/Fira Code Retina Nerd Font Complete Mono.otf')},
            {'dot': 'dotfiles/fonts/Fira Code Retina Nerd Font Complete.otf',
             'target': os.path.join(_HOME, '.fonts/Fira Code Retina Nerd Font Complete.otf')},
        ]
    },
    'konsole': {
        'create_dirs': [
            os.path.join(_HOME, '.local/share/konsole')
        ],
        'install_files': [
            {'dot': 'dotfiles/local/share/konsole/dracula.colorscheme',
             'target': os.path.join(_HOME, '.local/share/konsole/dracula.colorscheme')},
            {'dot': 'dotfiles/local/share/konsole/Main.Profile',
             'target': os.path.join(_HOME, '.local/share/konsole/Main.profile')},
        ]
    },
    'nvim': {
        'create_dirs': [
            os.path.join(_HOME, '.config/nvim'),
        ],
        'delete_dirs': [
            os.path.join(_HOME, '.config/nvim/colors'),
            os.path.join(_HOME, '.config/nvim/pack')
        ],
        'install_dirs': [
            {'dot': 'dotfiles/vim/colors',
             'target': os.path.join(_HOME, '.config/nvim')},
            {'dot': 'dotfiles/vim/pack',
             'target': os.path.join(_HOME, '.config/nvim')}
        ],
        'install_files': [
            {'dot': 'dotfiles/config/nvim/init.vim',
             'target': os.path.join(_HOME, '.config/nvim/init.vim')},
            {'dot': 'dotfiles/coc-settings.json',
             'target': os.path.join(_HOME, '.config/nvim/coc-settings.json')}
        ]
    },
    'vim': {
        'create_dirs': [
            os.path.join(_HOME, '.vim')
        ],
        'delete_dirs': [
            os.path.join(_HOME, '.vim/colors'),
            os.path.join(_HOME, '.vim/pack')
        ],
        'install_dirs': [
            {'dot': 'dotfiles/vim/colors',
             'target': os.path.join(_HOME, '.vim')},
            {'dot': 'dotfiles/vim/pack',
             'target': os.path.join(_HOME, '.vim')}
        ],
        'install_files': [
            {'dot': 'dotfiles/coc-settings.json',
             'target': os.path.join(_HOME, '.vim/coc-settings.json')},
            {'dot': 'dotfiles/vimrc',
             'target': os.path.join(_HOME, '.vimrc')}
        ]
    },
    'vimalias': {
        'install_files': [
            {'dot': 'dotfiles/bash_exports/alias_vim',
             'target': os.path.join(_HOME, '.bash_exports/alias_vim')}
        ]
    },
    'yakuake': {
        'create_dirs': [
            os.path.join(_HOME, '.local/share/yakuake/kns_skins')
        ],
        'install_dirs': [
            {'dot': 'dotfiles/local/share/yakuake/kns_skins/pixelnine',
             'target': os.path.join(_HOME, '.local/share/yakuake/kns_skins')},
        ]
    }
}

_INSTALL_ORDER = ['bashcommon', 'bashexports', 'binfiles', 'dotfiles', 'fonts', 'konsole', 'nvim', 'yakuake',
                  'vim', 'vimalias', 'archrepo']


# pylint: disable=too-few-public-methods
class _ConsoleColors:
    ERROR = '\033[1;31m'
    HEADER = '\033[1;37m'
    INFO = '\033[1;36m'
    RESET = '\033[0m'
    SYMARROW = '\033[1;32m->\033[0m'
    SYMSTART = '\033[1;32m-|\033[0m'


class _Install:
    """Installation Class"""
    def __init__(self):
        self._to_install = {'will_run': False}
        for key in _INSTALL_GROUPS:
            self._to_install[key] = False

    def do_install(self) -> None:
        """Installs any requested groups."""
        if not self._to_install.get('will_run'):
            print(f" {_ConsoleColors.ERROR}\nNothing to do. Try --help\n{_ConsoleColors.RESET}")
            raise SystemExit(-1)

        current_install = 0
        while current_install < len(_INSTALL_ORDER):
            group = _INSTALL_ORDER[current_install]
            self._install_group(group, self._to_install.get(group, False))
            current_install += 1

        if self._to_install.get('fonts', False):
            self._run_fccache()

    def set_install(self, groupname):
        """Sets a group to be installed.

        Args:
            groupname: Group to install
        """
        self._to_install[groupname] = True
        self._to_install['will_run'] = True

    @staticmethod
    def _create_directory(path: str) -> None:
        """Creates a directory.

        Args:
            path: Path to directory to create
        """
        print(f" {_ConsoleColors.SYMSTART} {_ConsoleColors.HEADER}Create Directory:{_ConsoleColors.RESET}\t" +
              f"{_ConsoleColors.INFO}{path}{_ConsoleColors.RESET}")
        os.makedirs(path, mode=0o700, exist_ok=True)

    @staticmethod
    def _delete_directory(path: str) -> None:
        """Deletes a directory.

        Args:
            path: Path to directory to delete
        """
        if os.path.isdir(path):
            print(f" {_ConsoleColors.SYMSTART} {_ConsoleColors.HEADER}Delete Directory:{_ConsoleColors.RESET}\t" +
                  f"{_ConsoleColors.INFO}{path}{_ConsoleColors.RESET}")
            shutil.rmtree(path)

    @staticmethod
    def _install_directory(orig_dir: str, new_dir: str) -> None:
        """Installs a directory.

        Args:
            orig_dir: Directory to install
            new_dir: Path to install directory at
        """
        print(f" {_ConsoleColors.SYMSTART} {_ConsoleColors.HEADER}Install Directory:{_ConsoleColors.RESET}\t" +
              f"{_ConsoleColors.INFO}{orig_dir}{_ConsoleColors.RESET}" +
              f" {_ConsoleColors.SYMARROW} {_ConsoleColors.INFO}{new_dir}{_ConsoleColors.RESET}")
        target = os.path.join(new_dir, os.path.basename(orig_dir))
        os.makedirs(target, mode=0o700, exist_ok=True)
        shutil.copytree(orig_dir, target, dirs_exist_ok=True)

    @staticmethod
    def _install_file(orig_file: str, new_file: str, executable: bool = False) -> None:
        """Installs a file.

        Args:
            orig_file: File to install
            new_file: Where to install file to.
            executable: Does the file need to be executable.
        """
        print(f" {_ConsoleColors.SYMSTART} {_ConsoleColors.HEADER}Install File:{_ConsoleColors.RESET}\t" +
              f"{_ConsoleColors.INFO}{orig_file}{_ConsoleColors.RESET}" +
              f" {_ConsoleColors.SYMARROW} {_ConsoleColors.INFO}{new_file}{_ConsoleColors.RESET}")
        mode = 0o700 if executable else 0o600
        shutil.copyfile(orig_file, new_file)
        os.chmod(new_file, mode)

    def _install_group(self, groupname: str, run: bool = False) -> None:
        """Installs a package group.

        Args:
            groupname: Name of file group to install
            run: This group should be installed
        """
        if not run:
            return

        for dir_path in _INSTALL_GROUPS.get(groupname).get('delete_dirs', []):
            self._delete_directory(dir_path)

        for dir_path in _INSTALL_GROUPS.get(groupname).get('create_dirs', []):
            self._create_directory(dir_path)

        for install_dir in _INSTALL_GROUPS.get(groupname).get('install_dirs', []):
            self._install_directory(install_dir.get('dot'), install_dir.get('target'))

        for install_file in _INSTALL_GROUPS.get(groupname).get('install_files', []):
            self._install_file(install_file.get('dot'), install_file.get('target'), install_file.get('exec', False))

    @staticmethod
    def _run_fccache() -> None:
        "Runs fc-cache"
        print(f" {_ConsoleColors.SYMSTART} {_ConsoleColors.HEADER}Run Command:{_ConsoleColors.RESET}\t" +
              f"{_ConsoleColors.INFO}fc-cache -f ~/.fonts{_ConsoleColors.RESET}")
        try:
            subprocess.run(['fc-cache', '-f', '~/.fonts'], check=True)
        except subprocess.CalledProcessError as exception_object:
            print(f" {_ConsoleColors.ERROR}\nError Occured: fc-cache -f ~/fonts\n    {exception_object}" +
                  f"{_ConsoleColors.RESET}")
            raise SystemExit(-1)


def _do_args() -> argparse.Namespace:
    """Return command line arguments.

    Returns:
        A tuple with teh argument parse and parse namespace
    """
    parser = argparse.ArgumentParser(description='ElJef Dotfiles Installer')
    for arg_dict in _CMD_LINE_ARGS:
        parser.add_argument(arg_dict.get('long'), **arg_dict.get('opts', dict()))

    args = parser.parse_args()

    return args


def _do_modules_init() -> None:
    """Initializes / Pulls git submodules"""
    print(f" {_ConsoleColors.SYMSTART} {_ConsoleColors.HEADER}Run Command:{_ConsoleColors.RESET}\t" +
          f"{_ConsoleColors.INFO}git submodule update --init --recursive{_ConsoleColors.RESET}")
    try:
        subprocess.run(['git', 'submodule', 'update', '--init', '--recursive'], check=True)
    except subprocess.CalledProcessError as exception_object:
        print(f"\n {_ConsoleColors.ERROR}Error Occured: git submodule update --init --recursive\n" +
              f"    {exception_object}{_ConsoleColors.RESET}")
        raise SystemExit(-1)

    raise SystemExit(0)


def _do_modules_update() -> None:
    """Updates git submodules"""
    print(f" {_ConsoleColors.SYMSTART} {_ConsoleColors.HEADER}Run Command:{_ConsoleColors.RESET}\t" +
          f"{_ConsoleColors.INFO}git submodule update --recursive --remote{_ConsoleColors.RESET}")
    try:
        subprocess.run(['git', 'submodule', 'update', '--recursive', '--remote'], check=True)
    except subprocess.CalledProcessError as exception_object:
        print(f"\n {_ConsoleColors.ERROR}Error Occured: git submodule update --recursive --remote\n" +
              f"    {exception_object}{_ConsoleColors.RESET}")
        raise SystemExit(-1)

    raise SystemExit(0)


def _do_version() -> None:
    """Prints version and exists."""
    print("ElJef Dotfiles - {1!s}\n".format(_VERSION))
    raise SystemExit(0)


def _run() -> None:
    """Run functionality."""

    args = _do_args()

    if args.version_out:
        _do_version()

    if args.modules_init:
        _do_modules_init()

    if args.modules_update:
        _do_modules_update()

    installer = _Install()

    if args.install_archrepo:
        installer.set_install('bashcommon')
        installer.set_install('archrepo')

    if args.install:
        installer.set_install('bashcommon')
        installer.set_install('bashexports')
        installer.set_install('binfiles')
        installer.set_install('dotfiles')
        installer.set_install('fonts')
        installer.set_install('konsole')
        installer.set_install('nvim')
        installer.set_install('yakuake')

    if args.install_vim:
        installer.set_install('bashcommon')
        installer.set_install('vim')

    if args.install_vim_alias:
        installer.set_install('bashcommon')
        installer.set_install('vimalias')

    installer.do_install()


if __name__ == '__main__':
    try:
        _run()
    except KeyboardInterrupt:
        print(f"\n {_ConsoleColors.INFO}keyboard interrupt{_ConsoleColors.RESET}\n")
        raise SystemExit(-1)
    except (IOError, OSError, PermissionError) as exception_object:
        print(f"\n {_ConsoleColors.ERROR}\nError Occured:\n" +
              f"    {exception_object}{_ConsoleColors.RESET}")
        raise SystemExit(-1)
