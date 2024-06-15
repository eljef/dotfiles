#!/bin/bash
# Copyright (c) 2020-2024, Jef Oliver
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
# SPDX-License-Identifier: 0BSD
#
# Authors:
# Jef Oliver <jef@eljef.me>
_PACKAGES=("black"
           "git"
           "golang-go"
           "make"
           "nodejs"
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
# shellcheck source=../../../../../script_common/common.sh
. "${_scriptdir}/../../../../../script_common/common.sh" || exit 1


check_root

_UBUNTU_CODENAME=$(cat /etc/os-release | grep UBUNTU_CODENAME | awk '{split($0,a,"="); print a[2]}')

print_info "Adding Golang PPA"
add-apt-repository -y ppa:longsleep/golang-backports

print_info "Adding NodeJS 16.x PPA"
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
echo "deb https://deb.nodesource.com/node_16.x ${_UBUNTU_CODENAME} main" > /etc/apt/sources.list.d/nodesource.list

print_info "Updating Apt Package List"
apt update

print_info "Installing packages with apt"
apt -y install "${_PACKAGES[@]}" || failure "failed to install packages with apt"

print_info "Installing packages with pip"
pip3 install -U "${_PIP_MODULES[@]}" || failure "failed to install packages with pip"

print_info "Install packages with npm"
npm install -g "${_NPM_MODULES[@]}" || failure "failed to install packages with npm"
