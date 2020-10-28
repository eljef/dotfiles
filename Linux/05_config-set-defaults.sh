#!/bin/bash
# Copyright (C) 2020 Jef Oliver.
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

. common

SDIR=$(check_location "/../")

function set_kde_default() {
    echo "${1}::${2}::${3}::${4}::${5}"
    kwriteconfig5 --file "${1}" \
                  --group "${2}" \
                  --key "${3}" \
                  --type "${4}" \
                  "${5}" || echo_error "Failed to set KDE default: ${1}: ${2}: ${3}"
}

# Set Default Browser

set_kde_default "${HOME}/.config/mimeapps.list" "Default Applications" "text/html" "string" "firefox.desktop"
set_kde_default "${HOME}/.config/mimeapps.list" "Default Applications" "x-scheme-handler/http" "string" "firefox.desktop"
set_kde_default "${HOME}/.config/mimeapps.list" "Default Applications" "x-scheme-handler/https" "string" "firefox.desktop"
set_kde_default "${HOME}/.config/kdeglobals" "General" "BrowserApplication" "string" "firefox.desktop"

xdg-settings set default-web-browser firefox.desktop || echo_error "Failed to set xdg default browsers"

# Configure KDE Defaults

set_kde_default "${HOME}/.config/kdeglobals" "KDE" "SingleClick" "bool" "false"

# Configure Dolphin

set_kde_default "${HOME}/.config/dolphinrc" "General" "EditableUrl" "bool" "true"
set_kde_default "${HOME}/.config/dolphinrc" "General" "RememberOpenedTabs" "bool" "false"
set_kde_default "${HOME}/.config/dolphinrc" "General" "ShowFullPath" "bool" "true"

# Set Default Cursors

make_directory "${HOME}/.icons/default"
install_file "${SDIR}/dotfiles/icons/default/index.theme" "${HOME}/.icons/default/index.theme" 0644

