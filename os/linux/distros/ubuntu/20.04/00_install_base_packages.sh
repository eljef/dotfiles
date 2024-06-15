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

_PACKAGES=("bash-completion"
           "neovim"
           "openssh-server"
           "python-is-python3"
           "python3-colorama"
           "python3-colorlog"
           "python3-msgpack"
           "python3-pip"
           "python3-u-msgpack"
           "python3-unidecode"
           "python3-xmltodict"
           "python3-yaml"
           "ssh"
           "tmux"
           "wget")

################################################################################
# DO NOT EDIT BELOW HERE
################################################################################


_scriptdir="$(dirname "${0}")"
# shellcheck source=../../../../../script_common/common.sh
. "${_scriptdir}/../../../../../script_common/common.sh" || exit 1


check_root

print_info "Installing packages with apt"
apt install "${_PACKAGES[@]}" || failure "failed to install packages with apt"
