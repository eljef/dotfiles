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
