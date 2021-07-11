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

Confirm-Install notepad++ notepad++ | Out-Null
Confirm-Install pwsh powershell-core | Out-Null

$nppBits = "64 Bit"
$nppPluginDir = Join-Path -Path $env:ProgramFiles -ChildPath "Notepad++\plugins"
$plugins = @(
    @{
        'Name' = "AutoSave"
        'URI' = 'https://github.com/francostellari/NppPlugins/raw/main/AutoSave/AutoSave_dll_1v61_x64.zip'
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

if (!([Environment]::Is64BitOperatingSystem))
{
    $nppBits = "32 Bit"
    $nppPluginDir = Join-Path -Path "${env:ProgramFiles(x86)}" -ChildPath "Notepad++\plugins"
    $plugins = @(
    @{
        'Name' = "AutoSave"
        'URI' = 'https://github.com/francostellari/NppPlugins/raw/main/AutoSave/AutoSave_dll_1v61_x32.zip'
        'Zip' = "AutoSave_dll_1v60_x32.zip"
    }
    @{
        'Name' = "NPPAutoDetectIndent"
        'URI' = 'https://github.com/Chocobo1/nppAutoDetectIndent/releases/download/1.9/x86.zip'
        'Zip' = "x86.zip"
    }
    @{
        'Name' = "NPPJSONViewer"
        'URI' = 'https://github.com/kapilratnani/JSON-Viewer/releases/download/v1.40/NPPJSONViewer_Win32.zip'
        'Zip' = "NPPJSONViewer_Win32.zip"
    }
    )
}

if ((Test-IsAdmin) -and (Test-IsCore))
{
    foreach ($plugin in $plugins)
    {
        $destZip = $( Join-Path -Path "$nppPluginDir" -ChildPath $plugin.Zip )
        $destDir = $( Join-Path -Path "$nppPluginDir" -ChildPath $plugin.Name )

        Write-Host  "`n-==- Installing" $plugin.Name "`n"
        Get-Download $plugin.URI "$destZip" $plugin.Name
        try {
            Write-Host "Extract: $destZip -> $destDir"
            Expand-Archive -Path $destZip -DestinationPath "$destDir" -Force -ErrorAction Stop
        }
        catch {
            Exit-Error "Could not extract: $destZip -> $destDir" $Error[0].Exception.Message
        }
        Remove-FileIfExists -Path "$destZip"
    }

    Write-Host "`nNotepad++ $nppBits Plugins Installed"
    Wait-ForExit 0
}
else {
    Start-Process pwsh.exe -Verb RunAs -ArgumentList "-Command $fileName"
}
