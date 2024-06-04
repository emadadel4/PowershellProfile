& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\json.omp.json" --print) -join "`n"))

    if (-not (Get-Module -Name Terminal-Icons -ListAvailable)) {
        Install-Module -Name Terminal-Icons -Scope CurrentUser
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
        [string]$open,
        [switch]$Help,
        [string]$Options
    )

    if ($Help) {
        Write-Host "usage: emad  [<command>] [<options>]  `n` "
        Write-Host "The following commands are available:"
        Write-Host "  -open         Specifies where to navigate. Available options: 'github' or 'itt' or 'telegram'."
        Write-Host "  -go           Specifies where to navigate. Available options: 'desktop' or 'itt repo'."
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
    }

  
}


