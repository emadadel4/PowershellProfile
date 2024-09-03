if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You must run this script as an Administrator!"
    break
}

Add-Type -AssemblyName System.Drawing

function InstallChoco {
    
    try {
        Write-Host "Installing Choco..."
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) *> $null
    }
    catch {
        Write-Error "Failed to install Chocolatey. Error: $_"
    }
}

function InstallModules {

    try {

        Write-Host "Installing Modules..."
        Install-Module -Name Terminal-Icons -Repository PSGallery -Force
        choco install oh-my-posh --confirm --acceptlicense -q -r --ignore-http-cache --allowemptychecksumsecure --allowemptychecksum --usepackagecodes --ignoredetectedreboot --ignore-checksums --ignore-reboot-requests
        choco install Git.Git --confirm --acceptlicense -q -r --ignore-http-cache --allowemptychecksumsecure --allowemptychecksum --usepackagecodes --ignoredetectedreboot --ignore-checksums --ignore-reboot-requests
    }
    catch {
        Write-Error "Failed to install Module or it has not exist any more: $_"
    }
}

function InstallFonts {

   param(
    [string]$fontUrl = "https://github.com/emadadel4/PowershellProfile/raw/main/fonts.zip",
    [string]$zipFilePath = "$env:TEMP\test.zip",
    [string]$extractPath = "$env:TEMP\fonts"
   )

   try {

        Write-Host "Installing fonts..."

        Invoke-WebRequest -Uri $fontUrl -OutFile $extractPath
        Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
        $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
        $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name
        Get-ChildItem -Path $extractPath -Recurse -Filter "*.ttf" | ForEach-Object {
            If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
                $destination.CopyHere($_.FullName, 0x10)
            }
        }
   }
   catch
   {
        Write-Error "Failed to download or install $_"
   }
   
}

function DownloadProfile {

    param (
        [string]$url = "https://raw.githubusercontent.com/emadadel4/PowershellProfile/main/Microsoft.PowerShell_profile.ps1",
        [string]$url2 = "https://raw.githubusercontent.com/emadadel4/PowershellProfile/main/settings.json",
        [string]$jsonLocation = "C:\Users\$env:USERNAME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
    )
    

    try {

        Write-Host "Setup powershell profile..."
        Invoke-RestMethod $url -OutFile $PROFILE
        Invoke-RestMethod $url2 -OutFile $jsonLocation
        Write-Host "The profile profile has been created" -ForegroundColor Yellow
    }
    catch {
        Write-Error "Failed download profile. Error: $_"
    }
}

function Clone-Repository {

   $choise =  Read-Host "Clone itt repository?: yes/no"

   if($choise -eq "yes")
   {
        Write-Host "cloning..."
        mkdir -p ~/Documents/GitHub
        cd ~/Documents/GitHub
        git clone https://github.com/emadadel4/ITT.git
   }else{
        Write-Host "Continuing without cloning."
   }
}

InstallChoco | Out-Null
InstallModules
InstallFonts
DownloadProfile
Clone-Repository