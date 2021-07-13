# Copyright (C) 2020-2021 Jef Oliver.
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

################################################################################
# Functionality Below
################################################################################

Confirm-Install wt "Windows Terminal" | Out-Null

if (Test-IsCore)
{
    $draculaThemeURI = 'https://raw.githubusercontent.com/dracula/windows-terminal/master/dracula.json'

    try
    {
        $settingsJSONFile = resolve-path -path `
                        "$( $env:LOCALAPPDATA )\Packages\Microsoft.WindowsTerminal_*\LocalState\settings.json"
    }
    catch
    {
        $HOST.UI.WriteErrorLine($Error[0].Exception.Message)
        Read-Host "Could not find Windows Terminal settings JSON. Try running Windows Terminal, then this script again."
        Exit -1
    }

    $draculaJSONFile = Join-Path -Path $( Split-Path -Path $settingsJSONFile -Parent ) -ChildPath 'dracula.json'

    Copy-File $settingsJSONFile "$( $settingsJSONFile ).bak"
    $settingsJSON = Read-JSON $settingsJSONFile
    Get-Download $draculaThemeURI $draculaJSONFile "dracula-theme"
    $draculaJSON = Read-JSON $draculaJSONFile

    # Modify settings.
    $azureShell = { }
    $cmd = { }
    $powershell = { }
    $winPowershell = { }

    foreach ($profileObj in $settingsJSON.profiles.list)
    {
        switch ($profileObj.name)
        {
            'Azure Cloud Shell'  {
                $azureShell = $profileObj
            }
            'Command Prompt'     {
                $cmd = $profileObj
            }
            'PowerShell'         {
                $powershell = $profileObj
            }
            'Windows PowerShell' {
                $winPowershell = $profileObj
            }
        }
    }

    # hide Azure Cloud Shell because I don't use it.
    Write-Host "Hide Azure Cloud Shell from profile list."
    $azureShell.hidden = $true

    # reorder shells
    Write-Host "Setting order of shells in profile list."
    $settingsJSON.profiles.list = $powershell, $winPowershell, $cmd, $azureShell

    # set default profile
    Write-Host "Setting default profile to powershell-core."
    $settingsJSON.defaultProfile = $powershell.guid

    # add dracula theme
    Write-Host "Adding Dracula Theme."
    $settingsJSON.schemes += $draculaJSON

    # set defaults
    Write-Host "Setting preferred defaults."

    $settingsJSON["experimental.rendering.forceFullRepaint"] = $false
    $settingsJSON["experimental.rendering.software"] = $false

    $settingsJSON.alwaysShowTabs = $true
    $settingsJSON.profiles.defaults.antialiasingMode = "cleartype"
    $settingsJSON.profiles.defaults.closeOnExit = "graceful"
    $settingsJSON.profiles.defaults.colorScheme = "Dracula"
    $settingsJSON.profiles.defaults.fontFace = "FiraCode Nerd Font Mono"
    $settingsJSON.profiles.defaults.fontSize = 10
    $settingsJSON.profiles.defaults.fontWeight = "medium"
    $settingsJSON.profiles.defaults.bellStyle = "none"
    $settingsJSON.profiles.defaults.useAcrylic = $true
    $settingsJSON.profiles.defaults.acrylicOpacity = 0.5

    Write-JSON $settingsJSON $settingsJSONFile

    Write-Host "`nWindows Terminal has been configured."
    Wait-ForExit 0
}
else {
    Start-Process pwsh.exe -ArgumentList "-Command $fileName"
}
