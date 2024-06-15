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

FILES_PATH="${_basedir}/dotfiles/media/files"
check_dir "${FILES_PATH}"

install_file 0755 "${FILES_PATH}/bin/convert-to-mp3" "${HOME}/Bin/convert-to-mp3"
install_file 0755 "${FILES_PATH}/bin/playlist-combine" "${HOME}/Bin/playlist-combine"
install_file 0755 "${FILES_PATH}/bin/reformat-playlists" "${HOME}/Bin/reformat-playlists"
install_file 0755 "${FILES_PATH}/bin/youtube-get-audio" "${HOME}/Bin/youtube-get-audio"
