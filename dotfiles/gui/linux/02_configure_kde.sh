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

function kwriteconfig() {
    print_info "kwriteconfig5 --file \"${1}\" --group \"${2}\" --key \"${3}\" --type \"${4}\" \"${5}\""
    kwriteconfig5 --file "${1}" --group "${2}" --key "${3}" --type "${4}" \
             "${5}" || failure "failed to apply kde setting"
}

install_file 0644 "${FILES_PATH}/xinitrc" "${HOME}/.xinitrc"

print_info "Setting KDE Defaults"
kwriteconfig "${HOME}/.config/mimeapps.list" \
             "Default Applications"\
             "text/html"\
             "string"\
             "firefox.desktop"
kwriteconfig "${HOME}/.config/mimeapps.list" \
             "Default Applications" \
             "x-scheme-handler/http" \
             "string" \
             "firefox.desktop"
kwriteconfig "${HOME}/.config/mimeapps.list" \
             "Default Applications" \
             "x-scheme-handler/https" \
             "string" \
             "firefox.desktop"
kwriteconfig "${HOME}/.config/kdeglobals" \
             "General" \
             "BrowserApplication" \
             "string" \
             "firefox.desktop"
kwriteconfig "${HOME}/.config/kdeglobals" \
             "KDE" \
             "SingleClick" \
             "bool" \
             "false"
kwriteconfig "${HOME}/.config/dolphinrc" \
             "General" \
             "EditableUrl" \
             "bool" \
             "true"
kwriteconfig "${HOME}/.config/dolphinrc" \
             "General" \
             "RememberOpenedTabs" \
             "bool" \
             "false"
kwriteconfig "${HOME}/.config/dolphinrc" \
             "General" \
             "ShowFullPath" \
             "bool" \
             "true"

print_info "Setting XDG Default Web Browser"
xdg-settings set default-web-browser firefox.desktop || failure "could not set default xdg web browser"
