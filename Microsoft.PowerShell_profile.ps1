
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) 
{
    Write-Host "Setup my powershell profile... " -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    choco install oh-my-posh --confirm --acceptlicense -q -r --ignore-http-cache --allowemptychecksumsecure --allowemptychecksum --usepackagecodes --ignoredetectedreboot --ignore-checksums --ignore-reboot-requests
    #Write-Output "Restart the treminal "
    Clear-Host
}

& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kali.omp.json" --print) -join "`n"))

    # if (-not (Get-Module -Name Terminal-Icons -ListAvailable)) {
    #     Install-Module -Name Terminal-Icons -Repository PSGallery
    # }
    # else
    # {
    #     Import-Module -Name Terminal-Icons
    # }

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


function Add-Log {

    param (
        [string]$Message, # Content of Message
        [string]$Level = "INFO" # Message Level [INFO] [ERROR] [WARNING],
    )

    $timestamp = Get-Date -Format "hh:mm tt"

    # Determine the color based on the log level
    switch ($Level.ToUpper()) {
        "INFO" { $color = "White" }
        "WARNING" { $color = "Yellow" }
        "ERROR" { $color = "Red" }
        "Installed" { $color = "White" }
        "Apply" { $color = "White" }
        default { $color = "White" }
    }

    switch ($Level.ToUpper()) {
        "INFO" { $icon = "+" }
        "WARNING" { $icon = "!" }
        "ERROR" { $icon = "X" }
        "Installed" { $icon = "√" }
        "Apply" { $icon = "√" }
        "Disabled" { $icon = "X" }
        "Enabled" { $icon = "√" }
        default { $icon = "!" }
    }

    # Construct the log message
    $logMessage =  "[$icon] $Message"

    # Write the log message to the console with the specified color
    Write-Host "$logMessage" -ForegroundColor $color

}

function 13x {
   
    [CmdletBinding()]
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string]$Search = $null
    )
    
    if ($Search) {
        if (-not $Search.Trim()) {
            Write-Host "Please provide a search query."
        } else {
            # Encode the search query for use in a URL
            $encodedQuery = [System.Web.HttpUtility]::UrlEncode($Search)

            # Define the DuckDuckGo search URL with the encoded query
            $url = "https://www.1337x.to/search/$encodedQuery/1/"

            # Open the search results in the default web browser
            Start-Process $url
        }
    }else {
        Write-Host "usage: [<13x>] [<search query>]  `n` "
    }

}

function fitgirl {
   
    [CmdletBinding()]
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string]$Search = $null
    )
    
    if ($Search) {
        if (-not $Search.Trim()) {
            Write-Host "Please provide a search query."
        } else {
            # Encode the search query for use in a URL
            $encodedQuery = [System.Web.HttpUtility]::UrlEncode($Search)

            # Define the DuckDuckGo search URL with the encoded query
            $url = "https://fitgirl-repacks.site/?s=$encodedQuery"

            # Open the search results in the default web browser
            Start-Process $url
        }
    }else {
        Write-Host "usage: [<fitgirl>] [<search query>]  `n` "
    }

}

function yt {
   
    [CmdletBinding()]
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string]$Search = $null
    )
    
    if ($Search) {
        if (-not $Search.Trim()) {
            Write-Host "Please provide a search query."
        } else {
            # Encode the search query for use in a URL
            $encodedQuery = [System.Web.HttpUtility]::UrlEncode($Search)

            # Define the DuckDuckGo search URL with the encoded query
            $url = "https://www.youtube.com/results?search_query=$encodedQuery"

            # Open the search results in the default web browser
            Start-Process $url
        }
    }else {
        Write-Host "usage: [<yt>] [<search query>]  `n` "
    }
}

function gog {
   
    [CmdletBinding()]
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string]$Search = $null
    )
    
    if ($Search) {
        if (-not $Search.Trim()) {
            Write-Host "Please provide a search query."
        } else {
            # Encode the search query for use in a URL
            $encodedQuery = [System.Web.HttpUtility]::UrlEncode($Search)

            # Define the DuckDuckGo search URL with the encoded query
            $url = "https://www.google.com/search?q=$encodedQuery"

            # Open the search results in the default web browser
            Start-Process $url
        }
    }else {
        Write-Host "usage: [<gog>] [<search query>]  `n` "
    }
}

# Show help
function help {

    Write-Host "usage: [<command>] [<options>]  `n` "
    Write-Host "The following commands are available:"
    Write-Host "  open         Specifies where to navigate. Available options: 'github' or 'itt' or 'telegram' 'exhdd'"
    Write-Host "  jump         Specifies where to navigate. Available options: 'desktop' or 'itt repo'."
    Write-Host "  install      Install program's using choco"
    Write-Host "  help         Display this help message."
    Write-Host "  run          Execute specific commands"
    Write-Host "  itt          Launch itt"
    Write-Host "  search       Search on DuckDuckGo"
    Write-Host "  gog          Search on Google"
    Write-Host "  kill         End program"
    Write-Host "  rex          Restart explorer"
    Write-Host "  Re           Opening Recycle bin"
    Write-Host "  dark         Toggle dark mode"
    Write-Host "  ch           Clear commands history"
    Write-Host "  q            Clear-Host"
}

function aaaaaaaa {
    param (
        [string]$url = "https://raw.githubusercontent.com/emadadel4/itt/main/itt.ps1"
    )

    Add-Log -Message "Launch itt..." -Level "info"
    Invoke-RestMethod $url | Invoke-Expression
}

# Excute powershell command
function run {
    [CmdletBinding()]
    param (
        [string]$run
    )

    switch ($run) 
    {
        "aaaaaaaaaaa" { 
            Write-Host "ITT Relasse..."
            irm https://raw.githubusercontent.com/emadadel4/itt/main/itt.ps1 | iex

        }

        "ittupdate" { 
            Write-Host "ITT Debug..."
            irm https://raw.githubusercontent.com/emadadel4/ITT/update/itt.ps1 | iex

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
        "fast" { 
            Start-Process ("https://fast.com") 
        }"yt" { 
            Start-Process ("https://youtube.com") 
        }
        "doc" { 
            Start-Process ("C:\Users\$env:USERNAME\Documents") 
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
        [Parameter(ValueFromRemainingArguments = $true)]
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
function kill {
    param (
        [string]$name
    )

    try {
        # Attempt to get and stop the process
        $process = Get-Process -Name $name -ErrorAction Stop
        Stop-Process -InputObject $process -ErrorAction Stop
        Add-Log -Message "Process '$name' stopped successfully." -Level "INFO"
    }
    catch {
        # Handle any errors that occur
        Add-Log -Message "Failed to create file '$name'. Error: $_" -Level "ERROR"
    }
}

# Clear history commands
function ch {

    $historyFilePath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
    
    if (Test-Path $historyFilePath) {
        Remove-Item $historyFilePath -Force
        Add-Log -Message "History Claerd" -Level "Info"
    } else {
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
         Add-Log -Message "Copied" -Level "INFO"
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
        [string]$name
    )

    try {
        # Attempt to create the file
        New-Item -ItemType "file" -Path . -Name $name -ErrorAction Stop
        Add-Log -Message "File '$name' created successfully." -Level "INFO"
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
        bcdedit /set {current} safeboot minimal
    
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

function Re { Add-Log -Message "Opening Recycle bin..." -Level "info"; Start-Process C:\Windows\explorer.exe shell:RecycleBinFolder}
