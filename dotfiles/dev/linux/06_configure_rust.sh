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

function curl_install_file() {
    echo "curl ${2} -> ${1}:${3}"
    curl -sSf -o "${3}" "${2}" >/dev/null 2>&1 || failure "could not download ${2}"
    chmod "${1}" "${3}" || failure "could not set mode ${1} on ${3}"
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
FILES_PATH="${DOTFILES_PATH}/dev/files"


if [[ ! -d "$FILES_PATH" ]]; then
    failure "could not determine location of dotfiles/dev/files"
fi

if [[ ! -f "${HOME}/.bashrc" ]]; then
    failure "${HOME}/.bashrc does not exist: run base bash configuration first"
fi

if [[ ! -d "${HOME}/.bash_exports" ]]; then
    faiulre "${HOME}/.bash_exports does not exist: run base bash configuration first"
fi

make_directory "${HOME}/.cargo/bin"

install_file 0644 "${FILES_PATH}/bash_exports/export_rust" "${HOME}/.bash_exports/export_rust"

curl_install_file 0644 "https://sh.rustup.rs" \
                  "${HOME}/.cargo/rustup.sh"

echo "Configuring initial rust setup"
sh "${HOME}/.cargo/rustup.sh" --no-modify-path --default-toolchain none -y -q || failure "failed to configure intial rust setup"

echo "You must restart your bash session in order to run 07_install_rust_tools.sh"
