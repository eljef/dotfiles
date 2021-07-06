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
    curl -o "${3}" "${2}" >/dev/null 2>&1 || failure "could not download ${2}"
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
FILES_PATH="${DOTFILES_PATH}/base/files"


if [[ ! -d "$FILES_PATH" ]]; then
    failure "could not determine location of dotfiles/base/files"
fi

make_directory "${HOME}/.config/nvim"
make_directory "${HOME}/.local/share/nvim/plugged"
make_directory "${HOME}/.local/share/nvim/site/autoload"

install_file 0644 "${FILES_PATH}/nvim/airline.vim" "${HOME}/.config/nvim/airline.vim"
install_file 0644 "${FILES_PATH}/nvim/autosave.vim" "${HOME}/.config/nvim/autosave.vim"
install_file 0644 "${FILES_PATH}/nvim/default.vim" "${HOME}/.config/nvim/default.vim"
install_file 0644 "${FILES_PATH}/nvim/dracula.vim" "${HOME}/.config/nvim/dracula.vim"
install_file 0644 "${FILES_PATH}/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
install_file 0644 "${FILES_PATH}/nvim/nerdtree.vim" "${HOME}/.config/nvim/nerdtree.vim"
install_file 0644 "${FILES_PATH}/nvim/plugins.vim" "${HOME}/.config/nvim/plugins.vim"
install_file 0644 "${FILES_PATH}/nvim/shell.vim" "${HOME}/.config/nvim/shell.vim"

curl_install_file 0644 "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
                  "${HOME}/.local/share/nvim/site/autoload/plug.vim"

neovim_buffer_text=$(cat <<EOF

    When the plugin installation is done,
    Please close neovim with :qa!

    Thanks for playing along!

EOF
)

echo "Installing neovim plugins"
echo "${neovim_buffer_text}" nvim -c PlugInstall
