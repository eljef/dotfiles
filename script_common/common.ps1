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

<#
.SYNOPSIS
    Checks if executable is installed.

.DESCRIPTION
    Checks if executable is installed, printing an error and force exiting if it is not.

.PARAMETER Executable
    Name of the executable to look for.

.PARAMETER Name
    Name of the program to print in error statement.

.EXAMPLE
    Confirm-Install python.exe python

.OUTPUTS
    Path to installed executable.
#>
function Confirm-Install {
    Param (
        [Parameter(Mandatory)]
        [string]$Executable,
        [Parameter(Mandatory)]
        [string]$Name
    )

    try {
        $execPath = $(Get-Command $Executable -ErrorAction Stop).Source
        return $execPath
    }
    catch {
        Exit-Error -Error "Requirement not found or not installed: $Name"
    }
}

<#
.SYNOPSIS
    Copies ACLs from source to destination.

.DESCRIPTION
    Copies ACLs from source to destination.

.PARAMETER SourcePath
    Path to get ACLs from

.PARAMETER DestPath
    Path to apply ACLS TO

.EXAMPLE
    Copy-ACL oldfile.txt newfile.txt
#>
function Copy-ACL {
    Param (
        [string]$SourcePath,
        [string]$DestPath
    )

    try {
        Write-Host "Copy ACLs: $SourcePath -> $DestPath"
        Get-Acl -Path "$SourcePath" | Set-Acl -Path "$DestPath"
    } catch {
        Exit-Error -Error "Could not copy ACLs from $SourcePath to $DestPath" -Extended $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Copies a file into place, halting the script if copying fails.

.DESCRIPTION
    Copies a file into place, halting the script if copying fails. This function
    overwrites the destination file if it exists.

.PARAMETER Origin
    Original file to be copied.

.PARAMETER Destination
    Destination origFile will be copied to.

.EXAMPLE
    Copy-File oldfile.txt newfile.txt
#>
function Copy-File {
    Param (
        [Parameter(Mandatory)]
        [string]$Origin,
        [Parameter(Mandatory)]
        [string]$Destination
    )

    try {
        Write-Host "Copy: $Origin -> $Destination"
        Copy-Item "$Origin" -Destination "$Destination" -Force
    }
    catch {
        Exit-Error -Error "Could not copy $Origin to $Destination" -Extended $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Writes an error and exits.

.DESCRIPTION
    Prints an error statement to the console, plus a second one if provided,
    then exits.

.PARAMETER Error
    Required error string to print.

.PARAMETER Extended
    Optional second error string to print.

.EXAMPLE
    Exit-Error "Some Error" "More Descriptive Error Statement"
#>
function Exit-Error {
    Param (
        [Parameter(Mandatory)]
        [string]$Error,
        [string]$Extended = ""
    )

    $HOST.UI.WriteErrorLine($Error)
    if ($Extended -ne '') {
        $HOST.UI.WriteErrorLine($Extended)
    }

    Wait-ForExit -ExitCode -1
}

<#
.SYNOPSIS
    Extracts an archive to the temporary directory.

.DESCRIPTION
    Extracts an archive to the temporary directory.

.PARAMETER ZipPath
    Path to archive

.EXAMPLE
    Expand-ArchiveToTemp "C:\temp.zip"
#>
function Expand-ArchiveToTemp {
    Param (
        [string]$ZipPath
    )

    try {
        Write-Host "Extract: $ZipPath -> $env:temp"
        Expand-Archive -DestinationPath "$env:temp" $ZipPath
    }
    catch {
        Exit-Error -Error "Could not extract $ZipPath" -Extended $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Downloads a file to a destination.

.DESCRIPTION
    Downloads a file from the provied URI and saves it to the provided location.

.PARAMETER URI
    URI to download file from.

.PARAMETER Destination
    Destination to save the downloaded file to.

.PARAMETER Name
    Name of downloaded file to use in the error statement if an error is encountered.

.EXAMPLE
    Get-Download 'https://some.place/a/file.ext' 'c:\somefile.txt' 'some-file'
#>
function Get-Download {
    Param (
        [Parameter(Mandatory)]
        [string]$URI,
        [Parameter(Mandatory)]
        [string]$Destination,
        [Parameter(Mandatory)]
        [string]$Name
    )
    try {
        Write-Host "Download: $URI -> $Destination"
        (New-Object Net.WebClient).DownloadFile($URI, $Destination)
    }
    catch {
        Exit-Error -Error "Could not download $Name" -Extended $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Installs a powershell module.

.DESCRIPTION
    Installs a powershell module.

.PARAMETER ModuleName
    Name of powershell module to install.

.PARAMETER CurrentUser
....Limit the install scope to the current user

.EXAMPLE
    Install-ModuleByName -ModuleName ModuleNameHere
#>
function Install-ModuleByName() {
    param(
        [Parameter(Mandatory=$True)]
        [System.String]
        $ModuleName,
        [switch]$CurrentUser
    )

    Write-Host "Installing Powershell Module: $ModuleName"
    if ($CurrentUser) {
        Write-Host "Limited to Current User"
    }
    Start-Sleep -Seconds 1

    try {
        if ($CurrentUser) {
            Install-Module $ModuleName -AllowPrerelease -AllowClobber -Force -ErrorAction Stop -Scope CurrentUser
        } else {
            Install-Module $ModuleName -AllowPrerelease -AllowClobber -Force -ErrorAction Stop
        }
    }
    catch {
        Exit-Error "Could not install powershell module: $ModuleName" $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Runs an executable.

.DESCRIPTION
    Runs an executable, blocking until it exits. If a non-zero return code is encountered,
    the script is stopped with a printed error message.

.PARAMETER Exec
    Name of executable to run. (Or path to executable.)

.PARAMETER Arguments
    List of arguments to pass to executable.

.PARAMETER EchoCommand
    Print the command to be run to the screen before running.

.EXAMPLE
    Invoke-Executable "something.exe" @("/arg1", "/arg2")
#>
function Invoke-Executable {
    Param (
        [Parameter(Mandatory)]
        [string]$Exec,
        [Parameter(Mandatory)]
        [string[]]$Arguments,
        [switch]$EchoCommand
    )

    $outFile = Join-Path -Path "$env:TEMP" -ChildPath "$(New-Guid).Guid"
    $errFile = Join-Path -Path "$env:TEMP" -ChildPath "$(New-Guid).Guid"

    if ($EchoCommand) {
        Write-Host "$Exec" $($Arguments -Join " ")
    }

    $procInfo = Start-Process "$Exec" -ArgumentList $Arguments -wait -NoNewWindow -PassThru `
                    -RedirectStandardError "$errFile" -RedirectStandardOutput "$outFile"

    $errInfo = $(Get-Content "$errFile")
    Remove-FileIfExists "$errFile"
    Remove-FileIfExists "$outFile"

    if ($procInfo.ExitCode -ne 0) {
        Exit-Error -Error $("Failed: $Exec " + $Arguments -Join " ") -Extended $errInfo
    }
}

<#
.SYNOPSIS
    Runs an executable without redirects.

.DESCRIPTION
    Runs an executable without redirecting Standard Error and Standard Output. If a
    non-zero return code is encountered, the script is stopped, printing the supplied
    error message.

.PARAMETER Exec
    Name of executable to run. (Or path to executable.)

.PARAMETER Arguments
    List of arguments to pass to executable.

.PARAMETER ErrorMsg
    Message to print when an error has occured.

.PARAMETER EchoCommand
    Print the command to be run to the screen before running.

.EXAMPLE
    Invoke-ExecutableNoRedirect "something.exe" @("/arg1", "/arg2") "An error occured in something.exe"
#>
function Invoke-ExecutableNoRedirect {
    Param (
        [Parameter(Mandatory)]
        [string]$Exec,
        [Parameter(Mandatory)]
        [string[]]$Arguments,
        [Parameter(Mandatory)]
        [string]$ErrorMsg,
        [switch]$EchoCommand
    )

    if ($EchoCommand) {
        Write-Host "$Exec" $($Arguments -Join " ")
    }

    $procInfo = Start-Process "$Exec" -ArgumentList $Arguments -wait -NoNewWindow -PassThru

    if ($procInfo.ExitCode -ne 0) {
        Exit-Error "$ErrorMsg"
    }
}

<#
.SYNOPSIS
    Moves a path to a new location.

.DESCRIPTION
    Moves a path to a new location.

.PARAMETER SourcePath
    Path to move.

.PARAMETER DestPath
    Where to move SourcePath to.

.EXAMPLE
    Move-Path -SourcePath "someplace" -DestPath "newplace"
#>
function Move-Path {
    Param (
        [string]$SourcePath,
        [string]$DestPath
    )

    try {
        Write-Host "Move: $SourcePath -> $DestPath"
        Move-Item -Path "$SourcePath" -Destination "$DestPath"
    }
    catch {
        Exit-Error -Error "Could not move $SourcePath to $DestPath" -Extended $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Creates a new directory.

.DESCRIPTION
    Creates a new directory specified by $newPath, halting the script if directory creation fails.

.PARAMETER Path
    Full path to directory to create.

.EXAMPLE
    New-Directory "C:\test"
#>
function New-Directory {
    Param (
        [Parameter(Mandatory)]
        [string]$Path
    )

    try {
        Write-Host "Make Directory: $Path"
        New-Item -Path "$Path" -ItemType Directory -Force | Out-Null
    }
    catch {
        Exit-Error -Error "Could not create directory: $Path" -Extended $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Reads JSON from a file.

.DESCRIPTION
    Reads JSON from a file, and returns it as a Hash Table.

.PARAMETER Path
    Path to JSON file to read.

.EXAMPLE
    Read-JSON 'c:\somefile.json'

.OUTPUTS
    A Hash Table containing parsed JSON.
#>
function Read-JSON {
    Param (
        [Parameter(Mandatory)]
        [string]$Path
    )

    try {
        Write-Host "Read JSON: $Path"
        $jsonData = Get-Content -Raw -Path "$Path" | ConvertFrom-Json -AsHashtable
        return $jsonData
    }
    catch {
        Exit-Error -Error "Could not read $Path" -Extended $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Deletes a directory if it exists.

.DESCRIPTION
    Deletes a direcctory if it exists, exiting the script on any errors.

.PARAMETER Path
    Path to directory to delete.

.EXAMPLE
    Remove-DirIfExists C:\test
#>
function Remove-DirIfExists {
    Param (
        [Parameter(Mandatory)]
        [string]$Path
    )

    try {
        if (Test-Path "$Path") {
            Write-Host "Remove Directory: $Path"
            Remove-Item "$Path" -Force -Recurse
        }
    }
    catch {
        Exit-Error -Error "Could not remove directory: $Path" -Extended $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Deletes a file if it exists.

.DESCRIPTION
    Deletes a file if it exists, exiting the script on any errors.

.PARAMETER Path
    Path to file to delete.

.EXAMPLE
    Remove-FileIfExists C:\test.txt
#>
function Remove-FileIfExists {
    Param (
        [Parameter(Mandatory)]
        [string]$Path
    )

    try {
        if (Test-Path "$Path") {
            Write-Host "Remove File: $Path"
            Remove-Item "$Path" -Force
        }
    }
    catch {
        Exit-Error -Error "Could not remove file: $Path" -Extended $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Renames a path.

.DESCRIPTION
    Renames a path.

.PARAMETER SourcePath
    Old name.

.PARAMETER DestPath
    New name.

.EXAMPLE
    Rename-Path -SourcePath "someplace" -DestPath "newplace"
#>
function Rename-Path {
    Param(
        [string]$SourcePath,
        [string]$DestPath
    )

    try {
        Write-Host "Rename: $SourcePath -> $DestPath"
        if (Test-Path $SourcePath) {
            Rename-Item "$SourcePath" "$DestPath"
        }
        else {
            Read-Host "$SourcePath does not exist - Press Enter to Exit"
            Exit -1
        }
    }
    catch {
        Exit-Error "Could not rename $SourcePath to $DestPath" -Extended $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Checks if the script is running as an administrator.
.DESCRIPTION
    Checks if the script is running as an administrator.
.EXAMPLE
    Test-IsAdmin
#>
function Test-IsAdmin {
    return ([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544"))
}

<#
.SYNOPSIS
    Determines if scripts is executed in Powershell-Core.

.DESCRIPTION
    Determines if scripts is executed in Powershell-Core.

.EXAMPLE
    Test-IsCore
#>
function Test-IsCore {
    if ($PSversionTable.ContainsKey("PSEdition")) {
        if ($PSVersionTable.PSEdition -eq "Core") {
            return $True
        }
    }

    return $False
}

<#
.SYNOPSIS
    Waits for a key to be pressed to exit.

.DESCRIPTION
    Waits for a key to be pressed to exit, then exits with the provided Exit Code.

.PARAMETER ExitCode
    Code to provide as an ExitCode / ReturnCode.

.EXAMPLE
    Wait-ForExit -ExitCode 0
#>
function Wait-ForExit {
    Param (
        [Parameter(Mandatory)]
        [Int32]$ExitCode
    )

    Write-Host -NoNewLine "`nPress any key to exit...`n"
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

    Exit $ExitCode
}

<#
.SYNOPSIS
    Writes JSON to a file.

.DESCRIPTION
    Writes the provided Hash Table as JSON to a file.

.PARAMETER Data
    JSON Data, as a hash map.

.PARAMETER Path
    Path to file to write JSON to.

.EXAMPLE
    Write-JSON @{'test'='test'} "C:\somefile.json"
#>
function Write-JSON {
    Param (
        [Parameter(Mandatory)]
        [hashtable]$Data,
        [Parameter(Mandatory)]
        [string]$Path
    )

    try {
        Write-Host "Write JSON: $Path"
        $Data | ConvertTo-Json -depth 100 | Out-File "$Path"
    }
    catch {
        Exit-Error -Error "Could not save JSON to $Path" $Error[0].Exception.Message
    }
}
