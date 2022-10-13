#!/bin/bash
# Copyright (C) 2021-2022 Jef Oliver.
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

COC_PLUGINS=('coc-css'
             'coc-diagnostic'
             'coc-docker'
             'coc-highlight'
             'coc-html'
             'coc-json'
             'coc-markdownlint'
             'coc-python'
             'coc-rls'
             'coc-sh'
             'coc-tsserver'
             'coc-vetur'
             'coc-yaml'
)

################################################################################
# DO NOT EDIT BELOW HERE
################################################################################

. "/usr/lib/eljef_bash/eljef-bash-common.sh" || exit 1
_basedir="$(base_dir "$(dirname "${0}")" "script_common")"

check_isntalled "nvim"

FILES_PATH="${_basedir}/dotfiles/dev/files"
check_dir "${FILES_PATH}"
check_dir "${HOME}/.config/nvim/"

install_file 0644 "${FILES_PATH}/nvim/coc.vim" "${HOME}/.config/nvim/coc.vim"
install_file 0644 "${FILES_PATH}/nvim/coc-node-path.vim" "${HOME}/.config/nvim/coc-node-path.vim"
install_file 0644 "${FILES_PATH}/nvim/dev.vim" "${HOME}/.config/nvim/dev.vim"
install_file 0644 "${FILES_PATH}/nvim/files.vim" "${HOME}/.config/nvim/files.vim"
install_file 0644 "${FILES_PATH}/nvim/omnifunc.vim" "${HOME}/.config/nvim/omnifunc.vim"
install_file 0644 "${FILES_PATH}/nvim/plugins.vim" "${HOME}/.config/nvim/plugins.vim"
install_file 0644 "${FILES_PATH}/coc-settings.json" "${HOME}/.config/nvim/coc-settings.json"

neovim_buffer_text=$(cat <<EOF

    When the plugin installation is done,
    Please close neovim with :qa!

    Thanks for playing along!

EOF
)

print_info "Installing neovim plugins"
echo "${neovim_buffer_text}" | nvim -c PlugInstall

print_info "Installing neovim coc plugins"
echo "${neovim_buffer_text}" | nvim -c "CocInstall ${COC_PLUGINS[*]}"
