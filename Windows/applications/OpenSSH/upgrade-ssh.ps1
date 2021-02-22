# Copyright (C) 2021 Jef Oliver.
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
Confirm-Install ssh "Windows SSH"

$opensshItems = @('libcrypto.dll', 'scp.exe', 'sftp.exe', 'ssh.exe', 'ssh-add.exe', 'ssh-agent.exe', 'ssh-keygen.exe', 'ssh-keyscan.exe')

$opensshURI = 'https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.1.0.0p1-Beta/OpenSSH-Win64.zip'
$opensshZip = $(Join-Path -Path $env:temp -ChildPath 'OpenSSH-Win64.zip')
$opensshFolder = $(Join-Path -Path $env:temp -ChildPath 'OpenSSH-Win64')

if (!([Environment]::Is64BitOperatingSystem)) {
    $opensshURI = 'https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.1.0.0p1-Beta/OpenSSH-Win32.zip'
    $opensshZip = $(Join-Path -Path $env:temp -ChildPath 'OpenSSH-Win32.zip')
    $opensshFolder = $(Join-Path -Path $env:temp -ChildPath 'OpenSSH-Win32')
}

Remove-DirIfExists "$opensshFolder"
Remove-FileIfExists "$opensshZip"

$currentOpenSSH = $(Get-Command ssh)
$currentOpenSSHPath = $(Split-Path $currentOpenSSH.Source -Parent)
$currentOpenSSHVersion = $currentOpenSSH.Version
$renamedOpenSSHPath = [string]::Format("{0}-{1}", $currentOpenSSHPath, $currentOpenSSHVersion)

Get-Download $opensshURI $opensshZip "OpenSSH Win32 Port"

try {
    Rename-Item "$currentOpenSSHPath" "$renamedOpenSSHPath"
}
catch {
    Exit-Error "Could not rename current OpenSSH directory."
}

New-Directory "$currentOpenSSHPath"

try {
    Expand-Archive -DestinationPath "$env:temp" $opensshZip
}
catch {
    Exit-Error "Could not extract downloaded OpenSSH update."
}

foreach ($newFile in $opensshItems) {
    $installFile = $(Join-Path -Path "$currentOpenSSHPath" -ChildPath "$newFile")
    $tempFile = $(Join-Path -Path "$opensshFolder" -ChildPath "$newFile")

    try {
        Move-Item -Path "$tempFile" -Destination "$installFile"
    }
    catch {
        Exit-Error "Could not install new OpenSSH file $newFile"
    }
}

Remove-DirIfExists "$opensshFolder"
Remove-FileIfExists "$opensshZip"

try {
    Get-Acl -Path "$renamedOpenSSHPath" | Set-Acl -Path "$currentOpenSSHPath"
} catch {
    Exit-Error "Could not copy permissions to new OpenSSH folder." $Error.Exception.Message
}