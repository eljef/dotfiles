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

. common

# Create directories

make_directory "${HOME}/.local/share/bash-completion/completions"

# Install stable rust toolchain
rustup toolchain install stable || echo_error "Could not install stable rust toolchain."

# Setup bash completions for rust tools

rustup completions bash >> ~/.local/share/bash-completion/completions/rustup || echo_error "Could not setup bash completions for rustup"
rustup completions bash cargo >> ~/.local/share/bash-completion/completions/cargo || echo_error "Could not setup bash completions for cargo"

# Install RLS
rustup component add rls rust-analysis rust-src || echo_error "Could not install RLS"

