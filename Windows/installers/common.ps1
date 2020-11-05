# Copyright (C) 2020 Jef Oliver.
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

.PARAMETER execName
    Name of the executable to look for.

.PARAMETER progName
    Name of the program to print in error statement.

.EXAMPLE
    Confirm-Install python.exe python

.OUTPUTS
    Path to installed executable.
#>
function Confirm-Install {
    Param (
        [string]$execName,
        [string]$progName
    )

    try {
        $execPath = $(Get-Command $execName).Source
        return $execPath
    }
    catch {
        Exit-Error "Requirement not found or not installed: $progName"
    }
}

<#
.SYNOPSIS
    Copies a file into place, halting the script if copying fails.

.DESCRIPTION
    Copies a file into place, halting the script if copying fails.

.PARAMETER origFile
    Original file to be copied.

.PARAMETER newFile
    Destination origFile will be copied to.

.EXAMPLE
    Copy-File oldfile.txt newfile.txt
#>
function Copy-File {
    Param (
        [string]$origFile,
        [string]$newFile
    )

    try {
        Copy-Item "$origFile" -Destination "$newFile"
    }
    catch {
        Exit-Error "Could not copy $origFile to $newFile" $Error.Exception.Message
    }
}

<#
.SYNOPSIS
    Writes an error and exits.

.DESCRIPTION
    Prints an error statement to the console, plus a second one if provided,
    then exits.

.PARAMETER errorStringOne
    Required error string to print.

.PARAMETER errorStringTwo
    Optional second error string to print.

.EXAMPLE
    Exit-Error "Some Error" "More Descriptive Error Statement"
#>
function Exit-Error {
    Param (
        [string]$errorStringOne,
        [string]$errorStringTwo = ""
    )

    $HOST.UI.WriteErrorLine($errorStringOne)
    if ($errorStringTwo -ne '') {
        $HOST.UI.WriteErrorLine($errorStringTwo)
    }

    Exit 1
}

<#
.SYNOPSIS
    Creates a new directory.

.DESCRIPTION
    Creates a new directory specified by $newPath, halting the script if directory creation fails.

.PARAMETER newPath
    Full path to directory to create.

.EXAMPLE
    New-Directory "C:\test"
#>
function New-Directory {
    Param (
        [string]$newPath
    )

    try {
        New-Item -Path "$newPath" -ItemType Directory -Force | Out-Null
    }
    catch {
        Exit-Error "Could not create directory: $newPath" $Error.Exception.Message
    }
}

<#
.SYNOPSIS
    Finds and validates basic structure of dotfiles directories.

.DESCRIPTION
    Finds and validates the basic structure of dotfiles directories and returns
    full paths to base and dotfiles directories.

.PARAMETER execPath
    Script execution path.

.PARAMETER pathDepth
    String representing the number of directories to return in the path until
    the base git repo is hit.

.EXAMPLE
    Search-Dotfiles "..\.."

.OUTPUTS
    Object with .Base holding location to base directory for dotfiles, and
    .Dotfiles holding location to the dotfiles directory itself.
#>
function Search-Dotfiles {
    Param (
        [string]$execPath,
        [string]$pathDepth
    )

    [hashtable]$Return = @{}
    $Return.Base = Resolve-Path -LiteralPath $(Join-Path -Path $(Split-Path $execPath -Parent) -ChildPath $pathDepth)
    $Return.Dotfiles = Join-Path -Path $Return.Base -ChildPath "dotfiles"
    $base = Split-Path $Return.Base -Leaf

    if ($base -ne 'dotfiles') {
        Exit-Error "Could not determine base dotfiles directory."
    }

    if (!(Test-Path $Return.Dotfiles)) {
        Exit-Error "Could not determine base dotfiles directory."
    }

    return $Return
}

