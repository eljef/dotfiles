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

make_directory "${HOME}/.local/share/bash-completion/completions"

install_file 0755 "${FILES_PATH}/bash-completion/archrepo-chroot-build" "${HOME}/.local/share/bash-completion/completions/archrepo-chroot-build"
install_file 0755 "${FILES_PATH}/bash-completion/archrepo-sign-and-move" "${HOME}/.local/share/bash-completion/completions/archrepo-sign-and-move"

install_file 0755 "${FILES_PATH}/bin/archrepo-add-aur" "${HOME}/Bin/archrepo-add-aur"
install_file 0755 "${FILES_PATH}/bin/archrepo-chroot-build" "${HOME}/Bin/archrepo-chroot-build"
install_file 0755 "${FILES_PATH}/bin/archrepo-sign-and-move" "${HOME}/Bin/archrepo-sign-and-move"
install_file 0755 "${FILES_PATH}/bin/archrepo-sync" "${HOME}/Bin/archrepo-sync"
install_file 0755 "${FILES_PATH}/bin/archrepo-update-aur-gits" "${HOME}/Bin/archrepo-update-aur-gits"
