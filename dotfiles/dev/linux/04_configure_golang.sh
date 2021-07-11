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

_scriptdir="$(dirname "${0}")"
. "${_scriptdir}/../../../script_common/common.sh" || exit 1

_basedir="$(base_dir "${_scriptdir}" "script_common")"


FILES_PATH="${_basedir}/dotfiles/dev/files"
check_dir "${FILES_PATH}"
check_file "${HOME}/.bashrc"
check_dir "${HOME}/.bash_exports"

install_file 0644 "${FILES_PATH}/bash_exports/export_golang" "${HOME}/.bash_exports/export_golang"

if [[ -d  "${HOME}/.config/nvim/" ]]; then
   install_file 0644 "${FILES_PATH}/nvim/golang.vim" "${HOME}/.config/nvim/golang.vim"
   install_file 0644 "${FILES_PATH}/nvim/plugins_with_golang.vim" "${HOME}/.config/nvim/plugins.vim"
   install_file 0644 "${FILES_PATH}/coc-settings-with-golang.json" "${HOME}/.config/nvim/coc-settings.json"

    neovim_buffer_text=$(cat <<EOF

    When the plugin installation is done,
    Please close neovim with :qa!

    Thanks for playing along!

EOF
)
  print_info "Installing neovim plugins"
  echo "${neovim_buffer_text}" | nvim -c PlugInstall
fi

echo "You must restart your bash session in order to run 05_install_golang_tools.sh"
