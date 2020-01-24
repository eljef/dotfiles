#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
#
# Copyright (c) 2020, Jef Oliver
# Use of this source code is governed by a BSD-3-Clause license
# that can be found in the LICENSE file.
"""Install Utility

Utility to install dotfiles.
"""

import argparse
import os
import shutil

from pathlib import Path


def _do_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="ElJef dotfiles")
    parser.add_argument("-b", "--base_path", dest='base_path', metavar="/path/to/dotfiles",
                        help="full path to the base folder of dotfiles repo")
    args = parser.parse_args()

    return args


def _do_cleanup(file_path: str) -> None:
    if os.path.exists(file_path):
        print("removing: {0!s}".format(file_path))

        if os.path.islink(file_path):
            os.unlink(file_path)
        elif os.path.isdir(file_path):
            shutil.rmtree(file_path)
        else:
            os.remove(file_path)


def _do_install(dotfiles_path: str, home_path: str) -> None:
    files_dirs = os.listdir(dotfiles_path)
    for file_dir in sorted(files_dirs):
        dotfile_path = os.path.join(dotfiles_path, file_dir)
        home_dot_path = os.path.join(home_path, ".{0!s}".format(file_dir))

        _do_cleanup(home_dot_path)
        print("linking: {0!s} -> {1!s}".format(dotfile_path, home_dot_path))
        os.symlink(dotfile_path, home_dot_path)


def _main() -> None:
    args = _do_args()
    if not args.base_path:
        raise SystemExit("base_path not specified")

    dotfiles_path = os.path.join(args.base_path, 'dotfiles')
    if not os.path.exists(dotfiles_path):
        raise SystemExit("could not find dotfiles path")
    if not os.path.isdir(dotfiles_path):
        raise SystemExit("dotfiles path is not a directory: {0!s}".format(dotfiles_path))

    _do_install(dotfiles_path, str(Path.home()))


if __name__ == '__main__':
    _main()
