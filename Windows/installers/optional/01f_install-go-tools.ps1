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

$commonScript = Resolve-Path -LiteralPath `
                $(Join-Path -Path $(Split-Path $MyInvocation.MyCommand.Source -Parent) `
                -ChildPath "..\common.ps1")
. $commonScript

Confirm-Install go golang | Out-Null
Confirm-Install make make | Out-Null

$cwd = $(Get-Location).Path
$goPath = $((go env GOPATH) | Out-String).Trim()
$goPathBin = $(Join-Path -Path "$goPath" -ChildPath "bin")
$newGoPath = $(Join-Path -Path "$env:TEMP" -ChildPath "go")
$newGoBin = $(Join-Path -Path "$newGoPath" -ChildPath "bin")

# Create directories
New-Directory $(Join-Path -Path "$goPath" -ChildPath "bin")
New-Directory $(Join-Path -Path "$newGoPath" -ChildPath "bin")
New-Directory $(Join-Path -Path "$newGoPath" -ChildPath "pkg")
New-Directory $(Join-Path -Path "$newGoPath" -ChildPath "src")

# Override the current GOPATH to protect source trees
$oldGoPath = $goPath
$env:GOPATH = $newGoPath

# all of the tools to download
$goGetPaths = @('github.com/golang/dep/cmd/dep',
                'github.com/go-lintpack/lintpack/...',
                'github.com/timakin/bodyclose',
                'github.com/tsenart/deadcode',
                'github.com/mibk/dupl',
                'github.com/kisielk/errcheck',
                '4d63.com/gochecknoinits',
                'github.com/uudashr/gocognit/cmd/gocognit',
                'github.com/jgautheron/goconst/cmd/goconst',
                'github.com/alecthomas/gocyclo',
                'golang.org/x/lint/golint',
                'github.com/securego/gosec/cmd/gosec/...',
                'github.com/gordonklaus/ineffassign',
                'github.com/mdempsky/maligned',
                'github.com/alexkohler/nakedret',
                'github.com/kyoh86/scopelint',
                'gitlab.com/opennota/check/cmd/structcheck',
                'github.com/mdempsky/unconvert',
                'mvdan.cc/unparam',
                'gitlab.com/opennota/check/cmd/varcheck',
                'github.com/cweill/gotests/...',
                'honnef.co/go/tools/...',
                'github.com/klauspost/asmfmt/cmd/asmfmt',
                'github.com/go-delve/delve/cmd/dlv',
                'github.com/davidrjenni/reftools/cmd/fillstruct',
                'github.com/davidrjenni/reftools/cmd/fillswitch',
                'github.com/davidrjenni/reftools/cmd/fixplurals',
                'github.com/rogpeppe/godef',
                'github.com/zmb3/gogetdoc',
                'github.com/fatih/gomodifytags',
                'golang.org/x/tools/cmd/goimports',
                'golang.org/x/tools/cmd/gorename',
                'github.com/jstemmer/gotags',
                'golang.org/x/tools/cmd/guru',
                'github.com/koron/iferr',
                'github.com/josharian/impl',
                'honnef.co/go/tools/cmd/keyify',
                'github.com/fatih/motion')

# download the tools
$env:GO111MODULE = "off"

Write-Host " --==-- System GOPATH: $goPath"
Write-Host " --==-- Temp GOPATH: $newGoPath"

foreach ($getPath in $goGetPaths) {
    Write-Host " --==-- go get -u $getpath"
    Invoke-Executable "go" @("get", "-u", "$getPath")
}

$env:GO111MODULE = "on"

# install golangci-lint
Write-Host " --==-- go get github.com/golangci/golangci-lint/cmd/golangci-lint"
Invoke-Executable "go" @("get", "github.com/golangci/golangci-lint/cmd/golangci-lint")

# install gopls
Write-Host " --==-- go get golang.org/x/tools/gopls@latest"
Invoke-Executable "go" @("get", "golang.org/x/tools/gopls@latest")

# copy the build binaries to the real GOPATH
Set-Location "$newGoBin" | Out-Null

$env:GOPATH = $oldGoPath
$files = Get-ChildItem "$newGoBin"
foreach ($file in $files) {
    $fileOnly = Split-Path -Path $file -Leaf
    Write-Host " --==-- Installing $fileOnly"
    Copy-File "$file" $(Join-Path -Path "$goPathBin" -ChildPath "$fileOnly")
}

# cleanup the mess in the temp directory
Set-Location "$cwd" | Out-Null
Write-Host " --==-- Cleaning Up Temp GOPATH"
Remove-Item "$newGoPath" -Recurse -Force

