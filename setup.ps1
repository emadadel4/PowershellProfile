if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You must run this script as an Administrator!"
    break
}

Add-Type -AssemblyName System.Drawing



function DownloadProfile {

    param (
        [string]$url = "https://raw.githubusercontent.com/emadadel4/PowershellProfile/main/Microsoft.PowerShell_profile.ps1",
        [string]$url2 = "https://raw.githubusercontent.com/emadadel4/PowershellProfile/main/settings.json",
        [string]$jsonLocation = "C:\Users\Emad Adel\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
    )
    

    try {

        Invoke-RestMethod $url -OutFile $PROFILE
        Invoke-RestMethod $url2 -OutFile $jsonLocation

        Write-Host "The profile @ [$PROFILE] has been created"
    }
    catch {
        Write-Error "Failed download profile. Error: $_"
    }
}

DownloadProfile