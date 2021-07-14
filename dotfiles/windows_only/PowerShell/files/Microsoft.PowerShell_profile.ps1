# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Only execute the profile if this is an actual powershell console.
# This is the equivalent of an interactivity check in bash
if ($host.Name -eq 'ConsoleHost') {

    $profileDotD = $(Join-Path -Path $(Split-Path $PROFILE -Parent) -ChildPath "profile.d")
    Get-ChildItem -Path $profileDotD -Filter *.ps1 | Sort-Object -Property Name | ForEach-Object {
        . $_.FullName
    }

    Clear-Host
}
