@{
    ModuleToProcess = 'eljef.psm1'

    ModuleVersion = '0.0.1'

    GUID = '17a71896-d6b8-4af7-93f3-3471f1e980a8'

    Author = 'Jef Oliver'

    Copyright = '(c) 2017-2020 Jef Oliver. All rights reserved.'

    Description = 'Provides functions ElJef uses on a common basis.'

    PowerShellVersion = '2.0'

    FunctionsToExport = @(
        'Test-Administrator'
    )

    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()

    PrivateData = @{
        PSData = @{
            Tags = @('eljef', 'prompt')
            LicenseUri = 'https://github.com/eljef'
            ProjectUri = 'https://github.com/eljef'
            ReleaseNotes = 'https://github.com/eljef'
        }
    }
}
