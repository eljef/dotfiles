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

$nfVersion = '2.3.2'
$nfDownloadUrl = 'https://github.com/ryanoasis/nerd-fonts/releases/download'
$nfReleaseURL = "$( $nfDownloadUrl )/v$( $nfVersion)"
$nfZipCascadiaCode = "CascadiaCode.zip"
$nfZipFiraCode = "FiraCode.zip"
$nfZipHack = "Hack.zip"

################################################################################
# Verication Functionality Below
################################################################################

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
# Main Functionality Below
################################################################################

if (Test-IsCore)
{
    $fontsDir = $(Join-Path -Path $( $env:LOCALAPPDATA ) -ChildPath '\Microsoft\Windows\Fonts')
    New-Directory "$fontsDir"

    Install-NerdFontPackage 'CascadiaCode' "$nfZipCascadiaCode" "$fontsDir"
    Install-NerdFontPackage 'FiraCode' "$nfZipFiraCode" "$fontsDir"
    Install-NerdFontPackage 'Hack' "$nfZipHack" "$fontsDir"

    Install-SingleFont 'NotoColorEmoji' "NotoColorEmoji_WindowsCompatible.ttf" `
        "https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji_WindowsCompatible.ttf" `
        "$fontsDir" 'Noto Color Emoji (TrueType)'

    Write-Host "`nNew Fonts Installed"
    Wait-ForExit 0
}
else {
    Start-Process pwsh.exe -ArgumentList "-Command $fileName"
}
