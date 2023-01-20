# Copyright (C) 2023 Jef Oliver.
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

Confirm-Install 7z 7zip | Out-Null

. common/fonts.ps1

################################################################################
# Functionality Below
################################################################################

if (Test-IsCore)
{
    $fontsDir = Join-Path -Path $( $env:LOCALAPPDATA ) -ChildPath '\Microsoft\Windows\Fonts'
    New-Directory "$fontsDir"

    Write-Host "`nRemoving Nerd Fonts`n"
    foreach ($fontFile in (Get-ChildItem -Path "$fontsDir" | Where-Object {($_.Name -like '*.ttf') -or ($_.Name -like '*.otf') })) {
        if ($fontFile.Name.ToLower().Contains('nerd font')) {
            Uninstall-FontInfo "$(Get-FontName $fontFile)"
            Remove-FileIfExists "$($fontFile.fullname)"
        }
    }

    Write-Host "`nRemoving 'Noto Color Emoji`n"
    Uninstall-FontInfo 'Noto Color Emoji (TrueType)'
    Remove-FileIfExists "$(Join-Path -Path $($fontsDir) -ChildPath NotoColorEmoji_WindowsCompatible.ttf)"

    Write-Host "`nFonts Removed"
    Wait-ForExit 0
}
else {
    Start-Process pwsh.exe -ArgumentList "-Command $fileName"
}
