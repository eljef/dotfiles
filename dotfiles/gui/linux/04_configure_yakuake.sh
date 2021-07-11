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


FILES_PATH="${_basedir}/dotfiles/gui/files"
check_dir "${FILES_PATH}"

make_directory "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs"
make_directory "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title"

install_file 0755 "${FILES_PATH}/bin/yakuake-init-session" \
                  "${HOME}/Bin/yakuake-init-session"
install_file 0755 "${FILES_PATH}/bin/yakuake-send" \
                  "${HOME}/Bin/yakuake-send"
install_file 0755 "${FILES_PATH}/bin/yakuake-split-dev-2k" \
                  "${HOME}/Bin/yakuake-split-dev-2k"

install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/README.md" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/README.md"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title.skin" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title.skin"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/selected_back.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/selected_back.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/selected_right.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/selected_right.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/minus_over.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/minus_over.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/selected_left.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/selected_left.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/separator.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/separator.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/minus_up.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/minus_up.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/minus_down.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/minus_down.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/lock.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/lock.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/unselected_back.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/unselected_back.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/plus_up.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/plus_up.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/right_corner.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/right_corner.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/left_corner.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/left_corner.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/back_image.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/back_image.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/plus_over.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/plus_over.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs/plus_down.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs/plus_down.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/icon.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/icon.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/quit_up.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/quit_up.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/right.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/right.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/config_up.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/config_up.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/focus_up.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/focus_up.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/config_down.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/config_down.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/quit_over.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/quit_over.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/focus_over.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/focus_over.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/config_over.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/config_over.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/left.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/left.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/back.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/back.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/quit_down.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/quit_down.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/title/focus_down.png" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/title/focus_down.png"
install_file 0644 "${FILES_PATH}/local/share/yakuake/kns_skins/pixelnine/tabs.skin" \
                  "${HOME}/.local/share/yakuake/kns_skins/pixelnine/tabs.skin"
