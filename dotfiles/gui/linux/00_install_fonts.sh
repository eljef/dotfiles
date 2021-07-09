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
FILES_PATH="${DOTFILES_PATH}/gui/files"


if [[ ! -d "$FILES_PATH" ]]; then
    failure "could not determine location of dotfiles/gui/files"
fi

make_directory "${HOME}/.fonts"

FONT_FILES=('Caskaydia Cove Nerd Font Complete Mono.ttf'
            'Caskaydia Cove Nerd Font Complete.ttf'
            'Fira Code Bold Nerd Font Complete Mono.otf'
            'Fira Code Bold Nerd Font Complete.otf'
            'Fira Code Light Nerd Font Complete Mono.otf'
            'Fira Code Light Nerd Font Complete.otf'
            'Fira Code Medium Nerd Font Complete Mono.otf'
            'Fira Code Medium Nerd Font Complete.otf'
            'Fira Code Regular Nerd Font Complete Mono.otf'
            'Fira Code Regular Nerd Font Complete.otf'
            'Fira Code Retina Nerd Font Complete Mono.otf'
            'Fira Code Retina Nerd Font Complete.otf'
            'Hack Bold Italic Nerd Font Complete.ttf'
            'Hack Bold Italic Nerd Font Complete Mono.ttf'
            'Hack Bold Nerd Font Complete.ttf'
            'Hack Bold Nerd Font Complete Mono.ttf'
            'Hack Italic Nerd Font Complete.ttf'
            'Hack Italic Nerd Font Complete Mono.ttf'
            'Hack Regular Nerd Font Complete.ttf'
            'Hack Regular Nerd Font Complete Mono.ttf')

for font_file in "${FONT_FILES[@]}"
do
  install_file 0644 "${FILES_PATH}/fonts/$font_file" \
                     "${HOME}/.fonts/$font_file"
done

echo "Rebuilding font cache"
fc-cache -f "${HOME}/.fonts" || failure "failed to rebuild font cache"
