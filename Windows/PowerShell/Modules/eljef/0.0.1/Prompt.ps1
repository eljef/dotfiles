function GetPromptString {
    $location = $($(Get-Location) -replace ($env:USERPROFILE).Replace('\','\\'), "~")
    if ($location -ne "~") {
        $location = $(get-item $pwd).Name
    }

    $rprompt = "[$ENV:USERNAME@$ENV:COMPUTERNAME"
    $rprompt += " "
    $rprompt += $location
    $rprompt += "]"

    return $rprompt
}
