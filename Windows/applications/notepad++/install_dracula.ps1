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
                -ChildPath "\..\..\installers\common.ps1")
. $commonScript

Confirm-Install notepad++ notepad++ | Out-Null

$dirInfo = Search-Dotfiles $MyInvocation.MyCommand.Source "..\..\.."
$nppFolder = Join-Path -Path "$env:APPDATA" -ChildPath "Notepad++"
$nppThemesFolder = Join-Path -Path "$nppFolder" -ChildPath "themes"

New-Directory $nppFolder
New-Directory $nppThemesFolder

Copy-File $(Join-Path -Path $dirInfo.Base -ChildPath "Windows\applications\notepad++\Dracula.xml") `
          $(Join-Path -Path "$nppThemesFolder" -ChildPath "Dracula.xml")

