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

# PACMAN_KEYS - pgp keys to add to pacman
PACMAN_KEYS=('12F0B2A79BFE57E580B6C91A56989CA26462201F')

################################################################################
# DO NOT EDIT BELOW HERE
################################################################################

_scriptdir="$(dirname "${0}")"
. "${_scriptdir}/../../../../script_common/common.sh" || exit 1

_KEYRING_VER="20231022"
_KEYRING_BLD="1"
_REPO_VER="20211018"
_REPO_BLD="2"

check_root

for key in "${PACMAN_KEYS[@]}"
do
    print_info "Adding PGP key to pacman: ${key}"
    pacman-key --recv-keys "${key}" || failure "failed to retrieve pgp key ${key}"
    pacman-key --lsign-key "${key}" || failure "failed to locally sign pgp key ${key}"
done

print_info "Adding ElJef Keyring to pacman"
pacman -U --noconfirm https://eljef.me/arch/x86_64/eljef-keyring-${_KEYRING_VER}-${_KEYRING_BLD}-any.pkg.tar.zst || failure "failed to install eljef-keyring"

print_info "Adding ElJef Arch Linux Repository to pacman"
pacman -U --noconfirm https://eljef.me/arch/x86_64/eljef-repo-${_REPO_VER}-${_REPO_BLD}-any.pkg.tar.zst || failure "failed to install eljef-repo"
sed -i '/eljef/d' /etc/pacman.conf || failure "failed to remove any previous eljef lines from /etc/pacman.conf"
echo 'Include = /etc/pacman.d/eljef-repo.conf' >> /etc/pacman.conf || failure "failed to add eljef repository to /etc/pacman.conf"
pacman -Sy || failure "failed to update pacman databases"

