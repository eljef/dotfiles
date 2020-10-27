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

. ../common

check_root
SDIR=$(check_location "/../../")

echo "keyserver hkp://pool.sks-keyservers.net" >> /etc/pacman.d/gnupg/gpg.conf || echo_error "failed to add keyserver"

pacman-key --recv-keys 12F0B2A79BFE57E580B6C91A56989CA26462201F || echo_error "failed to grab key"
pacman-key --lsign-key 12F0B2A79BFE57E580B6C91A56989CA26462201F || echo_error "failed to sign key"
pacman -U https://eljef.me/arch/core/eljef-keyring-20191024-1-any.pkg.tar.xz || echo_error "failed to install keyring"
pacman -U https://eljef.me/arch/core/eljef-repo-core-20161118-1-any.pkg.tar.xz || echo_error "failed to install core repo"

echo "Include = /etc/pacman.d/eljef-repo-*.conf" >> /etc/pacman.conf || echo_error "failed to add repo configs"

pacman -Sy || echo_error "failed to update pacman"
pacman -S eljef-repo-apps eljef-repo-devel eljef-repo-media eljef-repo-misc || echo_error "failed to install eljef repos"
pacman -Sy || echo_error "failed to update pacman 2"

