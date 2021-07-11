#!/bin/bash
# Copyright (C) 2021 Jef Oliver.
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
_PACKAGES=("black"
           "git"
           "golang-go"
           "make"
           "nodejs"
           "npm"
           "pylint"
           "python3-flake8"
           "python3-pynvim"
           "python3-pytest"
           "python3-pytest-cov"
           "shellcheck")

_PIP_MODULES=("pytest-pythonpath")

_NPM_MODULES=("bash-language-server"
              "diff-so-fancy"
              "markdownlint-cli"
              "write-good")

################################################################################
# DO NOT EDIT BELOW HERE
################################################################################

_scriptdir="$(dirname "${0}")"
. "${_scriptdir}/../../../../../script_common/common.sh" || exit 1


check_root

print_info "Installing packages with apt"
apt install "${_PACKAGES[@]}" || failure "failed to install packages with apt"

print_info "Installing packages with pip"
pip3 install -U "${_PIP_MODULES[@]}" || failure "failed to install packages with pip"

print_info "Install packages with npm"
npm install -g "${_NPM_MODULES[@]}" || failure "failed to install packages with npm"
