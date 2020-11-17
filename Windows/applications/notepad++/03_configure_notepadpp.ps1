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

$nppFolder = Join-Path -Path "$env:APPDATA" -ChildPath "Notepad++"
$nppFolderPluginsConfig = Join-Path $nppFolder -ChildPath "plugins\Config"
$nppConfigFile = Join-Path -Path "$nppFolder" -ChildPath "config.xml"
$nppLangsFile = Join-Path -Path "$nppFolder" -ChildPath "langs.xml"
$nppThemesFolder = Join-Path -Path "$nppFolder" -ChildPath "themes"
$nppThemeFile = Join-Path -Path "$nppThemesFolder" -ChildPath "Dracula.xml"
$autoSaveConfigFile = Join-Path "$nppFolderPluginsConfig" -ChildPath "AutoSave.ini"

# Configure Notepad++

$nppConfigXML = NEW-OBJECT XML

try {
    $nppConfigXML.load($nppConfigFile)
}
catch {
    Exit-Error "Could not open notepad++ configuration file." $Error.Exception.Message
}

#$XMLfile.NotepadPlus.History.SetAttribute("nbMaxFile", "0")

for ($i = 0; $i -lt $nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig.length; $i++) {
    switch ($nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig[$i].name) {
        'CheckHistoryFiles' {
            $nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig[$i]."#text" = "no";
            break
        }
        'NewDocDefaultSettings' {
            $nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig[$i].format = "2"
            break
        }
        'RememberLastSession' {
            $nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig[$i]."#text" = "no"
            break
        }
        'ScintillaPrimaryView' {
            $nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig[$i].currentLineHilitingShow = "show"
            $nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig[$i].edgeMultiColumnPos = "80 120 "
            $nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig[$i].lineNumberMargin = "show"
            $nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig[$i].smoothFont = "yes"
            $nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig[$i].whiteSpaceShow = "show"
            break
        }
        'stylerTheme' {
            $nppConfigXML.NotepadPlus.GUIConfigs.GuiConfig[$i].path = $nppThemeFile
            break
        }
    }
}

try {
    $nppConfigXML.save($nppConfigFile)
}
catch {
    Exit-Error "Could not save notepad++ configuration file." $Error.Exception.Message
}

# Configure Notepad++ Languages
$nppLangsXML = NEW-OBJECT XML

try {
    $nppLangsXML.load($nppLangsFile)
}
catch {
    Exit-Error "Could not open notepad++ languages file." $Error.Exception.Message
}

for ($i = 0; $i -lt $nppLangsXML.NotepadPlus.Languages.Language.length; $i++) {
    if (($nppLangsXML.NotepadPlus.Languages.Language[$i].name -eq 'bash') -or
        ($nppLangsXML.NotepadPlus.Languages.Language[$i].name -eq 'powershell')) {
        $nppLangsXML.NotepadPlus.Languages.Language[$i].SetAttribute("tabSettings", "132")
    }
}

try {
    $nppLangsXML.save($nppLangsFile)
}
catch {
    Exit-Error "Could not save notepad++ languages file." $Error.Exception.Message
}

# Configure Notepad++ AutoSave Plugin


try {
    $nppAutoSaveINI = Get-IniContent "$autoSaveConfigFile"
}
catch {
    Exit-Error "Could not open notepad++ autosave configuration file." $Error.Exception.Message
}

$nppAutoSaveINI['Options']['Timer'] = 1
$nppAutoSaveINI['Options']['SaveOnActivateApp'] = 1
$nppAutoSaveINI['Options']['SaveOnTimer'] = 1

try {
    Out-IniFile -InputObject $nppAutoSaveINI -FilePath "$autoSaveConfigFile" -Force
}
catch {
    Exit-Error "Could not save notepad++ autosave configuration file." $Error.Exception.Message
}

