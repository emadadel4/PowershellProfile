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

" -ForegroundColor Yellow

function emad {
    [CmdletBinding()]
    param (
        [string]$Go,
        [string]$Test,
        [string]$open,
        [string]$Install,
        [switch]$Help,
        [string]$Options,
        [string]$run

    )

    if ($Help) {
        Write-Host "usage: emad  [<command>] [<options>]  `n` "
        Write-Host "The following commands are available:"
        Write-Host "  -open         Specifies where to navigate. Available options: 'github' or 'itt' or 'telegram'."
        Write-Host "  -go           Specifies where to navigate. Available options: 'desktop' or 'itt repo'."
        Write-Host "  -test         Check internet A ping Test"
        Write-Host "  -install      Install program's"
        Write-Host "  -Help         Display this help message."
        return
    }

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

    }

    switch ($go) 
    {
        "desktop" { 
            Set-Location "C:\Users\$env:USERNAME\Desktop"
        }

        "itt" { 
            Set-Location "C:\Users\$env:USERNAME\Documents\Github\ITT" 
        }

        "website" { 
            Set-Location "C:\Users\$env:USERNAME\Documents\Github\emadadel4.github.io" 
        }
    }

    switch ($run) 
    {
        "itt" { 
            irm bit.ly/emadadel | iex 
        }
    }

    switch ($Test) 
    {
        "ping" { 
            ping www.google.com -t
        }
    }

    switch ($Install) 
    {
        "choco" { 
            Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) *> $null
        }
    }
}

function Q
{
    Clear-Host
}

function ch {

    $historyFilePath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
    
    if (Test-Path $historyFilePath) {
        Remove-Item $historyFilePath -Force
    } else {
        Write-Output "ConsoleHost_history.txt not found."
    }
}



