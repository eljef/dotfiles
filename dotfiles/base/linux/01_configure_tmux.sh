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

check_installed "tmux"

FILES_PATH="${_basedir}/dotfiles/base/files"
check_dir "${FILES_PATH}"

del_file "${HOME}/.tmux.conf"

if [ -d "${HOME}/.config/tmux" ]; then
    print_info "Backing up current tmux configuration folder"
    mv "${HOME}/.config/tmux" "${HOME}/.config/tmux.bak" || failure "could not backup current tmux configuration folder"
fi

make_directory "${HOME}/.config/tmux/conf.d/"
make_directory "${HOME}/.config/tmux/split.d/"

install_file 0644 "${FILES_PATH}/tmux/tmux.conf" "${HOME}/.config/tmux/tmux.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/00_numbering.conf" "${HOME}/.config/tmux/conf.d/00_numbering.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/01_history.conf" "${HOME}/.config/tmux/conf.d/01_history.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/02_terminal.conf" "${HOME}/.config/tmux/conf.d/02_terminal.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/03_clipboard.conf" "${HOME}/.config/tmux/conf.d/03_clipboard.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/04_mouse.conf" "${HOME}/.config/tmux/conf.d/04_mouse.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/05_status_bar_options.conf" "${HOME}/.config/tmux/conf.d/05_status_bar_options.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/05_status_bar_position.conf" "${HOME}/.config/tmux/conf.d/05_status_bar_position.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/05_status_bar_style.conf" "${HOME}/.config/tmux/conf.d/05_status_bar_style.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/05_status_bar_style_messages.conf" "${HOME}/.config/tmux/conf.d/05_status_bar_style_messages.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/05_status_bar_window_style.conf" "${HOME}/.config/tmux/conf.d/05_status_bar_window_style.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/06_pane_style.conf" "${HOME}/.config/tmux/conf.d/06_pane_style.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/07_bell.conf" "${HOME}/.config/tmux/conf.d/07_bell.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/08_key_binds.conf" "${HOME}/.config/tmux/conf.d/08_key_binds.conf"
install_file 0644 "${FILES_PATH}/tmux/conf.d/99_key_binds_splits.conf" "${HOME}/.config/tmux/conf.d/99_key_binds_splits.conf"
install_file 0644 "${FILES_PATH}/tmux/split.d/dev.conf" "${HOME}/.config/tmux/split.d/dev.conf"
install_file 0644 "${FILES_PATH}/tmux/split.d/half.conf" "${HOME}/.config/tmux/split.d/half.conf"
