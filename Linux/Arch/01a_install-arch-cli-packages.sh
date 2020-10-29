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

. ../common

check_root

pacman -Syu --noconfirm \
            bash-completion \
            bash-language-server \
            cronie \
            diff-so-fancy \
            flake8 \
            fuse2 \
            gstreamer-vaapi \
            gst-editing-services \
            gst-plugins-ugly \
            git \
            make \
            nodejs \
            nodejs-markdownlint-cli \
            npm \
            neovim \
            nvm \
            openssh \
            python-black \
            python-colorama \
            python-colorlog \
            python-pip \
            python-pyaml \
            python-pylint \
            python-pytest \
            python-pytest-cov \
            python-unidecode \
            python-xmltodict \
            shellcheck \
            sudo \
            tmux \
            vim \
            write-good

