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
# Jef Oliver <jef@eljef.me>>

. "/usr/lib/eljef_bash/eljef-bash-common.sh" || exit 1

check_isntalled "rustup"

make_directory  "${HOME}/.local/share/bash-completion/completions"

# Install stable rust toolchain
print_info "Installing stable rust toolchain"
rustup toolchain install stable || failure "Could not install stable rust toolchain."

# Setup bash completions for rust tools

print_info "Setting up bash completions for rust tools"
rustup completions bash >> ~/.local/share/bash-completion/completions/rustup || failure "Could not setup bash completions for rustup"
rustup completions bash cargo >> ~/.local/share/bash-completion/completions/cargo || failure "Could not setup bash completions for cargo"

# Install RLS
print_info "Installing RLS"
rustup component add rls rust-analysis rust-src || failure "Could not install RLS"
