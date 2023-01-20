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

function Get-FontName {
    param(
        [Parameter(Mandatory)]
        [System.IO.FileInfo]$FontFile
    )

    $fontName = $FontFile.BaseName.replace(' Complete', '').replace(' Regular', '')
    switch ($FontFile.Extension) {
        ".ttf" {
            $fontName = "$fontName (TrueType)"
        }
        ".otf" {
            $fontName = "$fontName (OpenType)"
        }
    }

    return "$fontName"
}

function Install-FontInfo {
    param(
        [Parameter(Mandatory)]
        [string]$FontFile,
        [Parameter(Mandatory)]
        [string]$FontName
    )

    if (!(Get-ItemProperty -Name "$FontName" -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -ErrorAction SilentlyContinue)) {
        New-ItemProperty -Name "$FontName" -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value "$FontFile" -Force -ErrorAction SilentlyContinue | Out-Null
    }
}

function Install-Font {
    param(
        [Parameter(Mandatory)]
        [string]$fromPath,
        [Parameter(Mandatory)]
        [string]$installPath,
        [Parameter(Mandatory)]
        [string]$fontName
    )

    if (Test-Path "$installPath") {
        Write-Host "Upgrade Font: $fontName"
        try {
            Remove-Item "$installPath" -Force
            Move-Item -Path "$fromPath" -Destination "$installPath"
        }
        catch {
            Exit-Error -Error "Could not upgrade font" -Extended $Error[0].Exception.Message
        }
    } else {
        Write-Host "Installing Font: $fontName -> $installPath"
        try {
            Move-Item -Path "$fromPath" -Destination "$installPath"
        }
        catch {
            Exit-Error -Error "Could not install font" -Extended $Error[0].Exception.Message
        }
        Install-FontInfo -FontFile "$installPath" -FontName "$fontName"
    }
}

function Install-NerdFontPackage {
    param(
        [Parameter(Mandatory)]
        [string]$fontName,
        [Parameter(Mandatory)]
        [string]$zipFileName,
        [Parameter(Mandatory)]
        [string]$fontsDir
    )

    Write-Host "`nInstalling $fontName Nerd Font Package`n"
    $nfFontDir = $(Join-Path -Path "$fontsDir" -ChildPath "$fontName")
    Remove-DirIfExists "$nfFontDir"
    New-Directory "$nfFontDir"

    $zipURL = "$( $nfReleaseURL )/$( $zipFileName )"
    $zipDestination = $( Join-Path -Path "$nfFontDir" -ChildPath "$zipFileName")
    Get-Download "$zipURL" "$zipDestination" "$zipFileName"

    Write-Host "Extracting New $fontName Nerd Fonts"
    Invoke-ExecutableNoRedirect "7z" @("-y", "-bso0", "-bsp0", "-o$nfFontDir", "e", "$zipDestination") "Failed to extract $zipFileName"

    foreach ($fontFile in (Get-ChildItem -Path "$nfFontDir" | Where-Object {($_.Name -like '*.ttf') -or ($_.Name -like '*.otf') })) {
        if ((!($fontFile.Name.ToLower().Contains('windows compatible'))) -and (!($fontFile.Name.ToLower().Contains('windowscompatible')))) {
            Install-Font "$($fontFile.fullname)" "$(Join-Path -Path $($fontsDir) -ChildPath $($fontFile.name))" "$(Get-FontName $fontFile)"
        }
    }

    Remove-DirIfExists "$nfFontDir"
}

function Install-SingleFont {
    param(
        [Parameter(Mandatory)]
        [string]$fontName,
        [Parameter(Mandatory)]
        [string]$fontFileName,
        [Parameter(Mandatory)]
        [string]$fontFileURL,
        [Parameter(Mandatory)]
        [string]$fontsDir,
        [Parameter(Mandatory)]
        [string]$fontRegName
    )

    Write-Host "`nInstalling New Font: $fontName`n"
    $nfFontDir = $(Join-Path -Path "$fontsDir" -ChildPath "$fontName")
    Remove-DirIfExists "$nfFontDir"
    New-Directory "$nfFontDir"

    $fontDest = $( Join-Path -Path "$nfFontDir" -ChildPath "$fontFileName")
    Get-Download "$fontFileURL" "$fontDest" "$fontFileName"

    Install-Font "$fontDest" "$(Join-Path -Path $($fontsDir) -ChildPath $fontFileName)" "$fontRegName"

    Remove-DirIfExists "$nfFontDir"
}

function Uninstall-FontInfo {
    param(
        [Parameter(Mandatory)]
        [string]$FontName
    )

    Write-Host "$FontName"
    If (Get-ItemProperty -Name "$FontName" -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -ErrorAction SilentlyContinue) {
        Remove-ItemProperty -Name "$FontName" -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -Force
    }
}
