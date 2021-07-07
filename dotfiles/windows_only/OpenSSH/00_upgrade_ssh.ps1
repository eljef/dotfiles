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

Confirm-Install pwsh "Powershell Core"
Confirm-Install ssh "Windows SSH"

$opensshURI = 'https://github.com/PowerShell/Win32-OpenSSH/releases/download/V8.6.0.0p1-Beta/OpenSSH-Win64.zip'
$opensshZip = $(Join-Path -Path $env:temp -ChildPath 'OpenSSH-Win64.zip')
$opensshFolder = $(Join-Path -Path $env:temp -ChildPath 'OpenSSH-Win64')

if (!([Environment]::Is64BitOperatingSystem)) {
    $opensshURI = 'https://github.com/PowerShell/Win32-OpenSSH/releases/download/V8.6.0.0p1-Beta/OpenSSH-Win32.zip'
    $opensshZip = $(Join-Path -Path $env:temp -ChildPath 'OpenSSH-Win32.zip')
    $opensshFolder = $(Join-Path -Path $env:temp -ChildPath 'OpenSSH-Win32')
}

$opensshItems = @('libcrypto.dll', 'scp.exe', 'sftp.exe', 'ssh.exe', 'ssh-add.exe',
                  'ssh-agent.exe', 'ssh-keygen.exe', 'ssh-keyscan.exe', 'ssh-shellhost.exe')

if ((Test-IsAdmin) -and (Test-IsCore))
{
    Remove-DirIfExists "$opensshFolder"
    Remove-FileIfExists "$opensshZip"

    $runTime = $( Get-Date -format 'yyyy.MM.dd-HH.mm.ss' )

    $currentOpenSSH = $( Get-Command ssh )
    $currentOpenSSHPath = $( Split-Path $currentOpenSSH.Source -Parent )
    $currentOpenSSHVersion = $currentOpenSSH.Version
    $renamedOpenSSHPath = [string]::Format("{0}-{1}-{2}", $currentOpenSSHPath, $currentOpenSSHVersion, $runTime)

    Get-Download $opensshURI $opensshZip "OpenSSH Windows Port"
    Rename-Path -SourcePath "$currentOpenSSHPath" -DestPath "$renamedOpenSSHPath"
    New-Directory "$currentOpenSSHPath"
    Expand-ArchiveToTemp -ZipPath "$opensshZip"

    foreach ($newFile in $opensshItems)
    {
        $installFile = $( Join-Path -Path "$currentOpenSSHPath" -ChildPath "$newFile" )
        $tempFile = $( Join-Path -Path "$opensshFolder" -ChildPath "$newFile" )

        Move-Path -SourcePath "$tempFile" -DestPath "$installFile"
    }

    Remove-DirIfExists "$opensshFolder"
    Remove-FileIfExists "$opensshZip"

    Copy-ACL -SourcePath "$renamedOpenSSHPath" -DestPath "$currentOpenSSHPath"

    Write-Host "SSH has been upgraded"
    Wait-ForExit 0
}
else {
    Start-Process pwsh.exe -Verb RunAs -ArgumentList "-Command $fileName"
}
