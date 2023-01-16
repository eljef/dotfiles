#!/bin/bash
# Copyright (C) 2021-2023 Jef Oliver.
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

# PACMAN_KEYSERVER - keyserver pacman should use to retrieve unknown keys
PACMAN_KEYSERVER="hkps://keyserver.ubuntu.com"

# PACMAN_KEYS - pgp keys to add to pacman
PACMAN_KEYS=()

# PACMAN_CHECK_SPACE - enable space checking for pacman if 1
PACMAN_CHECK_SPACE=1

# PACMAN_COLOR - enable color output for pacman if 1
PACMAN_COLOR=1

# PACMAN_PARALLEL_DOWNLOADS - enable parallel downloads and set to num if not 0
PACMAN_PARALLEL_DOWNLOADS=5

################################################################################
# DO NOT EDIT BELOW HERE
################################################################################

_scriptdir="$(dirname "${0}")"
. "${_scriptdir}/../../../../script_common/common.sh" || exit 1


check_root

print_info "Adding keyserver to pacman"
sed -i '/^keyserver /d' /etc/pacman.d/gnupg/gpg.conf || failure "failed to remove old keyserver line from /etc/pacman.d/gnupg/gpg.conf"
echo "keyserver ${PACMAN_KEYSERVER}" >> /etc/pacman.d/gnupg/gpg.conf || failure "failed to add new keyserver to /etc/pacman.d/gnupg/gpg.conf"

for key in "${PACMAN_KEYS[@]}"
do
    print_info "Adding PGP key to pacman: ${key}"
    pacman-key --recv-keys "${key}" || failure "failed to retrieve pgp key ${key}"
    pacman-key --lsign-key "${key}" || failure "failed to locally sign pgp key ${key}"
done

if [[ ${PACMAN_CHECK_SPACE} -eq 1 ]]; then
    print_info "Enabling space checking during pacman install and update"
    sed -i 's/^#CheckSpace/CheckSpace/' /etc/pacman.conf || failure "failed to enable space checking for pacman"
fi

if [[ ${PACMAN_COLOR} -eq 1 ]]; then
    print_info "Enabling color output for pacman"
    sed -i 's/^#Color/Color/' /etc/pacman.conf || failure "failed to enable color output for pacman"
fi

if [[ ${PACMAN_PARALLEL_DOWNLOADS} -gt 1 ]]; then
    print_info "Enabling ${PACMAN_PARALLEL_DOWNLOADS} parallel downloads for pacman"
    sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf || failure "failed to enable parallel downloads for pacman"
    sed -i "s/^ParallelDownloads.*/ParallelDownloads = ${PACMAN_PARALLEL_DOWNLOADS}/" /etc/pacman.conf || failure "failed to set number of parallel downloads for pacman"
fi
