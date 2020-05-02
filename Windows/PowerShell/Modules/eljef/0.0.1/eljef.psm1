if (Get-Module eljef) { return }

. $PSScriptRoot\Prompt.ps1
. $PSScriptRoot\SystemTests.ps1

$exportModuleMemberParams = @{
    Function = @(
        'GetPromptString',
        'Test-Administrator'
    )
}

Export-ModuleMember @exportModuleMemberParams
