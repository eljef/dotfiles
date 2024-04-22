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

_PACKAGES=("bash-completion"
           "bash-eljef-common"
           "cronie"
           "neovim"
           "openssh"
           "python-colorama"
           "python-colorlog"
           "python-msgpack"
           "python-pip"
           "python-pyaml"
           "python-u-msgpack"
           "python-unidecode"
           "python-xmltodict"
           "starship"
           "sudo"
           "tmux"
           "tree-sitter-grammars"
           "wget")

################################################################################
# DO NOT EDIT BELOW HERE
################################################################################

_scriptdir="$(dirname "${0}")"
. "${_scriptdir}/../../../../script_common/common.sh" || exit 1


check_root

print_info "Installing packages with pacman"
pacman -S "${_PACKAGES[@]}" || failure "failed to install packages with pacman"
