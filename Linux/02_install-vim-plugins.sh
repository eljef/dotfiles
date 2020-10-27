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

# Download vim plug
echo " --==-- Downloading Vim Plug"
curl -fLo "${HOME}/.vim/autoload/plug.vim" "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" || echo_error "Error downloading vim-plug"

NEWTMP=$(mktemp) || echo_error "Failed to create temp file: 1"
echo "Installing Plugins." > "${NEWTMP}" || echo_error "Failed to create temp file: 2"
echo "Please manually close neovim when done." >> "${NEWTMP}" || echo_error "Failed to create temp file: 3"
echo ":qa" >> "${NEWTMP}" || echo_error "Failed to create temp file: 4"

# Download Plugins
echo " --==-- Installing Plugins"
vim -c "e ${NEWTMP}" -c "PlugInstall" || echo_error "Error Installing Plugins in nvim"

echo " --==-- Installing COC Plugins"
vim -c "e ${NEWTMP}" \
    -c "CocInstall coc-css \
                   coc-diagnostic \
                   coc-docker \
                   coc-highlight \
                   coc-html \
                   coc-json \
                   coc-markdownlint \
                   coc-python \
                   coc-rls \
                   coc-sh \
                   coc-tsserver \
                   coc-vetur \
                   coc-yaml" || echo_error "Error Installing COC Plugins in nvim"

delete_file "${NEWTMP}"

