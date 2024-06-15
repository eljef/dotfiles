#!/bin/bash
# Copyright (C) 2021-2024 Jef Oliver.
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

_ICON_FILES=('01d.png'
             '01n.png'
             '02d.png'
             '02n.png'
             '03d.png'
             '03n.png'
             '04d.png'
             '04n.png'
             '09d.png'
             '09n.png'
             '10d.png'
             '10n.png'
             '11d.png'
             '11n.png'
             '13d.png'
             '13n.png'
             '50d.png'
             '50n.png')

FILES_PATH="${_basedir}/dotfiles/gui/files"
check_dir "${FILES_PATH}"

make_directory "${HOME}/.config/conky/lib/weather_icons"
make_directory "${HOME}/.config/conky/data"

for icon_file in "${_ICON_FILES[@]}"
do
    install_file 0644 "${FILES_PATH}/config/conky/lib/weather_icons/${icon_file}" \
                      "${HOME}/.config/conky/lib/weather_icons/${icon_file}"
done

install_file 0644 "${FILES_PATH}/config/conky/lib/conky.lua" \
                  "${HOME}/.config/conky/lib/conky.lua"
install_file 0755 "${FILES_PATH}/config/conky/lib/weather.py" \
                  "${HOME}/.config/conky/lib/weather.py"
install_file 0644 "${FILES_PATH}/config/conky/conky.conf" \
                  "${HOME}/.config/conky/conky.conf"
install_file 0644 "${FILES_PATH}/config/conky/weather.conf" \
                  "${HOME}/.config/conky/weather.conf"
