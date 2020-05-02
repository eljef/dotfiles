# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Only execute the profile if this is an actual powershell console.
# This is the equivalent of an interactivity check in bash
if ($host.Name -eq 'ConsoleHost') {

    # Imports
    Import-Module -name eljef
    Import-Module -name Get-ChildItemColor
    Import-Module -name PSReadLine

    # Disable the bell
    Set-PSReadlineOption -BellStyle None

    # Default variables
    $console = $host.UI.RawUI

    # Buffer settings
    $buffer = $console.BufferSize
    $buffer.Width = 130
    $buffer.Height = 3000
    $console.BufferSize = $buffer

    # Colorize output of dir/ls
    Set-Alias ls Get-ChildItemColor -option AllScope -Force
    Set-Alias dir Get-ChildItemColor -option AllScope -Force

    # Tab completion
    Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadlineKeyHandler -Key Tab -Function Complete

    # Automatically close quotes. (Provided by https://github.com/lzybkr/PSReadLine)
    Set-PSReadlineKeyHandler -Chord 'Oem7','Shift+Oem7' `
                                -BriefDescription SmartInsertQuote `
                                -LongDescription "Insert paired quotes if not already on a quote" `
                                -ScriptBlock {
        param($key, $arg)

        $line = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadline]::GetBufferState([ref]$line, [ref]$cursor)

        if ($line[$cursor] -eq $key.KeyChar) {
            # Just move the cursor
            [Microsoft.PowerShell.PSConsoleReadline]::SetCursorPosition($cursor + 1)
        }
        else {
            # Insert matching quotes, move cursor to be in between the quotes
            [Microsoft.PowerShell.PSConsoleReadline]::Insert("$($key.KeyChar)" * 2)
            [Microsoft.PowerShell.PSConsoleReadline]::GetBufferState([ref]$line, [ref]$cursor)
            [Microsoft.PowerShell.PSConsoleReadline]::SetCursorPosition($cursor - 1)
        }
    }

    # Clear the host window
    Clear-Host
}

function prompt {
    Write-Host (GetPromptString) -nonewline
	return " "
}
