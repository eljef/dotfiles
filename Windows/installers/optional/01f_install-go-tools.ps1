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

. ..\common.ps1

Confirm-Install go golang | Out-Null
Confirm-Install make make | Out-Null

$cwd = $(Get-Location).Path
$goPath = $((go env GOPATH) | Out-String).Trim()
$goPathBin = $(Join-Path -Path "$goPath" -ChildPath "bin")
$newGoPath = $(Join-Path -Path "$env:TEMP" -ChildPath "go")
$newGoBin = $(Join-Path -Path "$newGoPath" -ChildPath "bin")
$errFile = $(Join-Path -Path "$newGoPath" -ChildPath "err.txt")

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
                'github.com/go-critic/go-critic/...',
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
    Remove-FileIfExists "$errFile"

    Write-Host " --==-- go get -u $getpath"

    $procInfo = Start-Process "go" -ArgumentList "get", "-u", "$getPath" `
                    -wait -NoNewWindow -PassThru -RedirectStandardError "$errFile"

    if ($procInfo.ExitCode -ne 0) {
        Exit-Error "Failed to install $getpath" $(Get-Content "$errFile")
    }
}

$env:GO111MODULE = "on"

# install golangci-lint
Remove-FileIfExists "$errFile"

Write-Host " --==-- go get github.com/golangci/golangci-lint/cmd/golangci-lint"

$procInfo = Start-Process "go" `
                -ArgumentList "get", "github.com/golangci/golangci-lint/cmd/golangci-lint" `
                -wait -NoNewWindow -PassThru -RedirectStandardError "$errFile"

if ($procInfo.ExitCode -ne 0) {
    Exit-Error "Failed to install golangci-lint" $(Get-Content "$errFile")
}

# install gopls
Remove-FileIfExists "$errFile"

Write-Host " --==-- go get golang.org/x/tools/gopls@latest"

$procInfo = Start-Process "go" -ArgumentList "get", "golang.org/x/tools/gopls@latest" `
                -wait -NoNewWindow -PassThru -RedirectStandardError "$errFile"

if ($procInfo.ExitCode -ne 0) {
    Exit-Error "Failed to install gopls" $(Get-Content "$errFile")
}

# build gocritic because it has to be different from all of the other tools...
Remove-FileIfExists "$errFile"

Write-Host " --==-- Building gocritic"

Set-Location $(Join-Path -Path "$newGoPath" -ChildPath "src\github.com\go-critic\go-critic") | Out-Null

$procInfo = Start-Process "make" -ArgumentList "gocritic" `
                -wait -NoNewWindow -PassThru -RedirectStandardError "$errFile"

if ($procInfo.ExitCode -ne 0) {
    Exit-Error "Failed to build gocritic" $(Get-Content "$errFile")
}

Copy-File gocritic $(Join-Path -Path "$goPath" -ChildPath "bin\gocritic.exe")

# copy the build binaries to the real GOPATH
Set-Location "$newGoBin" | Out-Null

$env:GOPATH = $oldGoPath
$files = Get-ChildItem "$newGoBin"
foreach ($file in $files) {
    $fileOnly = Split-Path -Path $file -Leaf
    Write-Host " --==-- Installing $fileOnly"
    Copy-File "$file" $(Join-Path -Path "$goPathBin" -ChildPath "$fileOnly")
}

Set-Location "$cwd"
Remove-Item "$newGoPath" -Recurse -Force

