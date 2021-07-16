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

make_directory "${HOME}/.fonts"
make_directory "${HOME}/.config/fontconfig/conf.d"

FONT_FILES=('Caskaydia Cove Nerd Font Complete Mono.ttf'
            'Caskaydia Cove Nerd Font Complete.ttf'
            'Fira Code Bold Nerd Font Complete Mono.otf'
            'Fira Code Bold Nerd Font Complete.otf'
            'Fira Code Light Nerd Font Complete Mono.otf'
            'Fira Code Light Nerd Font Complete.otf'
            'Fira Code Medium Nerd Font Complete Mono.otf'
            'Fira Code Medium Nerd Font Complete.otf'
            'Fira Code Regular Nerd Font Complete Mono.otf'
            'Fira Code Regular Nerd Font Complete.otf'
            'Fira Code Retina Nerd Font Complete Mono.otf'
            'Fira Code Retina Nerd Font Complete.otf'
            'Hack Bold Italic Nerd Font Complete.ttf'
            'Hack Bold Italic Nerd Font Complete Mono.ttf'
            'Hack Bold Nerd Font Complete.ttf'
            'Hack Bold Nerd Font Complete Mono.ttf'
            'Hack Italic Nerd Font Complete.ttf'
            'Hack Italic Nerd Font Complete Mono.ttf'
            'Hack Regular Nerd Font Complete.ttf'
            'Hack Regular Nerd Font Complete Mono.ttf'
            'NotoColorEmoji.ttf')

for font_file in "${FONT_FILES[@]}"
do
  install_file 0644 "${FILES_PATH}/fonts/$font_file" \
                     "${HOME}/.fonts/$font_file"
done

install_file 0644 "${FILES_PATH}/config/fontconfig/conf.d/99-noto-mono-color-emoji.conf" \
                  "${HOME}/.config/fontconfig/conf.d/99-noto-mono-color-emoji.conf"

print_info "Rebuilding font cache"
fc-cache -f "${HOME}/.fonts" || failure "failed to rebuild font cache"
