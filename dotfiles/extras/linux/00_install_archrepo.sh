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


FILES_PATH="${_basedir}/dotfiles/extras/files"
check_dir "${FILES_PATH}"
check_file "${HOME}/.bashrc"
check_dir "${HOME}/bin"

make_directory "${HOME}/.local/share/bash-completion/completions"

install_file 0755 "${FILES_PATH}/bash-completion/archrepo-chroot-build" "${HOME}/.local/share/bash-completion/completions/archrepo-chroot-build"
install_file 0755 "${FILES_PATH}/bash-completion/archrepo-sign-and-move" "${HOME}/.local/share/bash-completion/completions/archrepo-sign-and-move"

install_file 0755 "${FILES_PATH}/bin/archrepo-add-aur" "${HOME}/Bin/archrepo-add-aur"
install_file 0755 "${FILES_PATH}/bin/archrepo-chroot-build" "${HOME}/Bin/archrepo-chroot-build"
install_file 0755 "${FILES_PATH}/bin/archrepo-sign-and-move" "${HOME}/Bin/archrepo-sign-and-move"
install_file 0755 "${FILES_PATH}/bin/archrepo-sync" "${HOME}/Bin/archrepo-sync"
install_file 0755 "${FILES_PATH}/bin/archrepo-update-aur-gits" "${HOME}/Bin/archrepo-update-aur-gits"
