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

##### Variables needed throughout the script ###################################

$vimPlugURI = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

$baseDir = Resolve-Path -LiteralPath $(Join-Path -Path $(Split-Path $MyInvocation.MyCommand.Source -Parent) -ChildPath "..\..\..")
$dotFilesDir = Join-Path -Path "$baseDir" -ChildPath "dotfiles"
$base = Split-Path "$baseDir" -Leaf
$nvimDir = Join-Path -Path "$env:LOCALAPPDATA" -ChildPath "nvim"

##### Functions needed in the script ###########################################

<#
.SYNOPSIS
Copy-File copies a file into place, halting the script if copying fails.
#>
function Copy-File {
    Param (
        # Path to the file to copy
        [string]$origFile,
        # Path to copy the file to
        [string]$newFile
    )

    try {
        Copy-Item "$origFile" -Destination "$newFile"
    }
    catch {
        Error-Exit "Could not copy $origFile to $newFile" $Error.Exception.Message
    }
}

<#
.SYNOPSIS
Create-Directory creates a new directory specified by $newPath, halting the script if directory creation fails.
#>
function Create-Directory {
    Param (
        # Path to the directory to create
        [string]$newPath
    )

    try {
        $throwAwayReturn = New-Item -Path "$newPath" -ItemType Directory -Force
    }
    catch {
        Error-Exit "Could not create directory: $newPath" $Error.Exception.Message
    }
}

<#
.SYNOPSIS
Writes an error and exits.
#>
function Error-Exit {
    Param (
        # Error String 1
        [string]$errorStringOne,
        # Error String 2
        [string]$errorStringTwo
    )

    $HOST.UI.WriteErrorLine($errorStringOne)
    if ($errorStringTwo -ne '') {
        $HOST.UI.WriteErrorLine($errorStringTwo)
    }
    Exit
}

<#
.SYNOPSIS
Download-Vim-Plug downloads the vim-plug plugin from github.
#>
function Download-Vim-Plug {
    try {
        (New-Object Net.WebClient).DownloadFile(
            $vimPlugURI,
            $(Join-Path -Path "$nvimDir" -ChildPath "autoload\plug.vim")
        )
    }
    catch {
        Error-Exit "Could not download vim-plug" $Error.Exception.Message
    }
}

##### Actual script functionality ##############################################

if ($base -ne 'dotfiles') {
    Error-Exit "Could not determine base dotfiles directory." ""
}

if (!(Test-Path $dotFilesDir)) {
    Error-Exit "Could not determine base dotfiles directory." ""
}

Create-Directory $nvimDir
Create-Directory $(Join-Path -Path "$nvimDir" -ChildPath "autoload")
Create-Directory $(Join-Path -Path "$nvimDir" -ChildPath "plugged")

Download-Vim-Plug

Copy-File $(Join-Path -Path "$dotFilesDir" -ChildPath "config\nvim\init.vim") $(Join-Path -Path "$nvimDir" -ChildPath "init.vim")
Copy-File $(Join-Path -Path "$dotFilesDir" -ChildPat "coc-settings.json") $(Join-Path -Path "$nvimDir" -ChildPath "coc-settings.json")

# Fix plugin directory location
try {
    sed -i -e "s/call plug#begin.*/call plug#begin\('~\/AppData\/local\/nvim\/plugged'\)/" $(Join-Path -Path "$nvimDir" -ChildPath "init.vim")
}
catch {
    Error-Exit "Could not sed plug#begin" $Error.Exception.Message
}

# Fix node executable location
try {
    $nodeExec = $(Get-Command node.exe).Source -replace "\\", "\/"
}
catch {
    Error-Exit "Could not find node.exe" $Error.Exception.Message
}

try {
    sed -i -e "s/let g:coc_node_path.*/let g:coc_node_path='$nodeExec'/" $(Join-Path -Path "$nvimDir" -ChildPath "init.vim")
}
catch {
    Error-Exit "Could not sed coc_node_path" $Error.Exception.Messaage
}

# Fix python executable location
try {
    $pythonExec = $(Get-Command python.exe).Source -replace "\\", "\/"
}
catch {
    Error-Exit "Could not find python.exe" $Error.Exception.Messaage
}

try {
    sed -i -e "s/\/usr\/bin\/python/$pythonExec/g" $(Join-Path -Path "$nvimDir" -ChildPath "coc-settings.json")
}
catch {
    Error-Exit "Could not sed python executable location for coc-settings" $Error.Exception.Messaage
}

