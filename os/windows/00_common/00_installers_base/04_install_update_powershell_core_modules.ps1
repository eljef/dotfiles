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

param(
    [Parameter(Mandatory=$False, ValueFromPipeline=$false)]
    [System.String]
    $RunStep
)

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

Confirm-Install pwsh powershell-core | Out-Null

if ((Test-IsCore) -and ($RunStep -eq "install_psreadline")) {
    Install-ModuleByName -ModuleName PSReadLine -CurrentUser
    Start-Process pwsh.exe -ArgumentList "-Command $fileName -RunStep install_posh_git"
}
elseif ((Test-IsCore) -and ($RunStep -eq "install_posh_git")) {
    Install-ModuleByName -ModuleName posh-git -CurrentUser
    Start-Process pwsh.exe -ArgumentList "-Command $fileName -RunStep install_get_childitemcolor"
}
elseif ((Test-IsCore) -and ($RunStep -eq "install_get_childitemcolor")) {
    Install-ModuleByName -ModuleName Get-ChildItemColor -CurrentUser
    Start-Process pwsh.exe -ArgumentList "-Command $fileName -RunStep install_psini"
}
elseif ((Test-IsCore) -and ($RunStep -eq "install_psini")) {
    Install-ModuleByName -ModuleName PsIni -CurrentUser

    Write-Host "Modules Successfully Installed and Updated"
    Wait-ForExit 0
}
else {
    Start-Process pwsh.exe -ArgumentList "-Command $fileName -RunStep install_psreadline"
}
