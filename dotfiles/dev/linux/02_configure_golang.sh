#!/bin/bash
# Copyright (c) 2020-2024, Jef Oliver
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
# SPDX-License-Identifier: 0BSD
#
# Authors:
# Jef Oliver <jef@eljef.me>

. "/usr/lib/eljef_bash/eljef-bash-common.sh" || exit 1
_basedir="$(base_dir "$(dirname "${0}")" "script_common")"

check_installed "go"

FILES_PATH="${_basedir}/dotfiles/dev/files"
check_dir "${FILES_PATH}"
check_file "${HOME}/.bashrc"
check_dir "${HOME}/.bash_exports"

install_file 0644 "${FILES_PATH}/bash_exports/export_golang" "${HOME}/.bash_exports/export_golang"

print_warn "-"
print_warn "Please edit ~/.bash_exports/export_golang to include the correct path"
print_warn "  * Don't forget to create the directory as well"
print_warn "-"
print_warn "You must restart your bash session in order to run 03_install_golang_tools.sh"
print_warn "-"
