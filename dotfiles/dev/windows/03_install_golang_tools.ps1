# Copyright (c) 2020-2024, Jef Oliver
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
# SPDX-License-Identifier: 0BSD
#
# Authors:
# Jef Oliver <jef@eljef.me>

# all of the tools to download
$goGetPaths = @('github.com/klauspost/asmfmt/cmd/asmfmt',
                'honnef.co/go/tools/...',
                'github.com/timakin/bodyclose',
                'github.com/bkielbasa/cyclop/cmd/cyclop',
                'github.com/tsenart/deadcode',
                'github.com/go-delve/delve/cmd/dlv',
                'github.com/mibk/dupl',
                'github.com/kisielk/errcheck',
                'github.com/polyfloyd/go-errorlint',
                'github.com/davidrjenni/reftools/cmd/fillstruct',
                'github.com/davidrjenni/reftools/cmd/fillswitch',
                'github.com/davidrjenni/reftools/cmd/fixplurals',
                '4d63.com/gochecknoinits',
                'github.com/uudashr/gocognit/cmd/gocognit',
                'github.com/jgautheron/goconst/cmd/goconst',
                'github.com/alecthomas/gocyclo',
                'github.com/rogpeppe/godef',
                'github.com/zmb3/gogetdoc',
                'golang.org/x/tools/cmd/goimports',
                'github.com/fatih/gomodifytags',
                'golang.org/x/tools/gopls',
                'golang.org/x/tools/cmd/gorename',
                'github.com/securego/gosec/cmd/gosec/...',
                'github.com/jstemmer/gotags',
                'github.com/cweill/gotests/...',
                'golang.org/x/tools/cmd/guru',
                'github.com/koron/iferr',
                'github.com/gordonklaus/ineffassign',
                'github.com/josharian/impl',
                'honnef.co/go/tools/cmd/keyify',
                'github.com/go-lintpack/lintpack/...',
                'github.com/fatih/motion',
                'github.com/alexkohler/nakedret/cmd/nakedret',
                'github.com/mgechev/revive',
                'gitlab.com/opennota/check/cmd/structcheck',
                'github.com/mdempsky/unconvert',
                'mvdan.cc/unparam',
                'gitlab.com/opennota/check/cmd/varcheck',
                'github.com/go-critic/go-critic/cmd/gocritic',
                'github.com/golangci/golangci-lint/cmd/golangci-lint')

$fileName=$MyInvocation.MyCommand.Source
$baseDir = $(Split-Path $fileName -Parent)
$baseFound = $False
while ($baseDir -ne "") {
    $scPath = $(Join-Path -Path "$baseDir" -ChildPath "script_common")
    if (Test-Path "$scPath") {
        $baseFound = $True
        break;
    }

    $baseDir=$(Split-Path $baseDir -Parent)
}
if (!($baseFound)) {
    $HOST.UI.WriteErrorLine("Could not find base diretory or script_common")
    Exit -1
}
$commonScript = $(Join-Path -Path $baseDir -ChildPath "script_common\common.ps1")
. $commonScript

Confirm-Install go golang | Out-Null

if (Test-IsCore)
{
    $cwd = $( Get-Location ).Path
    $goPath = $( (go env GOPATH) | Out-String ).Trim()
    $goPathBin = $( Join-Path -Path "$goPath" -ChildPath "bin" )
    $newGoPath = $( Join-Path -Path "$env:TEMP" -ChildPath "go" )
    $newGoBin = $( Join-Path -Path "$newGoPath" -ChildPath "bin" )

    # Create directories
    New-Directory $( Join-Path -Path "$goPath" -ChildPath "bin" )
    New-Directory $( Join-Path -Path "$newGoPath" -ChildPath "bin" )
    New-Directory $( Join-Path -Path "$newGoPath" -ChildPath "pkg" )
    New-Directory $( Join-Path -Path "$newGoPath" -ChildPath "src" )

    # Override the current GOPATH to protect source trees
    $oldGoPath = $goPath
    $env:GOPATH = $newGoPath

    Write-Host " --==-- System GOPATH: $goPath"
    Write-Host " --==-- Temp GOPATH: $newGoPath"

    foreach ($getPath in $goGetPaths)
    {
        Write-Host " --==-- go install $getpath@latest"
        Invoke-Executable "go" @("install", "$getPath@latest")
    }

    # copy the built binaries to the real GOPATH
    Set-Location "$newGoBin" | Out-Null

    $env:GOPATH = $oldGoPath
    $files = Get-ChildItem "$newGoBin"
    foreach ($file in $files)
    {
        $fileOnly = Split-Path -Path $file -Leaf
        Write-Host " --==-- Installing $fileOnly"
        Copy-File "$file" $( Join-Path -Path "$goPathBin" -ChildPath "$fileOnly" )
    }

    # cleanup the mess in the temp directory
    Set-Location "$cwd" | Out-Null
    Write-Host " --==-- Cleaning Up Temp GOPATH"
    Remove-Item "$newGoPath" -Recurse -Force

    Write-Host "This script can be re-run in the future to update any installed tools."
    Wait-ForExit 0
}
else {
    Start-Process pwsh.exe -ArgumentList "-Command $fileName"
}
