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

# PACMAN_KEYS - pgp keys to add to pacman
PACMAN_KEYS=('12F0B2A79BFE57E580B6C91A56989CA26462201F')

################################################################################
# DO NOT EDIT BELOW HERE
################################################################################

function failure() {
    echo -e "\n${1}\n" 2>&1
    exit 1
}

if [[ ${EUID} -ne 0 ]]; then
    failure "This script must be run as root."
fi

for key in "${PACMAN_KEYS[@]}"
do
    echo "Adding PGP key to pacman: ${key}"
    pacman-key --recv-keys "${key}" || failure "failed to retrieve pgp key ${key}"
    pacman-key --lsign-key "${key}" || failure "failed to locally sign pgp key ${key}"
done

echo "Adding ElJef Keyring to pacman"
pacman -U --noconfirm https://eljef.me/arch/core/eljef-keyring-20191024-1-any.pkg.tar.xz || failure "failed to install eljef-keyring"

echo "Adding ElJef Core Repository to pacman"
pacman -U --noconfirm https://eljef.me/arch/core/eljef-repo-core-20161118-1-any.pkg.tar.xz || failure "failed to install eljef-repo-core"
sed -i '/eljef/d' /etc/pacman.conf || failure "failed to remove any previous eljef lines from /etc/pacman.conf"
echo 'Include = /etc/pacman.d/eljef-repo-*.conf' >> /etc/pacman.conf || failure "failed to add eljef repos to /etc/pacman.conf"
pacman -Sy || failure "failed to update pacman databases"

echo "Adding ElJef Repositories: apps, devel, media, misc"
pacman -S --noconfirm eljef-repo-apps eljef-repo-devel eljef-repo-media eljef-repo-misc || failure "failed to install eljef repositories"
pacman -Sy || failure "failed to update pacman databases"
