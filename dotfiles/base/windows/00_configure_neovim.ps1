# Copyright (C) 2020-2024 Jef Oliver.
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

Confirm-Install nvim neovim | Out-Null
Confirm-Install pwsh powershell-core | Out-Null

$neovim_buffer_text = @"

    When the plugin installation is done,
    Please close neovim with :qa!

    Thanks for playing along!

"@

if (Test-IsCore)
{
    $vimPlugURI = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    $filesDir = $(Join-Path -Path $baseDir -ChildPath "dotfiles\base\files")
    $nvimDir = Join-Path -Path "$env:LOCALAPPDATA" -ChildPath "nvim"

    New-Directory $nvimDir
    New-Directory $( Join-Path -Path "$nvimDir" -ChildPath "autoload" )
    New-Directory $( Join-Path -Path "$nvimDir" -ChildPath "lua" )
    New-Directory $( Join-Path -Path "$nvimDir" -ChildPath "plugged" )

    Get-Download $vimPlugURI $( Join-Path -Path "$nvimDir" -ChildPath "autoload\plug.vim" ) "vim-plug"

    Copy-File $( Join-Path -Path $filesDir -ChildPath "nvim\init.lua" )                $( Join-Path -Path "$nvimDir" -ChildPath "init.lua" )
    Copy-File $( Join-Path -Path $filesDir -ChildPath "nvim\lua\airline.lua" )         $( Join-Path -Path "$nvimDir" -ChildPath "lua\airline.vim" )
    Copy-File $( Join-Path -Path $filesDir -ChildPath "nvim\lua\autosave.lua" )        $( Join-Path -Path "$nvimDir" -ChildPath "lua\autosave.vim" )
    Copy-File $( Join-Path -Path $filesDir -ChildPath "nvim\lua\default.lua" )         $( Join-Path -Path "$nvimDir" -ChildPath "lua\default.vim" )
    Copy-File $( Join-Path -Path $filesDir -ChildPath "nvim\lua\dracula.lua" )         $( Join-Path -Path "$nvimDir" -ChildPath "lua\dracula.vim" )
    Copy-File $( Join-Path -Path $filesDir -ChildPath "nvim\lua\nerdtree.lua" )        $( Join-Path -Path "$nvimDir" -ChildPath "lua\nerdtree.vim" )
    Copy-File $( Join-Path -Path $filesDir -ChildPath "nvim\lua\plugins_windows.vim" ) $( Join-Path -Path "$nvimDir" -ChildPath "lua\plugins.vim" )

    $neovim_buffer_text | nvim -c PlugInstall

    Write-Host "neovim configuration complete"
    Wait-ForExit 0
}
else {
    Start-Process pwsh.exe -ArgumentList "-Command $fileName"
}
