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

$sDir = Split-Path $MyInvocation.MyCommand.Source -Parent
$installFile = Join-Path -Path "$sDIR" -ChildPath "99_installing_plugins.txt"
$cocDir = Join-Path -Path "$env:LOCALAPPDATA" -ChildPath "nvim\plugged\coc.nvim"

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

##### Actual script functionality ##############################################

# Install initial set of pluggins
try {
    nvim -c "e $installFile" -c "PlugInstall"
    $cwd = Get-Location
    Set-Location -Path "$cocDir"
    git checkout release
    Set-Location -Path "$cwd"
}
catch {
    Error-Exit "Could not install initial plugin set" $Error.Exception.Message
}

# Install COC pluggins
try {
    nvim -c "e $installFile" -c (("CocInstall", "coc-css",
                                                "coc-diagnostic",
                                                "coc-docker",
                                                "coc-highlight",
                                                "coc-html",
                                                "coc-json",
                                                "coc-markdownlint",
                                                "coc-python",
                                                "coc-rls",
                                                "coc-sh",
                                                "coc-tsserver",
                                                "coc-vetur",
                                                "coc-yaml") -join " ")
}
catch {
    Error-Exit "Could not install coc plugin set" $Error.Exception.Message
}

