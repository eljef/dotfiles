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

$commonScript = Resolve-Path -LiteralPath `
                $(Join-Path -Path $(Split-Path $MyInvocation.MyCommand.Source -Parent) `
                -ChildPath "..\common.ps1")
. $commonScript

Confirm-Install nvim neovim | Out-Null
Confirm-Install sed base.sed | Out-Null

##### Variables needed throughout the script ###################################

$vimPlugURI = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

$dirInfo = Search-Dotfiles $MyInvocation.MyCommand.Source "..\..\.."

$nodeExec = $(Confirm-Install node.exe nodejs) -replace "\\", "\/"
$pythonExec = $(Confirm-Install python.exe python) -replace "\\", "\/"

$nvimDir = Join-Path -Path "$env:LOCALAPPDATA" -ChildPath "nvim"

##### Actual script functionality ##############################################

New-Directory $nvimDir
New-Directory $(Join-Path -Path "$nvimDir" -ChildPath "autoload")
New-Directory $(Join-Path -Path "$nvimDir" -ChildPath "plugged")

Get-Download $vimPlugURI $(Join-Path -Path "$nvimDir" -ChildPath "autoload\plug.vim") "vim-plug"

Copy-File $(Join-Path -Path $dirInfo.Dotfiles -ChildPath "config\nvim\init.vim") $(Join-Path -Path "$nvimDir" -ChildPath "init.vim")
Copy-File $(Join-Path -Path $dirInfo.Dotfiles -ChildPat "coc-settings.json") $(Join-Path -Path "$nvimDir" -ChildPath "coc-settings.json")

# Fix plugin directory location
Invoke-Executable "sed" @("-i", "-e",
                          "`"s/call plug#begin.*/call plug#begin\('~\/AppData\/local\/nvim\/plugged'\)/`"",
                          $(Join-Path -Path "$nvimDir" -ChildPath "init.vim"))

# Fix node executable location
Invoke-Executable "sed" @("-i", "-e",
                          "`"s/let g:coc_node_path.*/let g:coc_node_path='$nodeExec'/`"",
                          $(Join-Path -Path "$nvimDir" -ChildPath "init.vim"))

# Fix python executable location
Invoke-Executable "sed" @("-i", "-e",
                          "`"s/\/usr\/bin\/python/$pythonExec/g`"",
                          $(Join-Path -Path "$nvimDir" -ChildPath "coc-settings.json"))

