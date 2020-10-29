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

SDIR=$(check_location "/../../")

# Create Directories

make_directory "${HOME}/Bin"
make_directory "${HOME}/.local/share/bash-completion/completions"

# Install Bin Scripts

install_file "${SDIR}/Linux/Arch/bash-completion/archrepo-chroot-build" "${HOME}/.local/share/bash-completion/completions/archrepo-chroot-build" 0755
install_file "${SDIR}/Linux/Arch/bash-completion/archrepo-sign-and-move" "${HOME}/.local/share/bash-completion/completions/archrepo-sign-and-move" 0755
install_file "${SDIR}/Linux/Arch/repo/archrepo-add-aur" "${HOME}/Bin/archrepo-add-aur" 0755
install_file "${SDIR}/Linux/Arch/repo/archrepo-chroot-build" "${HOME}/Bin/archrepo-chroot-build" 0755
install_file "${SDIR}/Linux/Arch/repo/archrepo-sign-and-move" "${HOME}/Bin/archrepo-sign-and-move" 0755
install_file "${SDIR}/Linux/Arch/repo/archrepo-update-aur-gits" "${HOME}/Bin/archrepo-update-aur-gits" 0755

