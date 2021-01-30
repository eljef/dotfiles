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

Confirm-Install perl StrawberryPerl | Out-Null

Invoke-Executable "git" @("config", "--global", "core.editor", "`"nvim`"") -ShowCommand
Invoke-Executable "git" @("config", "--global", "core.pager", "`"diff-so-fancy | less --tabs=4 -RFX`"" ) -ShowCommand

Invoke-Executable "git" @("config", "--global", "color.ui", "true") -ShowCommand

Invoke-Executable "git" @("config", "--global", "color.diff-highlight.oldNormal", "`"red bold`"") -ShowCommand
Invoke-Executable "git" @("config", "--global", "color.diff-highlight.oldHighlight", "`"red bold 52`"") -ShowCommand
Invoke-Executable "git" @("config", "--global", "color.diff-highlight.newNormal", "`"green bold`"") -ShowCommand
Invoke-Executable "git" @("config", "--global", "color.diff-highlight.newHighlight", "`"green bold 22`"") -ShowCommand

Invoke-Executable "git" @("config", "--global", "color.diff.meta", "`"11`"") -ShowCommand
Invoke-Executable "git" @("config", "--global", "color.diff.frag", "`"magenta bold`"") -ShowCommand
Invoke-Executable "git" @("config", "--global", "color.diff.commit", "`"yellow bold`"") -ShowCommand
Invoke-Executable "git" @("config", "--global", "color.diff.old", "`"red bold`"") -ShowCommand
Invoke-Executable "git" @("config", "--global", "color.diff.new", "`"green bold`"") -ShowCommand
Invoke-Executable "git" @("config", "--global", "color.diff.whitespace", "`"red reverse`"") -ShowCommand
