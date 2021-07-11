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


FILES_PATH="${_basedir}/dotfiles/base/files"
check_dir "${FILES_PATH}"

del_file "${HOME}/.tmux.conf"

make_directory "${HOME}/.config/tmux"

install_file 0644 "${FILES_PATH}/tmux/2k.conf" "${HOME}/.config/tmux/2k.conf"
install_file 0644 "${FILES_PATH}/tmux/dev.conf" "${HOME}/.config/tmux/dev.conf"
install_file 0644 "${FILES_PATH}/tmux/half.conf" "${HOME}/.config/tmux/half.conf"
install_file 0644 "${FILES_PATH}/tmux/pane-border-format.conf" "${HOME}/.config/tmux/pane-border-format.conf"
install_file 0644 "${FILES_PATH}/tmux/tmux.conf" "${HOME}/.config/tmux/tmux.conf"
