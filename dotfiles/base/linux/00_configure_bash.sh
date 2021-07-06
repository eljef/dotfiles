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
FILES_PATH="${DOTFILES_PATH}/base/files"


if [[ ! -d "$FILES_PATH" ]]; then
    failure "could not determine location of dotfiles/base/files"
fi

make_directory "${HOME}/.bash_exports"
make_directory "${HOME}/.local/share/bash-completion"
make_directory "${HOME}/Bin/include/"

install_file 0644 "${FILES_PATH}/bash_profile" "${HOME}/.bash_profile"
install_file 0644 "${FILES_PATH}/bashrc" "${HOME}/.bashrc"
install_file 0644 "${FILES_PATH}/profile" "${HOME}/.profile"

install_file 0644 "${FILES_PATH}/bash_exports/alias_grep.sh" "${HOME}/.bash_exports/alias_grep.sh"
install_file 0644 "${FILES_PATH}/bash_exports/alias_ls.sh" "${HOME}/.bash_exports/alias_ls.sh"
install_file 0644 "${FILES_PATH}/bash_exports/alias_vim.sh" "${HOME}/.bash_exports/alias_vim.sh"
install_file 0644 "${FILES_PATH}/bash_exports/export_editor.sh" "${HOME}/.bash_exports/export_editor.sh"
install_file 0644 "${FILES_PATH}/bash_exports/export_ps1.sh" "${HOME}/.bash_exports/export_ps1.sh"
install_file 0644 "${FILES_PATH}/bash_exports/export_visual.sh" "${HOME}/.bash_exports/export_visual.sh"

install_file 0755 "${FILES_PATH}/bin/fix-perms" "${HOME}/Bin/fix-perms"
install_file 0644 "${FILES_PATH}/bin/include/eljef-bash-common" "${HOME}/Bin/include/eljef-bash-common"
