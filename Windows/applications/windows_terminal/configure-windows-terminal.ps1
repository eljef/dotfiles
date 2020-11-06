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

Confirm-Install wt "Windows Terminal"

$draculaThemeURI = 'https://raw.githubusercontent.com/dracula/windows-terminal/master/dracula.json'

try {
    $settingsJSONFile = resolve-path -path `
                        "$($env:LOCALAPPDATA)\Packages\Microsoft.WindowsTerminal_*\LocalState\settings.json"
}
catch {
    Exit-Error "Could not find Windows Terminal settings JSON. Try running Windows Terminal, then this script again." $Error.Exception.Message
}

$draculaJSONFile = Join-Path -Path $(Split-Path -Path $settingsJSONFile -Parent) -ChildPath 'dracula.json'

Copy-File $settingsJSONFile "$($settingsJSONFile).bak"
$settingsJSON = Read-JSON $settingsJSONFile
Get-Download $draculaThemeURI $draculaJSONFile "dracula-theme"
$draculaJSON = Read-JSON $draculaJSONFile

# Modify settings.
$azureShell = {}
$cmd = {}
$powershell = {}
$winPowershell = {}

foreach ($profileObj in $settingsJSON.profiles.list) {
    switch ($profileObj.name) {
        'Azure Cloud Shell'  { $azureShell = $profileObj }
        'Command Prompt'     { $cmd = $profileObj }
        'PowerShell'         { $powershell = $profileObj }
        'Windows PowerShell' { $winPowershell = $profileObj }
    }
}

# hide Azure Cloud Shell because I don't use it.
$azureShell.hidden = $true

# reorder shells
$settingsJSON.profiles.list = $powershell, $winPowershell, $cmd, $azureShell

# set default profile
$settingsJSON.defaultProfile = $powershell.guid

# add dracula theme
$settingsJSON.schemes += $draculaJSON

# set defaults
$settingsJSON.alwaysShowTabs = $true
$settingsJSON.profiles.defaults.antialiasingMode = "cleartype"
$settingsJSON.profiles.defaults.colorScheme = "Dracula"
$settingsJSON.profiles.defaults.fontFace = "FiraCode NF"
$settingsJSON.profiles.defaults.fontSize = 10
$settingsJSON.profiles.defaults.useAcrylic = $true
$settingsJSON.profiles.defaults.acrylicOpacity = 0.5

Write-JSON $settingsJSON $settingsJSONFile

