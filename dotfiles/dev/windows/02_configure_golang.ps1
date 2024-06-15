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

Confirm-Install go golang | Out-Null
Confirm-Install nvim neovim | Out-Null
Confirm-Install pwsh powershell-core | Out-Null
Confirm-Install sed base.sed | Out-Null

$pythonExec = $(Confirm-Install python.exe python) -replace "\\", "\/"

$neovim_buffer_text = @"

    When the plugin installation is done,
    Please close neovim with :qa!

    Thanks for playing along!

"@

if (Test-IsCore)
{
    $goPath = ""
    while ($goPath -eq "")
    {
        $goPath = Read-Host -Prompt "Please enter the full path to be used as GOPATH"
    }
    [System.Environment]::SetEnvironmentVariable('GOPATH', "$goPath", [System.EnvironmentVariableTarget]::User)

    $goPathBin = $( Join-Path -Path $goPath -ChildPath "bin")
    New-Directory "$goPathBIN"

    $pathFound = $False
    $Environment = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
    foreach ($path in ($Environment).Split(";")) {
        if ($path -like "$goPathBin") {
            $pathFound = $True
            break
        }
    }
    if (!($pathFound)) {
        Write-Host "Adding $goPath to Users PATH"
        $Environment += ";$goPathBin"
        [System.Environment]::SetEnvironmentVariable('PATH', "$Environment", [System.EnvironmentVariableTarget]::User)
    }

    $filesDir = $( Join-Path -Path $baseDir -ChildPath "dotfiles\dev\files" )

    $nvimDir = Join-Path -Path "$env:LOCALAPPDATA" -ChildPath "nvim"

    Copy-File $( Join-Path -Path $filesDir -ChildPath "nvim\plugins_with_golang_windows.vim" ) $( Join-Path -Path "$nvimDir" -ChildPath "plugins.vim" )
    Copy-File $( Join-Path -Path $filesDir -ChildPath "coc-settings-with-golang.json" ) $( Join-Path -Path "$nvimDir" -ChildPath "coc-settings.json" )

    # Fix python executable location
    Invoke-Executable "sed" @("-i", "-e",
    "`"s/\/usr\/bin\/python/$pythonExec/g`"",
    $( Join-Path -Path "$nvimDir" -ChildPath "coc-settings.json" ))

    $neovim_buffer_text | nvim -c PlugInstall

    Write-Host "golang configuration complete"
    Wait-ForExit 0
}
else {
    Start-Process pwsh.exe -ArgumentList "-Command $fileName"
}
