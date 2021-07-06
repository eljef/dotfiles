#!/bin/bash
# Copyright (C) 2021 Jef Oliver.
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

function failure() {
    echo -e "\n${1}\n" 2>&1
    exit 1
}

function make_directory() {
    mkdir -p "${1}" || failure "failed to create directory ${1}"
}

# Create directories

make_directory  "${HOME}/.local/share/bash-completion/completions"

# Install stable rust toolchain
echo "Installing stable rust toolchain"
rustup toolchain install stable || failure "Could not install stable rust toolchain."

# Setup bash completions for rust tools

echo "Setting up bash completions for rust tools"
rustup completions bash >> ~/.local/share/bash-completion/completions/rustup || failure "Could not setup bash completions for rustup"
rustup completions bash cargo >> ~/.local/share/bash-completion/completions/cargo || failure "Could not setup bash completions for cargo"

# Install RLS
echo "Install RLS"
rustup component add rls rust-analysis rust-src || failure "Could not install RLS"
