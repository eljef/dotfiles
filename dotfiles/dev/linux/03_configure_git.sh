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


function git_config_global() {
    print_info "git config --global \"${1}\" \"${2}\""
    git config --global "${1}" "${2}" || failure "git global configuration failed: \"${1}\" = \"${2}\""
}

git_config_global "core.editor" "nvim"
git_config_global "core.pager" "diff-so-fancy | less --tabs=4 -RFX"
git_config_global "color.ui" "true"
git_config_global "color.diff-highlight.oldNormal" "red bold"
git_config_global "color.diff-highlight.oldHighlight" "red bold 52"
git_config_global "color.diff-highlight.newNormal" "green bold"
git_config_global "color.diff-highlight.newHighlight" "green bold 22"
git_config_global "color.diff.meta" "11"
git_config_global "color.diff.frag" "magenta bold"
git_config_global "color.diff.commit" "yellow bold"
git_config_global "color.diff.old" "red bold"
git_config_global "color.diff.new" "green bold"
git_config_global "color.diff.whitespace" "red reverse"
