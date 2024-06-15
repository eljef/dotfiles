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

<#
.SYNOPSIS
    Checks if executable is installed.

.DESCRIPTION
    Checks if executable is installed, printing an error and force exiting if
    it is not. If it is installed, the full path to the executable is returned.

.PARAMETER Executable
    [string] Name of the executable to look for.

.PARAMETER Name
    [string] Name of the program to print in error statement.

.EXAMPLE
    Confirm-Install python.exe python

.OUTPUTS
    [string] Path to installed executable.
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
    Checks if package has been installed by WinGet.

.DESCRIPTION
    Checks if package has been installed by WinGet, returning $True or $False.

.PARAMETER PackageID
    [string] WinGet package ID to check for installation of.

.EXAMPLE
    Confirm-InstalledWithWinGet Git.Git

.OUTPUTS
    [bool] $True if package is installed, $False otherwise.
#>

function Confirm-InstalledWithWinGet {
    Param (
        [Parameter(Mandatory)]
        [string]$PackageID
    )

    $packageData = winget list --exact -q $PackageID
    return [String]::Join("", $packageData).Contains($PackageID)
}

<#
.SYNOPSIS
    Copies ACLs from source to destination.

.DESCRIPTION
    Copies the ACLs that are applied to source and applies them to destination.

.PARAMETER SourcePath
    [string] Path to retrieve ACLs from

.PARAMETER DestPath
    [string] Path to apply ACLS TO

.EXAMPLE
    Copy-ACL oldfile.txt newfile.txt
