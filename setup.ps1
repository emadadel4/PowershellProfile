if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You must run this script as an Administrator!"
    break
}

Add-Type -AssemblyName System.Drawing

function Install-Choco {
    
    try {
        Write-Host "Installing Choco..."
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) *> $null
    }
    catch {
        Write-Error "Failed to install Chocolatey. Error: $_"
    }
}

function Install-Modules {

    try {
        Write-Host "Installing Modules and [GIT],[oh-my-posh]"
        Install-Module -Name Terminal-Icons -Repository PSGallery -Force -AllowClobber -SkipPublisherCheck
        choco install oh-my-posh --confirm --acceptlicense -q -r --ignore-http-cache --allowemptychecksumsecure --allowemptychecksum --usepackagecodes --ignoredetectedreboot --ignore-checksums --ignore-reboot-requests
        choco install git --confirm --acceptlicense -q -r --ignore-http-cache --allowemptychecksumsecure --allowemptychecksum --usepackagecodes --ignoredetectedreboot --ignore-checksums --ignore-reboot-requests
    }
    catch {
        Write-Error "Failed to install Module or it has not exist any more: $_"
    }
}

function Install-Fonts {

   param(
    [string]$fontUrl = "https://github.com/emadadel4/PowershellProfile/raw/main/fonts.zip",
    [string]$zipFilePath = "$env:TEMP\fonts.zip",
    [string]$extractPath = "$env:TEMP\myfont"
   )

   try {

        Write-Host "Installing fonts..."

        Invoke-WebRequest -Uri $fontUrl -OutFile "$env:TEMP\fonts.zip"
        Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
        $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
        $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name
        Get-ChildItem -Path $extractPath -Recurse -Filter "*.ttf" | ForEach-Object {
            If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
                $destination.CopyHere($_.FullName, 0x10)
            }
        }
        Remove-Item -Path "$env:TEMP\myfont" -Recurse -Force
        Remove-Item -Path "$env:TEMP\fonts.zip" -Recurse -Force
   }
   catch
   {
        Write-Error "Failed to extract or install $_"
   }
}

function Download-Profile {

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

    $path = "C:\Users\$env:USERNAME\Documents\GitHub\itt"
    $choise =  Read-Host "Clone itt repository?: [Y] to Clone / [Enter] to Skip"

   if($choise -eq ""){return}

   if (-not (Test-Path -Path $path)) {
        Write-Host "cloning..."
        mkdir -p ~/Documents/GitHub 
        Set-Location ~/Documents/GitHub
        git clone https://github.com/emadadel4/ITT.git
   }
   else{
    Write-Host "GitHub folder already exists."
   }
}

function Update-Powershell {

    $choise =  Read-Host "Update Powershell to 7: [Y] to Update / [Enter] to skip"
    if($choise -eq "") { return }
    Write-Host "Updating..."
    iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
}  

function CheckPSV {
   
    # Get the current PowerShell version
    $currentVersion = $PSVersionTable.PSVersion

    # GitHub API URL for fetching the latest PowerShell release
    $githubUrl = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"

    # Get the latest release information from GitHub
    $response = Invoke-RestMethod -Uri $githubUrl

    # Extract the latest version from the GitHub response (e.g., 'v7.3.4')
    $latestVersion = $response.tag_name.TrimStart('v')

    # Convert both versions to System.Version for comparison
    $current = [Version]$currentVersion
    $latest = [Version]$latestVersion

    # Compare the current version with the latest version
    if ($latest -gt $current) {
        Write-Host "A new version of PowerShell is available: $latest"
        Update-Powershell
    } 
    else
    {
        Write-Host "You are using the latest version of PowerShell: $current"
    }
}

Install-Choco | Out-Null
CheckPSV
Install-Modules
Install-Fonts
Download-Profile
Clone-Repository
Start-Process "https://github.com/emadadel4"