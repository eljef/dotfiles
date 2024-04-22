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

_NF_VERSION="3.2.1"
_NF_DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download"
_NF_RELEASE_URL="${_NF_DOWNLOAD_URL}/v${_NF_VERSION}"
_NF_ZIP_CASCADIA_CODE="CascadiaCode.zip"
_NF_ZIP_FIRA_CODE="FiraCode.zip"
_NF_ZIP_HACK="Hack.zip"


check_installed "curl"
check_installed "fc-cache"
check_installed "unzip"


FILES_PATH="${_basedir}/dotfiles/gui/files"
check_dir "${FILES_PATH}"

make_directory "${HOME}/.fonts"
make_directory "${HOME}/.config/fontconfig/conf.d"

print_info "Downloading Nerd Font Packages"

download_install_file 0644 \
  "${_NF_RELEASE_URL}/${_NF_ZIP_CASCADIA_CODE}" \
  "${HOME}/.fonts/${_NF_ZIP_CASCADIA_CODE}"

download_install_file 0644 \
  "${_NF_RELEASE_URL}/${_NF_ZIP_FIRA_CODE}" \
  "${HOME}/.fonts/${_NF_ZIP_FIRA_CODE}"

download_install_file 0644 \
  "${_NF_RELEASE_URL}/${_NF_ZIP_HACK}" \
  "${HOME}/.fonts/${_NF_ZIP_HACK}"


cd_or_error "${HOME}/.fonts"


# Caskaydia Cove Nerd Font
print_info "Removing Old Caskaydia Code Nerd Fonts"
rm -f -- "Caskaydia Cove Nerd Font"* || failure "Could Not Remove Old Caskaydia Cove Nerd Fonts"
rm -f -- "CaskaydiaCoveNerdFont"* || failure "Could Not Remove Old Caskaydia Cove Nerd Fonts"

print_info "Installing New Caskaydia Code Nerd Fonts"
unzip -qq -j -o "${_NF_ZIP_CASCADIA_CODE}" || failure "Could Not Unzip Caskaydia Cove Nerd Fonts"
rm -f -- "${_NF_ZIP_CASCADIA_CODE}" || failure "Could Not Remove Caskaydia Cove Zip File"

rm -rf -- "doc/CascadiaCode" || failure "Could Not Remove Cascadia Code Docs"
make_directory "${HOME}/.fonts/doc/CascadiaCode"
mv -f -- LICENSE "doc/CascadiaCode/LICENSE" || failure "Could Not Move Caskaydia Code License"
mv -f -- README.md "doc/CascadiaCode/README.md" || failure "Could Not Move Caskaydia Code README"


# Fira Code Nerd Font
print_info "Removing Old Fira Code Nerd Fonts"
rm -f -- "Fira Code"*"Nerd Font"* || failure "Could Not Remove Old Fira Code Nerd Fonts"
rm -f -- "FiraCodeNerdFont"* || failure "Could Not Remove Old Fira Code Nerd Fonts"

print_info "Installing New Fira Code Nerd Fonts"
unzip -qq -j -o "${_NF_ZIP_FIRA_CODE}" || failure "Could Not Unzip Fira Code Nerd Fonts"
rm -f -- "${_NF_ZIP_FIRA_CODE}" || failure "Could Not Remove Fira Code Zip File"

rm -rf -- "doc/FiraCode" || failure "Could Not Remove Fira Code Docs"
make_directory "${HOME}/.fonts/doc/FiraCode"
mv -f -- LICENSE "doc/FiraCode/LICENSE" || failure "Could Not Move Fira Code License"
mv -f -- README.md "doc/FiraCode/README.md" || failure "Could Not Move Fira Code README"


# Hack Nerd Font
print_info "Removing Old Hack Nerd Fonts"
rm -f -- "Hack"*"Nerd Font"* || failure "Could Not Remove Old Hack Nerd Fonts"
rm -f -- "HackNerdFont"* || failure "Could Not Remove Old Hack Nerd Fonts"

print_info "Installing New Hack Nerd Fonts"
unzip -qq -j -o "${_NF_ZIP_HACK}" || failure "Could Not Unzip Hack Nerd Fonts"
rm -f -- "${_NF_ZIP_HACK}" || failure "Could Not Remove Hack Zip File"

rm -rf -- "doc/Hack" || failure "Could Not Remove Hack Docs"
make_directory "${HOME}/.fonts/doc/Hack"
mv -f -- LICENSE.md "doc/Hack/LICENSE.md" || failure "Could Not Move Hack License"
mv -f -- README.md "doc/Hack/README.md" || failure "Could Not Move Hack README"


# Noto Color Emoji
print_info "Removing Old Noto Color Emoji Font"
rm -f -- "NotoColorEmoji.ttf"

print_info "Downloading New Noto Color Emoji Font"
download_install_file 0644 \
    "https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf" \
    "${HOME}/.fonts/NotoColorEmoji.ttf"

make_directory "${HOME}/.fonts/doc/NotoColorEmoji"
rm -f -- "${HOME}/.fonts/doc/NotoColorEmoji/LICENSE"
download_install_file 0644 \
    "https://raw.githubusercontent.com/googlefonts/noto-emoji/main/fonts/LICENSE" \
    "${HOME}/.fonts/doc/NotoColorEmoji/LICENSE"


# Rebuild Font Cache

print_info "Installing Font Configuration Rules"

install_file 0644 "${FILES_PATH}/config/fontconfig/conf.d/99-firacode-hack-nerd-font.conf" \
                  "${HOME}/.config/fontconfig/conf.d/99-firacode-hack-nerd-font.conf"
install_file 0644 "${FILES_PATH}/config/fontconfig/conf.d/99-noto-mono-color-emoji.conf" \
                  "${HOME}/.config/fontconfig/conf.d/99-noto-mono-color-emoji.conf"


print_info "Rebuilding font cache"
fc-cache -f "${HOME}/.fonts" || failure "failed to rebuild font cache"
