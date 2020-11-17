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
                -ChildPath "\..\..\installers\common.ps1")
. $commonScript

Confirm-Admin
Confirm-Install notepad++ notepad++ | Out-Null

$nppPluginDir = Join-Path -Path $env:ProgramFiles -ChildPath "Notepad++\plugins"

$plugins = @(
    @{
        'Name' = "AutoSave"
        'URI' = 'https://github.com/francostellari/NppPlugins/raw/main/AutoSave/AutoSave_dll_1v60_x64.zip'
        'Zip' = "AutoSave_dll_1v60_x64.zip"
    }
    @{
        'Name' = "NPPAutoDetectIndent"
        'URI' = 'https://github.com/Chocobo1/nppAutoDetectIndent/releases/download/1.9/x64.zip'
        'Zip' = "x64.zip"
    }
    @{
        'Name' = "NPPJSONViewer"
        'URI' = 'https://github.com/kapilratnani/JSON-Viewer/releases/download/v1.40/NPPJSONViewer_x64.zip'
        'Zip' = "NPPJSONViewer_x64.zip"
    }
)

foreach ($plugin in $plugins) {
    $destZip = $(Join-Path -Path "$nppPluginDir" -ChildPath $plugin.Zip)
    $destDir = $(Join-Path -Path "$nppPluginDir" -ChildPath $plugin.Name)

    Write-Host  -==- Installing $plugin.Name
    Get-Download $plugin.URI "$destZip" $plugin.Name
    Expand-Archive -Path $destZip -DestinationPath "$destDir" -Force
    Remove-FileIfExists "$destZip"
}
