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

_scriptdir="$(dirname "${0}")"
. "${_scriptdir}/../../../script_common/common.sh" || exit 1


check_dir "${HOME}/.bash_exports"

make_directory "${HOME}/.cargo/bin"

install_file 0644 "${FILES_PATH}/bash_exports/export_rust" "${HOME}/.bash_exports/export_rust"

download_install_file 0644 "https://sh.rustup.rs" \
                           "${HOME}/.cargo/rustup.sh"

print_info "Configuring initial rust setup"
sh "${HOME}/.cargo/rustup.sh" --no-modify-path --default-toolchain none -y -q || failure "failed to configure intial rust setup"

if [[ -f  "${HOME}/.config/nvim/coc-settings.json" ]]; then

    neovim_buffer_text=$(cat <<EOF

    When the plugin installation is done,
    Please close neovim with :qa!

    Thanks for playing along!

EOF
)
print_info "Installing neovim coc plugins"
echo "${neovim_buffer_text}" | nvim -c "CocInstall rls"
fi

print_info "-"
print_info "You must restart your bash session in order to run 07_install_rust_tools.sh"
print_info "-"
