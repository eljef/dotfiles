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

FILES_PATH="${_basedir}/dotfiles/base/files"
check_dir "${FILES_PATH}"

make_directory "${HOME}/.bash_exports"

install_file 0644 "${FILES_PATH}/bash_profile" "${HOME}/.bash_profile"
install_file 0644 "${FILES_PATH}/bashrc" "${HOME}/.bashrc"
install_file 0644 "${FILES_PATH}/profile" "${HOME}/.profile"

del_file "${HOME}/.bash_exports/alias_grep.sh"
del_file "${HOME}/.bash_exports/alias_ls.sh"
del_file "${HOME}/.bash_exports/alias_vim.sh"
del_file "${HOME}/.bash_exports/export_editor.sh"
del_file "${HOME}/.bash_exports/export_ps1.sh"
del_file "${HOME}/.bash_exports/export_ps1"
del_file "${HOME}/.bash_exports/export_visual.sh"

install_file 0644 "${FILES_PATH}/bash_exports/alias_grep.sh" "${HOME}/.bash_exports/alias_grep"
install_file 0644 "${FILES_PATH}/bash_exports/alias_ls.sh" "${HOME}/.bash_exports/alias_ls"
install_file 0644 "${FILES_PATH}/bash_exports/alias_vim.sh" "${HOME}/.bash_exports/alias_vim"
install_file 0644 "${FILES_PATH}/bash_exports/export_editor.sh" "${HOME}/.bash_exports/export_editor"
install_file 0644 "${FILES_PATH}/bash_exports/export_visual.sh" "${HOME}/.bash_exports/export_visual"

