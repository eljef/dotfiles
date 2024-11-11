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

_CONFIG_LUAS=('bufferline.lua'
              'colorscheme.lua'
              'defaults.lua'
              'filetype.lua'
              'languages.lua'
              'lualine.lua'
              'markdown.lua'
              'nvimtree.lua'
              'pairs.lua'
              'scroll.lua'
              'shell.lua'
              'todo.lua'
              'treesitter.lua')

_PLUGINS_LUAS=('autopairs.lua'
               'bufferline.lua'
               'cmp.lua'
               'dracula.lua'
               'glow.lua'
               'go.lua'
               'lspconfig.lua'
               'lualine.lua'
               'scroll.lua'
               'todo.lua'
               'tree.lua'
               'treesitter.lua')

check_installed "nvim"

FILES_PATH="${_basedir}/dotfiles/base/files"
check_dir "${FILES_PATH}"

make_directory "${HOME}/.config/nvim/lua/ej/config"
make_directory "${HOME}/.config/nvim/lua/ej/modules"
make_directory "${HOME}/.config/nvim/lua/ej/plugins"

install_file 0640 "${FILES_PATH}/nvim/init.lua" \
                  "${HOME}/.config/nvim/init.lua"
install_file 0640 "${FILES_PATH}/nvim/lua/ej/modules/lazy.lua" \
                  "${HOME}/.config/nvim/lua/ej/modules/lazy.lua"

for _c_lua in "${_CONFIG_LUAS[@]}"
do
    install_file 0640 "${FILES_PATH}/nvim/lua/ej/config/${_c_lua}" \
                      "${HOME}/.config/nvim/lua/ej/config/${_c_lua}"
done

for _p_lua in "${_PLUGINS_LUAS[@]}"
do
    install_file 0640 "${FILES_PATH}/nvim/lua/ej/plugins/${_p_lua}" \
                      "${HOME}/.config/nvim/lua/ej/plugins/${_p_lua}"
done

print_info "Start neovim to install plugins"
