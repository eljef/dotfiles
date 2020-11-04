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

. .\common.ps1

try {
    Install-Module PSReadLine -AllowPrerelease -Force
}
catch {
    Error-Exit "Could not install PSReadLine" $Error.Exception.Message
}

try {
    Install-Module posh-git -AllowPrerelease -Force
}
catch {
    Error-Exit "Could not install posh-git" $Error.Exception.Message
}

try {
    Install-Module -AllowClobber Get-ChildItemColor
}
catch {
    Error-Exit "Could not install Get-ChildItemColor" $Error.Exception.Message
}

