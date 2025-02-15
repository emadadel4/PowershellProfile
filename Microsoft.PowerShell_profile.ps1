& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kali.omp.json" --print) -join "`n"))

if (-not (Get-Module -Name Terminal-Icons -ListAvailable)) {
    Install-Module -Name Terminal-Icons -Repository PSGallery
}
else {
    Import-Module -Name Terminal-Icons
}
Import-Module PSReadLine
Set-Alias ll Get-ChildItem
Set-Alias cls Clear-Host

# Show help
function help {

    Write-Host "`n`Usage: [<command>] [<options>]`n` "
    Write-Host "The following commands are available:"
    Write-Host "help         Display this help message."
    Write-Host "open         Specifies where to navigate. Available options: <github>  <itt> <telegram> <fast> <yts> <doc> <gmail> <blog>"
    Write-Host "jump         Specifies where to navigate. Available options: <desktop> <itt> <blog> <profile>"
    Write-Host "run          Execute specific commands Available options: <itt> <ittupdate>"
    Write-Host "itt          Launch itt (Install Tweaks Tool)"
    Write-Host "search       Search via DuckDuckGo"
    Write-Host "gog          Search via Google"
    Write-Host "fg           Search via fitgirl repacks"
    Write-Host "13x          Search via 1337x"
    Write-Host "kill         End program"
    Write-Host "rex          Restart explorer"
    Write-Host "Re           Opening Recycle bin"
    Write-Host "dark         Toggle dark mode"
    Write-Host "cch          Clear commands history"
    Write-Host "q            Clear-Host"
}
function 13x {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string]$Search = $null,
        [switch]$Help
    )

    if ($Help) {
        Add-Log -Message "Usage: [<13x>] [<search query>]" -Level "INFO"
        return
    }
    
    if ($Search) {
        if (-not $Search.Trim()) {
            Write-Host "Please provide a search query."
        }
        else {
            # Encode the search query for use in a URL
            $encodedQuery = [System.Web.HttpUtility]::UrlEncode($Search)

            # Define the DuckDuckGo search URL with the encoded query
            $url = "https://www.1337x.to/search/$encodedQuery/1/"

            # Open the search results in the default web browser
            Start-Process $url
        }
    }
}
function fg {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string]$Search = $null,
        [switch]$Help
    )
    if ($Help) {
        Add-Log -Message "Usage: [<fitgirl>] [<search query>]" -Level "INFO"
        return
    }
    if ($Search) {
        if (-not $Search.Trim()) {
            Write-Host "Please provide a search query."
        }
        else {
            # Encode the search query for use in a URL
            $encodedQuery = [System.Web.HttpUtility]::UrlEncode($Search)

            # Define the DuckDuckGo search URL with the encoded query
            $url = "https://fitgirl-repacks.site/?s=$encodedQuery"

            # Open the search results in the default web browser
            Start-Process $url
        }
    }
}
function yt {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string]$Search = $null,
        [switch]$Help
    )
    if ($Help) {
        Write-Host "Usage: [<yt>] [<search query>]" -Level "INFO"
        return
    }
    if ($Search) {
        if (-not $Search.Trim()) {
            Write-Host "Please provide a search query."
        }
        else {
            # Encode the search query for use in a URL
            $encodedQuery = [System.Web.HttpUtility]::UrlEncode($Search)

            # Define the DuckDuckGo search URL with the encoded query
            $url = "https://www.youtube.com/results?search_query=$encodedQuery"

            # Open the search results in the default web browser
            Start-Process $url
        }
    }
}
function gog {
   
    [CmdletBinding()]
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string]$Search = $null,
        [switch]$Help
    )

   
    if ($Help) {
        Add-Log -Message "Usage: [<gog>] [<search query>]" -Level "INFO"
        return
    }
    
    if ($Search) {
        if (-not $Search.Trim()) {
            Write-Host "Please provide a search query."
        }
        else {
            # Encode the search query for use in a URL
            $encodedQuery = [System.Web.HttpUtility]::UrlEncode($Search)

            # Define the DuckDuckGo search URL with the encoded query
            $url = "https://www.google.com/search?q=$encodedQuery"

            # Open the search results in the default web browser
            Start-Process $url
        }
    }
}
function itt {
    param (
        [string]$url = "https://raw.githubusercontent.com/emadadel4/itt/main/itt.ps1"
    )

    Write-Host "Launch itt..."
    Invoke-RestMethod $url | Invoke-Expression
}
# Excute powershell command
function run {
    [CmdletBinding()]
    param (
        [string]$run,
        [switch]$Help
    )

    if ($Help) {
        Write-Host "Usage: [<run>] available options [<itt,ittupdate>]"
        return
    }

    switch ($run) {
        "itt" { 
            Write-Host "ITT Relasse..."
            irm https://raw.githubusercontent.com/emadadel4/itt/main/itt.ps1 | iex

        }

        "ittupdate" { 
            Write-Host "ITT Debug..."
            irm https://raw.githubusercontent.com/emadadel4/ITT/update/itt.ps1 | iex

        }
    }
    
}
# Open folder or url etc..
function open {
    [CmdletBinding()]
    param (
        [string]$open,
        [switch]$Help
    )

    if ($Help) {
        Write-Host "Usage: [<open>] available options [<github,itt,blog,fast,yt,doc,gmail>]" 
        return
    }
    
    switch ($open) {
        "github" { 
            Start-Process ("https://github.com/emadadel4") 
        }
        "itt" { 
            Start-Process ("https://github.com/emadadel4/itt") 
        }
        "blog" { 
            Start-Process ("https://emadadel4.github.io/") 
        }
        "fast" { 
            Start-Process ("https://fast.com") 
        }"yt" { 
            Start-Process ("https://youtube.com") 
        }
        "doc" { 
            Start-Process ("C:\Users\$env:USERNAME\Documents") 
        }
        "gmail" {
            Start-Process ("https://mail.google.com/mail/u/0/") 
        }
    }
}
# Jump to specific folder.
function jump {
    [CmdletBinding()]
    param (
        [string]$jump,
        [switch]$Help
    )
    if ($Help) {
        Write-Host "Usage: [<jump>] available options [<Desktop,itt,blog,profile>]" 
        return
    }
    switch ($jump) {
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
# Search based on specific search engine.
function search {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string]$Search = $null,
        [switch]$Help
    )

    if ($Help) {
        Write-Host "Usage: [<search>] [<search query>]" 
        return
    }
    
    if ($Search) {
        if (-not $Search.Trim()) {
            Write-Host "Please provide a search query."
        }
        else {
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
function Q {
    Clear-Host
    & $profile
}
# kill Process
function killit {
    param (
        [string]$name,
        [switch]$Help
    )

    if ($Help) {
        Write-Host "Usage: [<killit>] [<process name>]" 
        return
    }

    try {
        # Attempt to get and stop the process
        $process = Get-Process -Name $name -ErrorAction Stop
        Stop-Process -InputObject $process -ErrorAction Stop
        Write-Host "Process '$name' stopped successfully." 
    }
    catch {
        # Handle any errors that occur
        Write-Host "Failed to create file '$name'. Error: $_" 
    }
}
# Clear commands history 
function cch {

    $historyFilePath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
    
    if (Test-Path $historyFilePath) {
        Remove-Item $historyFilePath -Force
        Write-Host "History Claerd" 
    }
    else {
        Write-Output "ConsoleHost_history.txt not found."
    }
}
# Copy powrshell profile to github repo folder
function cc {
    param(
        [string]$github = "C:\Users\$env:USERNAME\Documents\GitHub\PowershellProfile\",
        [string]$doc = "C:\Users\$env:USERNAME\Documents\PowerShell\"
    )

    try {
        Copy-Item -Path "$doc\*.ps1" -Destination "$github\" -Force
        Write-Host "Copied" 
    }
    catch {

        Write-Error "Failed copy Microsoft.PowerShell_profile.ps1 $_"
    }
}
# Get hidden files in folders
function lh { Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }

# open file with notepad.
function np {
    param(
        $name,
        [switch]$Help
    )

    if ($Help) {
        Write-Host "Usage: np <filename.txt>" 
        return
    }
    
    try {
        notepad.exe $name
    }
    catch {
        Write-Error "Error: $_"
    }
}
# make a new file
function touch {
    param (
        [string]$name,
        [switch]$Help
    )

    if ($Help) {
        Write-Host "Usage: touch <filename.txt>" 
        return
    }
    try {
        # Attempt to create the file
        New-Item -ItemType "file" -Path . -Name $name -ErrorAction Stop
        Write-Host "File '$name' created successfully." 
    }
    catch {
        # Handle any errors that occur
        Write-Host "Failed to create file '$name'. Error: $_" -ForegroundColor Red
    }
}
# Enable & Disable Dark mode
function Dark {
    param (
        $app = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize",
        $system = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    )

    try {
        # Check if the registry keys exist
        if (!(Test-Path $app) -or !(Test-Path $system)) {
            Write-Host "Error: Registry paths not found."
            return
        }

        # Get current theme settings for both App and System
        $currentAppTheme = Get-ItemProperty -Path $app -Name AppsUseLightTheme -ErrorAction Stop
        $currentSystemTheme = Get-ItemProperty -Path $system -Name SystemUsesLightTheme -ErrorAction Stop

        # Toggle the values
        if ($currentAppTheme.AppsUseLightTheme -eq 1 -and $currentSystemTheme.SystemUsesLightTheme -eq 1) {
            # Switch to dark mode
            Set-ItemProperty -Path $app -Name AppsUseLightTheme -Value 0
            Set-ItemProperty -Path $system -Name SystemUsesLightTheme -Value 0
            Write-Host "Switched to Dark Mode."
        }
        else {
            # Switch to light mode
            Set-ItemProperty -Path $app -Name AppsUseLightTheme -Value 1
            Set-ItemProperty -Path $system -Name SystemUsesLightTheme -Value 1
            Write-Host "Switched to Light Mode."
        }
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}
function rex {
    Stop-Process -Name explorer
}
function Safe-Mode {
    $userInput = Read-Host "Do you want to boot into Safe Mode (Yes/No)"
    if ($userInput -eq "Yes") {
        # Enable Safe Mode without networking
        bcdedit /set { current } safeboot minimal
        # Restart the computer
        Write-Host "Your computer will restart and boot into Safe Mode (without Networking)."
        Restart-Computer
    }
    elseif ($userInput -eq "No") {
        Write-Host "Safe Mode will not be enabled. No changes were made."
    }
    else {
        Write-Host "Invalid input. Please type 'Yes' or 'No'."
    }
}
# System Information
function sysinfo { Get-ComputerInfo }
function Re { Start-Process C:\Windows\explorer.exe shell:RecycleBinFolder }
