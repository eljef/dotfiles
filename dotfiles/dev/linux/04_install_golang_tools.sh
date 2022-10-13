#!/bin/bash
# Copyright (C) 2021-2022 Jef Oliver.
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

. "/usr/lib/eljef_bash/eljef-bash-common.sh" || exit 1

check_installed "go"

if [[ "${GOPATH}" == "" ]]; then
    GOPATH=$(go env GOPATH)
    export GOPATH
fi

make_directory "${GOPATH}/bin"
make_directory "/tmp/go/bin"
make_directory "/tmp/go/pkg"
make_directory "/tmp/go/src"

# Override the current GOPATH to protect source trees

OLD_GO_PATH="${GOPATH}"
GOPATH="/tmp/go"
export GOPATH

# all of the tools to download
GO_GET_PATHS=('github.com/klauspost/asmfmt/cmd/asmfmt'
              'honnef.co/go/tools/...'
              'github.com/timakin/bodyclose'
              'github.com/bkielbasa/cyclop/cmd/cyclop'
              'github.com/tsenart/deadcode'
              'github.com/go-delve/delve/cmd/dlv'
              'github.com/mibk/dupl'
              'github.com/kisielk/errcheck'
              'github.com/polyfloyd/go-errorlint'
              'github.com/davidrjenni/reftools/cmd/fillstruct'
              'github.com/davidrjenni/reftools/cmd/fillswitch'
              'github.com/davidrjenni/reftools/cmd/fixplurals'
              '4d63.com/gochecknoinits'
              'github.com/uudashr/gocognit/cmd/gocognit'
              'github.com/jgautheron/goconst/cmd/goconst'
              'github.com/alecthomas/gocyclo'
              'github.com/rogpeppe/godef'
              'github.com/zmb3/gogetdoc'
              'golang.org/x/tools/cmd/goimports'
              'github.com/fatih/gomodifytags'
              'golang.org/x/tools/gopls'
              'golang.org/x/tools/cmd/gorename'
              'github.com/securego/gosec/cmd/gosec/...'
              'github.com/jstemmer/gotags'
              'github.com/cweill/gotests/...'
              'golang.org/x/tools/cmd/guru'
              'github.com/koron/iferr'
              'github.com/gordonklaus/ineffassign'
              'github.com/josharian/impl'
              'honnef.co/go/tools/cmd/keyify'
              'github.com/go-lintpack/lintpack/...'
              'github.com/fatih/motion'
              'github.com/alexkohler/nakedret'
              'github.com/mgechev/revive'
              'gitlab.com/opennota/check/cmd/structcheck'
              'github.com/mdempsky/unconvert'
              'mvdan.cc/unparam'
              'gitlab.com/opennota/check/cmd/varcheck'
              'github.com/go-critic/go-critic/cmd/gocritic'
              'github.com/golangci/golangci-lint/cmd/golangci-lint')

# download the tools
for getpath in "${GO_GET_PATHS[@]}"
do
    print_info "go install ${getpath}@latest"
    go install "${getpath}@latest" >/dev/null 2>&1 || failure "Failed to compile ${getpath}"
done

# reset gopath
GOPATH="${OLD_GO_PATH}"
export GOPATH

# copy the build binaries to the real GOPATH
cd_or_error "/tmp/go/bin"
for i in *
do
    install_file 0755 "${i}" "${GOPATH}/bin/${i}"
done

# cleanup, which includes fixing permissions because the source download
# sets weird permissions
cd_or_error /tmp/go
find . -type d -print0 | xargs -0 chmod 0755 || failure "Failed to fix directory permissions "
find . -type f -print0 | xargs -0 chmod 0644 || failure "Failed to fix file permissions"
cd_or_error /tmp
rm -rf go || failure "Failed to delete temporary go directory"

print_info "-"
print_info "This script can be re-run in the future to update any installed tools."
print_info "-"
