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

_PACKAGES=("bitwarden"
           "chromium"
           "firefox"
           "gnu-free-fonts"
           "graphite-cursor-theme-git"
           "kde-applications-meta"
           "noto-fonts-cjk"
           "phonon-qt5-gstreamer"
           "pipewire-jack"
           "plasma-meta"
           "python-pyqt5"
           "sddm-theme-corners-git"
           "tesseract-data-eng"
           "ttf-dejavu"
           "ttf-droid"
           "ttf-fira-code"
           "ttf-google-fonts-typewolf"
           "ttf-liberation"
           "ttf-jetbrains-mono-nerd"
           "wireplumber"
           "xdg-desktop-portal-kde"
           "xorg-bdftopcf"
           "xorg-font-util"
           "xorg-fonts-100dpi"
           "xorg-fonts-75dpi"
           "xorg-fonts-encodings"
           "xorg-iceauth"
           "xorg-mkfontscale"
           "xorg-server"
           "xorg-server-common"
           "xorg-sessreg"
           "xorg-setxkbmap"
           "xorg-smproxy"
           "xorg-x11perf"
           "xorg-xauth"
           "xorg-xbacklight"
           "xorg-xcmsdb"
           "xorg-xcursorgen"
           "xorg-xdpyinfo"
           "xorg-xdriinfo"
           "xorg-xev"
           "xorg-xgamma"
           "xorg-xhost"
           "xorg-xinit"
           "xorg-xinput"
           "xorg-xkbcomp"
           "xorg-xkbevd"
           "xorg-xkbutils"
           "xorg-xrandr"
           "xorg-xrdb"
           "xorg-xrefresh"
           "xorg-xset"
           "xorg-xsetroot"
           "xorg-xvinfo"
           "xorg-xwd"
           "xorg-xwininfo"
           "xorg-xwud")

################################################################################
# DO NOT EDIT BELOW HERE
################################################################################

. "/usr/lib/eljef_bash/eljef-bash-common.sh" || exit 1

print_info "Installing packages with pacman"
pacman -S "${_PACKAGES[@]}" || failure "failed to install packages with pacman"
