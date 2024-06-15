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

################################################################################
# DO NOT EDIT BELOW HERE
################################################################################

_scriptdir="$(dirname "${0}")"
# shellcheck source=../../../../../script_common/common.sh
. "${_scriptdir}/../../../../../script_common/common.sh" || exit 1

_starship_archive="starship-x86_64-unknown-linux-musl.tar.gz"
_starship_tmp="/tmp/${_starship_archive}"
_starship_url="https://github.com/starship/starship/releases/latest/download/${_starship_archive}"

check_root

print_info "curl --fail --location ${_starship_url} --output ${_starship_tmp}"
curl --fail --silent --location ${_starship_url} --output ${_starship_tmp} || failure "Could not download starship"

print_info "tar -xzf \"${_starship_tmp}\" -C \"/usr/local/bin\""
tar -xzf "${_starship_tmp}" -C "/usr/local/bin" || failure "Could not extract starship"

print_info "chmod 755 /usr/local/bin/starship"
chmod 755 /usr/local/bin/starship || failure "Could not set executable mode for starship"

print_info "rm ${_starship_tmp}"
rm "${_starship_tmp}"

