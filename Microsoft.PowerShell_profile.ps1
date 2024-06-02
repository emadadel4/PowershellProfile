& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\json.omp.json" --print) -join "`n"))
Import-Module -Name Terminal-Icons
Import-Module PSReadLine
Set-Alias ll Get-ChildItem
Set-Alias cls Clear-Host

Write-Host "
Welcome 
______ __  __    _    ____       _    ____  _____ _     
| ____|  \/  |  / \  |  _ \     / \  |  _ \| ____| |    
|  _| | |\/| | / _ \ | | | |   / _ \ | | | |  _| | |    
| |___| |  | |/ ___ \| |_| |  / ___ \| |_| | |___| |___ 
|_____|_|  |_/_/   \_\____/  /_/   \_\____/|_____|_____|

https://github.com/emadadel4
https://t.me/emadadel4

Prompt to use

Go-To [dev] [desktop]
Profile-Links [github] [itt] [telegram]


" -ForegroundColor Yellow

function Get-IP {
    ipconfig | findstr "IPv4"
}

# Function to quickly navigate to commonly used directories
function Go-To {
    param (
        [string]$dir
    )
    switch ($dir) {
        "dev" { Set-Location "C:\Users\$env:USERNAME\Documents\Github\ITT" }
        "desktop" { Set-Location "C:\Users\$env:USERNAME\Desktop" }
        default { Write-Host "Directory alias not found" }
    }
}

function Profile-Links {
    param (
        [string]$dir
    )
    switch ($dir) {
        "github" { Start-Process ("https://github.com/emadadel4") }
        "itt" { Start-Process ("https://github.com/emadadel4/ITT") }
        "telegram" { Start-Process ("https://t.me/emadadel4") }

        "help" { 

            Write-Host "[github] = open Emad Adel Github profile"     
            Write-Host "[itt] = open ITT Github Link"       
            Write-Host "[telegram] = open Emad Adel telegram profile"       

        }

        default { Write-Host "there no command like that" }
    }
}

function InstallChoco {

    Write-Host "Installing Choco..."
}


function Q {

    Clear-Host
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
