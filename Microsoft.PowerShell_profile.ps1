
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) 
{
    Write-Host "Setup my powershell profile... " -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    choco install oh-my-posh --confirm --acceptlicense -q -r --ignore-http-cache --allowemptychecksumsecure --allowemptychecksum --usepackagecodes --ignoredetectedreboot --ignore-checksums --ignore-reboot-requests
    #Write-Output "Restart the treminal "
    Clear-Host
}

& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\json.omp.json" --print) -join "`n"))

    if (-not (Get-Module -Name Terminal-Icons -ListAvailable)) {
        Install-Module -Name Terminal-Icons -Repository PSGallery
    }
    else
    {
        Import-Module -Name Terminal-Icons
    }

    Import-Module PSReadLine

    Set-Alias ll Get-ChildItem
    Set-Alias cls Clear-Host

    Write-Host "

    Welcome 
    ______ __  __    _    ____          
    | ____|  \/  |  / \  |  _ \    
    |  _| | |\/| | / _ \ | | | |   
    | |___| |  | |/ ___ \| |_| |  
    |_____|_|  |_/_/   \_\____/  

    01000101 01001101 01000001 01000100

" -ForegroundColor Yellow

# Show help
function help {

    Write-Host "usage: [<command>] [<options>]  `n` "
    Write-Host "The following commands are available:"
    Write-Host "  open         Specifies where to navigate. Available options: 'github' or 'itt' or 'telegram' 'exhdd'"
    Write-Host "  jump         Specifies where to navigate. Available options: 'desktop' or 'itt repo'."
    Write-Host "  install      Install program's"
    Write-Host "  help         Display this help message."
    Write-Host "  run          Execute specific commands"
    Write-Host "  search       Search on DuckDuckGo"
    Write-Host "  kill         end program"
    Write-Host "  ch           Clear commands history"
    Write-Host "  q            Clear-Host"
}

# Excute powershell command
function run {
    [CmdletBinding()]
    param (
        [string]$run
    )

    switch ($run) 
    {
        "itt" { 
            Write-Host "itt..."
            irm https://raw.githubusercontent.com/emadadel4/ITT/main/itt.ps1 | iex

        }

        "ittupdate" { 
            Write-Host "itt..."
            irm https://raw.githubusercontent.com/emadadel4/ITT/Update/itt.ps1 | iex

        }
    }
    
}

# open folder or url etc..
function open {
    [CmdletBinding()]
    param (
        [string]$open
    )
    
    switch ($open) 
    {
        "github" { 
            Start-Process ("https://github.com/emadadel4") 
        }
        "itt" { 
            Start-Process ("https://github.com/emadadel4/itt") 
        }
        "telegram" { 
            Start-Process ("https://t.me/emadadel4") 
        }
        "blog" { 
            Start-Process ("https://emadadel4.github.io/") 
        }
        "133" { 
            Start-Process ("https://1337x.to") 
        }
        "fast" { 
            Start-Process ("https://fast.com") 
        }"yt" { 
            Start-Process ("https://youtube.com") 
        }
        "doc" { 
            Start-Process ("C:\Users\$env:USERNAME\Documents") 
        }
        "fitgirl" { 
            Start-Process ("https://fitgirl-repacks.site/") 
        }
        "exhdd" { 
            Start-Process ("D:\") 
        }
        "gmail"{
            Start-Process ("https://mail.google.com/mail/u/0/") 
        }
    }
}

# jump to folder
function jump {
    [CmdletBinding()]
    param (
        [string]$jump   
    )

    switch ($jump) 
    {
        "desktop" { 
            Set-Location "C:\Users\$env:USERNAME\Desktop"
        }
        "itt" { 
            Set-Location "C:\Users\$env:USERNAME\Documents\Github\ITT" 
        }
        "blog" { 
            Set-Location "C:\Users\$env:USERNAME\Documents\Github\emadadel4.github.io" 
        }
        "profile" { 
            Set-Location "C:\Users\$env:USERNAME\Documents\Github\PowershellProfile" 
        }
    }
}

# install choco
function install {

    param(
        [string]$Install
    )

    switch ($Install) 
    {
        "choco" { 
            Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) *> $null
        }
    }
    
}

# search based on duckduck go engine
function search {
    [CmdletBinding()]
    param (
        [string]$Search = $null
    )
    
    if ($Search) {
        if (-not $Search.Trim()) {
            Write-Host "Please provide a search query."
        } else {
            # Encode the search query for use in a URL
            $encodedQuery = [System.Web.HttpUtility]::UrlEncode($Search)

            # Define the DuckDuckGo search URL with the encoded query
            $url = "https://duckduckgo.com/?q=$encodedQuery"

            # Open the search results in the default web browser
            Start-Process $url
        }
    }
}

# Clear Host
function Q{
    Clear-Host
    & $profile
}

# kill Process
function kill($name){
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

# Clear history commands
function ch {

    $historyFilePath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
    
    if (Test-Path $historyFilePath) {
        Remove-Item $historyFilePath -Force
        Write-Output "Commands history cleard!"
    } else {
        Write-Output "ConsoleHost_history.txt not found."
    }
}

# Copy powrshell profile to github repo folder
function pp {

    param(
        [string]$github = "C:\Users\$env:USERNAME\Documents\GitHub\PowershellProfile\",
        [string]$doc = "C:\Users\$env:USERNAME\Documents\PowerShell\"
    )

    try {
         Copy-Item -Path "$doc\*.ps1" -Destination "$github\" -Force
         Write-Host "copied." -ForegroundColor Yellow
    }
    catch {

        Write-Error "Failed copy Microsoft.PowerShell_profile.ps1 $_"
    }

}

# Get hidden files in folders
function lh {Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }

# open file with notepad.
function np {
    param($name)
    notepad.exe $name
}

# make a new file
function touch {
    param (
        $name
    )
    New-Item -ItemType "file" -Path . -Name $name
}

# System Information
function sysinfo { Get-ComputerInfo }