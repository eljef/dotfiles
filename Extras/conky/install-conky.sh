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

. ../../Linux/common

SDIR=$(check_location "/../../")

# Create Directories

make_directory "${HOME}/.config/conky"

# Install Configuration Files

copy_dir "${SDIR}/Extras/conky/config/conky/conky1" "${HOME}/.config/conky/"
copy_dir "${SDIR}/Extras/conky/config/conky/conky2" "${HOME}/.config/conky/"

cd "${HOME}/.config/conky/" || echo_error "Could not change directory to ${HOME}/.config/conky/"
git clone https://github.com/zagortenay333/conky-Vision conky-vision

