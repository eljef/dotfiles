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

. "/usr/lib/eljef_bash/eljef-bash-common.sh" || exit 1
_basedir="$(base_dir "$(dirname "${0}")" "script_common")"

check_installed "nvim"

FILES_PATH="${_basedir}/dotfiles/base/files"
check_dir "${FILES_PATH}"

make_directory "${HOME}/.config/nvim/lua"
make_directory "${HOME}/.local/share/nvim/plugged"
make_directory "${HOME}/.local/share/nvim/site/autoload"

install_file 0644 "${FILES_PATH}/nvim/init.lua"           "${HOME}/.config/nvim/init.lua"
install_file 0644 "${FILES_PATH}/nvim/lua/airline.lua"    "${HOME}/.config/nvim/lua/airline.lua"
install_file 0644 "${FILES_PATH}/nvim/lua/autosave.lua"   "${HOME}/.config/nvim/lua/autosave.lua"
install_file 0644 "${FILES_PATH}/nvim/lua/default.lua"    "${HOME}/.config/nvim/lua/default.lua"
install_file 0644 "${FILES_PATH}/nvim/lua/dracula.lua"    "${HOME}/.config/nvim/lua/dracula.lua"
install_file 0644 "${FILES_PATH}/nvim/lua/nerdtree.lua"   "${HOME}/.config/nvim/lua/nerdtree.lua"
install_file 0644 "${FILES_PATH}/nvim/lua/plugins.lua"    "${HOME}/.config/nvim/lua/plugins.lua"
install_file 0644 "${FILES_PATH}/nvim/lua/shell.lua"      "${HOME}/.config/nvim/lua/shell.lua"
install_file 0644 "${FILES_PATH}/nvim/lua/treesitter.lua" "${HOME}/.config/nvim/lua/treesitter.lua"

download_install_file 0644 "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
                           "${HOME}/.local/share/nvim/site/autoload/plug.vim"

neovim_buffer_text=$(cat <<EOF

    When the plugin installation is done,
    Please close neovim with :qa!

    Thanks for playing along!

EOF
)

print_info "Installing neovim plugins"
echo "${neovim_buffer_text}" | nvim -c PlugInstall
