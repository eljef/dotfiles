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

function failure() {
    echo -e "\n${1}\n" 2>&1
    exit 1
}

function install_file() {
    echo "installing ${1}:${3}"
    install -m "${1}" "${2}" "${3}" || failure "failed to install ${2} -> ${3} :: ${1}"
}

function make_directory() {
    mkdir -p "${1}" || failure "failed to create directory ${1}"
}

PARENT_PATH="$(realpath "$(dirname "${0}")/../../../")"
DOTFILES_PATH="${PARENT_PATH}/dotfiles"
FILES_PATH="${DOTFILES_PATH}/extras/files"


if [[ ! -d "$FILES_PATH" ]]; then
    failure "could not determine location of dotfiles/extras/files"
fi

if [[ ! -f "${HOME}/.bashrc" ]]; then
    failure "${HOME}/.bashrc does not exist: run base bash configuration first"
fi

make_directory "${HOME}/.config/conky/conky1"
make_directory "${HOME}/.config/conky/conky2"
make_directory "${HOME}/.config/conky/conky-themes"

install_file 0755 "${FILES_PATH}/bin/conky-start" "${HOME}/Bin/conky-start"

install_file 0644 "${FILES_PATH}/conky/conky1.conf" "${HOME}/.config/conky/conky1/conky.conf"
install_file 0644 "${FILES_PATH}/conky/conky2.conf" "${HOME}/.config/conky/conky2/conky.conf"

echo "Cloning Required Conky Theme Repo"
echo "git clone https://github.com/zagortenay333/conky_themes ${HOME}/.config/conky/conky-themes"
git clone https://github.com/zagortenay333/conky_themes "${HOME}/.config/conky/conky-themes" || failure "failed to clone required theme repo"
