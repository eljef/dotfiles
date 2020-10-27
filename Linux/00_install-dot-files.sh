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

SDIR=$(check_location "/../")

# Create Directories

make_directory "${HOME}/.bash_exports"
make_directory "${HOME}/.fonts"
make_directory "${HOME}/.local/share/bash-completion/completions"
make_directory "${HOME}/.local/share/konsole"
make_directory "${HOME}/.local/share/yakuake/kns_skins"
make_directory "${HOME}/Bin/include"

# Install Aliases and Exports

install_file "${SDIR}/dotfiles/bash_exports/alias_grep" "${HOME}/.bash_exports/alias_grep" 0644
install_file "${SDIR}/dotfiles/bash_exports/alias_ls" "${HOME}/.bash_exports/alias_ls" 0644
install_file "${SDIR}/dotfiles/bash_exports/export_editor" "${HOME}/.bash_exports/export_editor" 0644
install_file "${SDIR}/dotfiles/bash_exports/export_ps1" "${HOME}/.bash_exports/export_ps1" 0644
install_file "${SDIR}/dotfiles/bash_exports/export_visual" "${HOME}/.bash_exports/export_visual" 0644

# Install Bin Scripts

install_file "${SDIR}/dotfiles/Bin/include/eljef-bash-common" "${HOME}/Bin/include/eljef-bash-common" 0644
install_file "${SDIR}/dotfiles/Bin/read-md" "${HOME}/Bin/read-md" 0755
install_file "${SDIR}/dotfiles/Bin/tmux-git-branch" "${HOME}/Bin/tmux-git-branch" 0755
install_file "${SDIR}/dotfiles/Bin/yakuake-init-session" "${HOME}/Bin/yakuake-init-session" 0755
install_file "${SDIR}/dotfiles/Bin/yakuake-send" "${HOME}/Bin/yakuake-send" 0755
install_file "${SDIR}/dotfiles/Bin/yakuake-split-dev-2k" "${HOME}/Bin/yakuake-split-dev-2k" 0755

# Install Dot Files

install_file "${SDIR}/dotfiles/bash_profile" "${HOME}/.bash_profile" 0644
install_file "${SDIR}/dotfiles/bashrc" "${HOME}/.bashrc" 0644
install_file "${SDIR}/dotfiles/profile" "${HOME}/.profile" 0644
install_file "${SDIR}/dotfiles/tmux.conf" "${HOME}/.tmux.conf" 0644
install_file "${SDIR}/dotfiles/tmux.dev.conf" "${HOME}/.tmux.dev.conf" 0644
install_file "${SDIR}/dotfiles/tmux.split.conf" "${HOME}/.tmux.split.conf" 0644
install_file "${SDIR}/dotfiles/tmux.split.2k.conf" "${HOME}/.tmux.split.2k.conf" 0644

# Install Fonts

install_file "${SDIR}/dotfiles/fonts/Caskaydia Cove Nerd Font Complete Mono.ttf" "${HOME}/.fonts/Caskaydia Cove Nerd Font Complete Mono.ttf" 0644
install_file "${SDIR}/dotfiles/fonts/Caskaydia Cove Nerd Font Complete.ttf" "${HOME}/.fonts/Caskaydia Cove Nerd Font Complete.ttf" 0644
install_file "${SDIR}/dotfiles/fonts/Fira Code Bold Nerd Font Complete Mono.otf" "${HOME}/.fonts/Fira Code Bold Nerd Font Complete Mono.otf" 0644
install_file "${SDIR}/dotfiles/fonts/Fira Code Bold Nerd Font Complete.otf" "${HOME}/.fonts/Fira Code Bold Nerd Font Complete.otf" 0644
install_file "${SDIR}/dotfiles/fonts/Fira Code Light Nerd Font Complete Mono.otf" "${HOME}/.fonts/Fira Code Light Nerd Font Complete Mono.otf" 0644
install_file "${SDIR}/dotfiles/fonts/Fira Code Light Nerd Font Complete.otf" "${HOME}/.fonts/Fira Code Light Nerd Font Complete.otf" 0644
install_file "${SDIR}/dotfiles/fonts/Fira Code Medium Nerd Font Complete Mono.otf" "${HOME}/.fonts/Fira Code Medium Nerd Font Complete Mono.otf" 0644
install_file "${SDIR}/dotfiles/fonts/Fira Code Medium Nerd Font Complete.otf" "${HOME}/.fonts/Fira Code Medium Nerd Font Complete.otf" 0644
install_file "${SDIR}/dotfiles/fonts/Fira Code Regular Nerd Font Complete Mono.otf" "${HOME}/.fonts/Fira Code Regular Nerd Font Complete Mono.otf" 0644
install_file "${SDIR}/dotfiles/fonts/Fira Code Regular Nerd Font Complete.otf" "${HOME}/.fonts/Fira Code Regular Nerd Font Complete.otf" 0644
install_file "${SDIR}/dotfiles/fonts/Fira Code Retina Nerd Font Complete Mono.otf" "${HOME}/.fonts/Fira Code Retina Nerd Font Complete Mono.otf" 0644
install_file "${SDIR}/dotfiles/fonts/Fira Code Retina Nerd Font Complete.otf" "${HOME}/.fonts/Fira Code Retina Nerd Font Complete.otf" 0644

echo " --==-- Running Font Cache"
fc-cache -f ~/.fonts

# Install Konsole

install_file "${SDIR}/dotfiles/local/share/konsole/dracula.colorscheme" "${HOME}/.local/share/konsole/dracula.colorscheme" 0644
install_file "${SDIR}/dotfiles/local/share/konsole/Main.Profile" "${HOME}/.local/share/konsole/Main.Profile" 0644

# Install Yakuake

echo " --==-- ${SDIR}/dotfiles/local/share/yakuake/kns_skins/pixelnine -> ${HOME}/.local/share/yakuake/kns_skins/pixelnine"
cp -R "${SDIR}/dotfiles/local/share/yakuake/kns_skins/pixelnine" "${HOME}/.local/share/yakuake/kns_skins/"

