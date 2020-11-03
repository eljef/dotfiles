if (Get-Module eljef) { return }

. $PSScriptRoot\SystemTests.ps1

$exportModuleMemberParams = @{
    Function = @(
        'Test-Administrator'
    )
}

Export-ModuleMember @exportModuleMemberParams
