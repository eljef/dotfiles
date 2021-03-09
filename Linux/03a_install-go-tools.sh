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

make_directory "${GOPATH}/bin"
make_directory "/tmp/go/bin"
make_directory "/tmp/go/pkg"
make_directory "/tmp/go/src"

# Override the current GOPATH to protect source trees

OLD_GO_PATH="${GOPATH}"
export GOPATH="/tmp/go"

# all of the tools to download
GO_GET_PATHS=('github.com/golang/dep/cmd/dep'
              'github.com/go-lintpack/lintpack/...'
              'github.com/go-critic/go-critic/...'
              'github.com/timakin/bodyclose'
              'github.com/tsenart/deadcode'
              'github.com/mibk/dupl'
              'github.com/kisielk/errcheck'
              '4d63.com/gochecknoinits'
              'github.com/uudashr/gocognit/cmd/gocognit'
              'github.com/jgautheron/goconst/cmd/goconst'
              'github.com/alecthomas/gocyclo'
              'golang.org/x/lint/golint'
              'github.com/securego/gosec/cmd/gosec/...'
              'github.com/gordonklaus/ineffassign'
              'github.com/mdempsky/maligned'
              'github.com/alexkohler/nakedret'
              'github.com/kyoh86/scopelint'
              'gitlab.com/opennota/check/cmd/structcheck'
              'github.com/mdempsky/unconvert'
              'mvdan.cc/unparam'
              'gitlab.com/opennota/check/cmd/varcheck'
              'github.com/cweill/gotests/...'
              'honnef.co/go/tools/...'
              'github.com/klauspost/asmfmt/cmd/asmfmt'
              'github.com/go-delve/delve/cmd/dlv'
              'github.com/davidrjenni/reftools/cmd/fillstruct'
              'github.com/davidrjenni/reftools/cmd/fillswitch'
              'github.com/davidrjenni/reftools/cmd/fixplurals'
              'github.com/rogpeppe/godef'
              'github.com/zmb3/gogetdoc'
              'github.com/fatih/gomodifytags'
              'golang.org/x/tools/cmd/goimports'
              'golang.org/x/tools/cmd/gorename'
              'github.com/jstemmer/gotags'
              'golang.org/x/tools/cmd/guru'
              'github.com/koron/iferr'
              'github.com/josharian/impl'
              'honnef.co/go/tools/cmd/keyify'
              'github.com/fatih/motion')
#              'github.com/charmbracelet/glow')

# download the tools
for getpath in "${GO_GET_PATHS[@]}"
do
    echo " --==-- go get -u ${getpath}"
    GO111MODULE=off go get -u "${getpath}" || echo_error "Failed to install ${getpath}"
done

# install golangci-lint
echo " --==-- go get github.com/golangci/golangci-lint/cmd/golangci-lint"
GO111MODULE=on go get 'github.com/golangci/golangci-lint/cmd/golangci-lint' || echo_error "Failed to install golangci-lint"

# install gopls
echo " --==-- GO111MODULE=on go get golang.org/x/tools/gopls@latest"
GO111MODULE=on go get golang.org/x/tools/gopls@latest || echo_error "Failed to install gopls"

# build gocritic because it has to be different from all of the other tools...
echo " --==-- Building gocritic"
cd "${GOPATH}/src/github.com/go-critic/go-critic" || echo_error "Failed to change to go-critic directory"
PATH="${GOPATH}/bin:${PATH}" make gocritic || echo_error "Failed to build gocritic"
mv gocritic "${GOPATH}/bin" || echo_error "Failed to install gocritic"

# copy the build binaries to the real GOPATH
cd "${GOPATH}/bin" || echo_error "Failed to change directory to GOPATH/bin"
export GOPATH="${OLD_GO_PATH}"
for i in *
do
    echo " --==-- Installing ${i}"
    mv "${i}" "${GOPATH}/bin" || echo_error "Failed to install ${i}"
done

# cleanup, which includes fixing permissions because the source download
# sets weird permissions
cd /tmp/go || echo_error "Failed to change to temporary go directory"
find . -type d -print0 | xargs -0 chmod 0755
find . -type f -print0 | xargs -0 chmod 0644
cd /tmp || echo_error "Failed to change to tmp directory"
rm -rf go || echo_error "Failed to delete temporary go directory"

