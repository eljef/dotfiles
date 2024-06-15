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

Confirm-Install pwsh "Powershell-core" | Out-Null
Confirm-Install starship "Starship" | Out-Null

if (Test-IsCore)
{
    $baseFilesDir = $(Join-Path -Path $baseDir -ChildPath "dotfiles\base\files")
    $psFilesDir = $(Join-Path -Path $baseDir -ChildPath "dotfiles\windows_only\PowerShell\files")
    $dotConfigDir = $(Join-Path -Path $env:USERPROFILE -ChildPath ".config")
    $psProfileDir = $(Split-Path $PROFILE -Parent)

    New-Directory "$dotConfigDir"
    New-Directory $(Join-Path -Path $psProfileDir -ChildPath "profile.d")

    Copy-File $( Join-Path -Path "$baseFilesDir" -ChildPath "starship\config.toml" ) $( Join-Path -Path "$dotConfigDir" -ChildPath "starship.toml" )
    Copy-File $( Join-Path -Path "$psFilesDir" -ChildPath "Microsoft.PowerShell_profile.ps1" ) $( Join-Path -Path "$psProfileDir" -ChildPath "Microsoft.PowerShell_profile.ps1" )
    Copy-File $( Join-Path -Path "$psFilesDir" -ChildPath "profile.d/00_import.ps1" ) $( Join-Path -Path "$psProfileDir" -ChildPath "profile.d/00_import.ps1" )
    Copy-File $( Join-Path -Path "$psFilesDir" -ChildPath "profile.d/01_default_vars.ps1" ) $( Join-Path -Path "$psProfileDir" -ChildPath "profile.d/01_default_vars.ps1" )
    Copy-File $( Join-Path -Path "$psFilesDir" -ChildPath "profile.d/02_alias.ps1" ) $( Join-Path -Path "$psProfileDir" -ChildPath "profile.d/02_alias.ps1" )
    Copy-File $( Join-Path -Path "$psFilesDir" -ChildPath "profile.d/10_disable_bell.ps1" ) $( Join-Path -Path "$psProfileDir" -ChildPath "profile.d/10_disable_bell.ps1" )
    Copy-File $( Join-Path -Path "$psFilesDir" -ChildPath "profile.d/20_psreadline.ps1" ) $( Join-Path -Path "$psProfileDir" -ChildPath "profile.d/20_psreadline.ps1" )
    Copy-File $( Join-Path -Path "$psFilesDir" -ChildPath "profile.d/99_init_starship.ps1" ) $( Join-Path -Path "$psProfileDir" -ChildPath "profile.d/99_init_starship.ps1" )

    Write-Host "`nPowershell-core has been configured."
    Wait-ForExit 0
}
else {
    Start-Process pwsh.exe -ArgumentList "-Command $fileName"
}
