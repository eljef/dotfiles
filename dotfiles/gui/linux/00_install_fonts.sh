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

. "/usr/lib/eljef_bash/eljef-bash-common.sh" || exit 1
_basedir="$(base_dir "$(dirname "${0}")" "script_common")"

check_installed "fc-cache"

FILES_PATH="${_basedir}/dotfiles/gui/files"
check_dir "${FILES_PATH}"

make_directory "${HOME}/.fonts"
make_directory "${HOME}/.config/fontconfig/conf.d"

FONT_FILES=('Caskaydia Cove Nerd Font Complete Bold Italic.otf'
            'Caskaydia Cove Nerd Font Complete Bold.otf'
            'Caskaydia Cove Nerd Font Complete ExtraLight Italic.otf'
            'Caskaydia Cove Nerd Font Complete ExtraLight.otf'
            'Caskaydia Cove Nerd Font Complete Italic.otf'
            'Caskaydia Cove Nerd Font Complete Light Italic.otf'
            'Caskaydia Cove Nerd Font Complete Light.otf'
            'Caskaydia Cove Nerd Font Complete Mono Bold Italic.otf'
            'Caskaydia Cove Nerd Font Complete Mono Bold.otf'
            'Caskaydia Cove Nerd Font Complete Mono ExtraLight Italic.otf'
            'Caskaydia Cove Nerd Font Complete Mono ExtraLight.otf'
            'Caskaydia Cove Nerd Font Complete Mono Italic.otf'
            'Caskaydia Cove Nerd Font Complete Mono Light Italic.otf'
            'Caskaydia Cove Nerd Font Complete Mono Light.otf'
            'Caskaydia Cove Nerd Font Complete Mono Regular.otf'
            'Caskaydia Cove Nerd Font Complete Mono SemiBold Italic.otf'
            'Caskaydia Cove Nerd Font Complete Mono SemiBold.otf'
            'Caskaydia Cove Nerd Font Complete Mono SemiLight Italic.otf'
            'Caskaydia Cove Nerd Font Complete Mono SemiLight.otf'
            'Caskaydia Cove Nerd Font Complete Regular.otf'
            'Caskaydia Cove Nerd Font Complete SemiBold Italic.otf'
            'Caskaydia Cove Nerd Font Complete SemiBold.otf'
            'Caskaydia Cove Nerd Font Complete SemiLight Italic.otf'
            'Caskaydia Cove Nerd Font Complete SemiLight.otf'
            'Fira Code Bold Nerd Font Complete Mono.ttf'
            'Fira Code Bold Nerd Font Complete.ttf'
            'Fira Code Light Nerd Font Complete Mono.ttf'
            'Fira Code Light Nerd Font Complete.ttf'
            'Fira Code Medium Nerd Font Complete Mono.ttf'
            'Fira Code Medium Nerd Font Complete.ttf'
            'Fira Code Regular Nerd Font Complete Mono.ttf'
            'Fira Code Regular Nerd Font Complete.ttf'
            'Fira Code Retina Nerd Font Complete Mono.ttf'
            'Fira Code Retina Nerd Font Complete.ttf'
            'Fira Code SemiBold Nerd Font Complete Mono.ttf'
            'Fira Code SemiBold Nerd Font Complete.ttf'
            'Hack Bold Italic Nerd Font Complete Mono.ttf'
            'Hack Bold Italic Nerd Font Complete.ttf'
            'Hack Bold Nerd Font Complete Mono.ttf'
            'Hack Bold Nerd Font Complete.ttf'
            'Hack Italic Nerd Font Complete Mono.ttf'
            'Hack Italic Nerd Font Complete.ttf'
            'Hack Regular Nerd Font Complete Mono.ttf'
            'Hack Regular Nerd Font Complete.ttf'
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

