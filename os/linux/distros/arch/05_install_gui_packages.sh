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

################################################################################
# DO NOT EDIT BELOW HERE
################################################################################

function failure() {
    echo -e "\n${1}\n" 2>&1
    exit 1
}

if [[ ${EUID} -ne 0 ]]; then
    failure "This script must be run as root."
fi

echo "Installing packages with pacman"
pacman -S bitwarden-bin \
          fira-code-git \
          firefox \
          gnu-free-fonts \
          google-chrome-dev \
          joplin \
          kde-applications-meta \
          phonon-qt5-gstreamer \
          plasma-meta \
          sddm-theme-archpaint2-breeze \
          ttf-dejavu \
          ttf-droid \
          ttf-google-fonts-git \
          ttf-liberation \
          typora \
          xcursor-gt3 \
          xorg-bdftopcf \
          xorg-font-util \
          xorg-fonts-100dpi \
          xorg-fonts-75dpi \
          xorg-fonts-encodings \
          xorg-iceauth \
          xorg-mkfontscale \
          xorg-server \
          xorg-server-common \
          xorg-sessreg \
          xorg-setxkbmap \
          xorg-smproxy \
          xorg-x11perf \
          xorg-xauth \
          xorg-xbacklight \
          xorg-xcmsdb \
          xorg-xcursorgen \
          xorg-xdpyinfo \
          xorg-xdriinfo \
          xorg-xev \
          xorg-xgamma \
          xorg-xhost \
          xorg-xinit \
          xorg-xinput \
          xorg-xkbcomp \
          xorg-xkbevd \
          xorg-xkbutils \
          xorg-xrandr \
          xorg-xrdb \
          xorg-xrefresh \
          xorg-xset \
          xorg-xsetroot \
          xorg-xvinfo \
          xorg-xwd \
          xorg-xwininfo \
          xorg-xwud \
          yakuake || failure "failed to install packages with pacman"
