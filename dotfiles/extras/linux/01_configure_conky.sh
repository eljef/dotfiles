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

make_directory "${HOME}/.config/conky/conky1"
make_directory "${HOME}/.config/conky/conky2"
make_directory "${HOME}/.config/conky/conky-themes"

install_file 0755 "${FILES_PATH}/bin/conky-start" "${HOME}/Bin/conky-start"

install_file 0644 "${FILES_PATH}/conky/conky1.conf" "${HOME}/.config/conky/conky1/conky.conf"
install_file 0644 "${FILES_PATH}/conky/conky2.conf" "${HOME}/.config/conky/conky2/conky.conf"

print_info "Cloning Required Conky Theme Repo"
print_info "git clone https://github.com/zagortenay333/conky_themes ${HOME}/.config/conky/conky-themes"
git clone https://github.com/zagortenay333/conky_themes "${HOME}/.config/conky/conky-themes" || failure "failed to clone required theme repo"