#>
function Copy-ACL {
    Param (
        [Parameter(Mandatory)]
        [string]$SourcePath,
        [Parameter(Mandatory)]
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
    Copies a file into place, halting the script if copying fails.

.NOTE
    This function overwrites the destination file if it exists.

.PARAMETER Origin
    [string] Path to original file to be copied.

.PARAMETER Destination
    [string] Path to destination to be written.

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
    [string] Required error string to print.

.PARAMETER Extended
    [string] Optional second error string to print.

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
    [string] Path to archive

.EXAMPLE
    Expand-ArchiveToTemp "C:\temp.zip"
#>
function Expand-ArchiveToTemp {
    Param (
        [Parameter(Mandatory)]
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
    [string] URI to download file from.

.PARAMETER Destination
    [string] Destination to save the downloaded file to.

.PARAMETER Name
    Name of downloaded file to use in the error statement if an error is
    encountered.

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
    Installs a group of packages using choco.

.DESCRIPTION
    Installs a group of packages using the chocolatey package manager.

.PARAMETER GroupName
    [string] Package group name to print to the console at install time.

.PARAMETER GroupPackages
    [string[]] List of packages to install.

.EXAMPLE
    Install-GroupWithChoco -GroupName "some group" -GroupPackages @("package1", "package2")
#>
function Install-GroupWithChoco() {
    param(
        [Parameter(Mandatory=$True)]
        [string]$GroupName,
        [Parameter(Mandatory=$True)]
        [string[]]$GroupPackages
    )

    Confirm-Install choco chocolatey | Out-Null
    Write-Host "Installing $GroupName packages with choco"
    $chocoArgs = @("install", "-y") + $GroupPackages
    Invoke-ExecutableNoRedirect "choco" $chocoArgs "An error occured" -EchoCommand
}

<#
.SYNOPSIS
    Installs a group of packages using winget.

.DESCRIPTION
    Installs a group of packages using the WinGet package manager.

.PARAMETER GroupName
    [string] Package group name to print to the console at install time.

.PARAMETER GroupPackages
    [hashtable[]] List of packages to install.

.NOTE
    Package list must be an array of hashtables.
    Hashtables must provide a name key with the value set to the package ID
      provided by WinGet.
    Hashtables can also provide a source key with the WinGet source to use. The
      source key is optional.
    Hashtables can also provide a scope key with the WinGet scope to use. The
      scope key is optional.

    The default source is "winget"
    The default scope is "machine"

.EXAMPLE
    Install-GroupWithWinGet -GroupName "some group" -GroupPackages @(@{name = "test", source = "winget", scope = "machine"})
#>
function Install-GroupWithWinGet() {
    param(
        [Parameter(Mandatory=$True)]
        [string]$GroupName,
        [Parameter(Mandatory=$True)]
        [hashtable[]]$GroupPackages
    )

    Confirm-Install winget WinGet | Out-Null

    Write-Host "Installing $GroupName packages with winget"
    ForEach ($package in $GroupPackages) {
        $packageSource = "winget"
        if ($package.source -ne $null) {
            $packageSource = $package.source
        }
        $packageScope = "machine"
        if ($package.scope -ne $null) {
          $packageScope = $package.scope
        }
        Install-WithWinGet -PackageID $package.name -PackageSource $packageSource -Scope $packageScope
    }
}

<#
.SYNOPSIS
    Installs a powershell module using it's name.

.DESCRIPTION
    Installs a powershell module using it's name.

.PARAMETER ModuleName
    [string] Name of powershell module to install.

.PARAMETER CurrentUser
    [switch] Limit the install scope to the current user

.EXAMPLE
    Install-ModuleByName -ModuleName ModuleNameHere

.EXAMPLE
    Install-ModuleByName -ModuleName ModuleNameHere -CurrentUser
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
    Installs a WinGet package.

.DESCRIPTION
    Installs a WinGet package using its Package ID.

.PARAMETER PackageID
    [string] WinGet package ID to install.

.PARAMETER PackageSource
    [string] Package source WinGet should use to retreive the package from.

.PARAMETER Scope
    [string] Optional scope to use for installation of the package.

.NOTE
    The default scope is "machine".

.EXAMPLE
    Install-WithWinGet -PackageID Package.ID -PackageSource winget

.EXAMPLE
    Install-WithWinGet -PackageID Package.ID -PackageSource winget -Scope user
#>
function Install-WithWinGet {
    Param (
        [Parameter(Mandatory)]
        [string]$PackageID,
        [Parameter(Mandatory)]
        [string]$PackageSource,
        [string]$Scope = "machine"
    )

    if (!(Confirm-InstalledWithWinGet $PackageID)) {
        $wingetArgs = @("install", "--source", $PackageSource, "--scope", $Scope, "--exact", $PackageID)
        Invoke-ExecutableNoRedirect "winget" $wingetArgs "An error occured" -EchoCommand
    } else {
        Write-Host "WinGet package $PackageID already installed."
    }
}

<#
.SYNOPSIS
    Runs an executable.

.DESCRIPTION
    Runs an executable, blocking until it exits. If a non-zero return code is
    encountered, the script is stopped with a printed error message.

.PARAMETER Exec
    [string] Path to or name of executable to run.

.PARAMETER Arguments
    [string[]] List of arguments to pass to executable.

.PARAMETER EchoCommand
    [switch] Print the command to be run to the screen before running.

.EXAMPLE
    Invoke-Executable "something.exe" @("/arg1", "/arg2")

.EXAMPLE
    Invoke-Executable "something.exe" @("/arg1", "/arg2") -EchoCommand
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
    Runs an executable without redirecting Standard Error and Standard Output.
    If a non-zero return code is encountered, the script is stopped, printing
    the supplied error message.

.PARAMETER Exec
    [string] Path to or name of executable to run.

.PARAMETER Arguments
    [string[]] List of arguments to pass to executable.

.PARAMETER ErrorMsg
    [string] Message to print when an error has occured.

.PARAMETER EchoCommand
    [switch] Print the command to be run to the screen before running.

.EXAMPLE
    Invoke-ExecutableNoRedirect "something.exe" @("/arg1", "/arg2") "An error occured in something.exe"

.EXAMPLE
    Invoke-ExecutableNoRedirect "something.exe" @("/arg1", "/arg2") "An error occured in something.exe" -EchoCommand
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
    Moves source path to destionation path.

.PARAMETER SourcePath
    [string] Path to move.

.PARAMETER DestPath
    [string] Where to move SourcePath to.

.EXAMPLE
    Move-Path -SourcePath "someplace" -DestPath "newplace"
#>
function Move-Path {
    Param (
        [Parameter(Mandatory)]
        [string]$SourcePath,
        [Parameter(Mandatory)]
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
    Creates a new directory specified by $newPath, halting the script if
    directory creation fails.

.PARAMETER Path
    [string] Full path to directory to create.

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
    [string] Path to JSON file to read.

.EXAMPLE
    Read-JSON 'c:\somefile.json'

.OUTPUTS
    [hashtable] Parsed JSON.
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
    [string] Path to directory to delete.

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
    [string] Path to file to delete.

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
    [string] Old name.

.PARAMETER DestPath
    [string] New name.

.EXAMPLE
    Rename-Path -SourcePath "someplace" -DestPath "newplace"
#>
function Rename-Path {
    Param(
        [Parameter(Mandatory)]
        [string]$SourcePath,
        [Parameter(Mandatory)]
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
    Checks if user has administrative privleges.

.DESCRIPTION
    Checks if user has administrative privleges.

.OUTPUTS
    [bool] $True if user has administrative privileges, $False otherwise.

.EXAMPLE
    Test-IsAdmin
#>
function Test-IsAdmin {
    return ([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544"))
}

<#
.SYNOPSIS
    Determines if execution is in Powershell-Core.

.DESCRIPTION
    Determines if execution is in Powershell-Core.

.OUTPUTS
    [bool] $True if execution is in Powershell-Core, $False otherwise.

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
    Waits for a key to be pressed to exit, then exits with the provided
    Exit Code.

.PARAMETER ExitCode
    [Int32] Code to provide as an ExitCode / ReturnCode.

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
    [hashtable] JSON Data.

.PARAMETER Path
    [string] Path to file to write JSON to.

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
