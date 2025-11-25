# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# resolve paths
$env:XDG_CONFIG_HOME = "$HOME/.config"
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Import Modules and External Profiles
# Ensure Terminal-Icons module is installed before importing
if (-not (Get-Module -ListAvailable -Name Terminal-Icons))
{
  Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -SkipPublisherCheck
}
Import-Module -Name Terminal-Icons

# sfsu
Invoke-Expression (&sfsu hook)

# Admin Check and Prompt Customization
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
function prompt
{
  if ($isAdmin)
  { "[" + (Get-Location) + "] # " 
  } else
  { "[" + (Get-Location) + "] $ " 
  }
}
$adminSuffix = if ($isAdmin)
{ " [ADMIN]" 
} else
{ "" 
}
$Host.UI.RawUI.WindowTitle = "PowerShell {0}$adminSuffix" -f $PSVersionTable.PSVersion.ToString()

# Utility Functions
function Test-CommandExists
{
  param($command)
  $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
  return $exists
}

# Editor Configuration
$EDITOR = if (Test-CommandExists nvim)
{ 'nvim' 
} elseif (Test-CommandExists code)
{ 'code' 
} else
{ 'notepad' 
}
Set-Alias -Name vim -Value $EDITOR

function touch($file)
{ "" | Out-File $file -Encoding ASCII 
}

# Network Utilities
function Get-PubIP
{ (Invoke-WebRequest http://ifconfig.me/ip).Content 
}

# System Utilities
function uptime
{
  if ($PSVersionTable.PSVersion.Major -eq 5)
  {
    Get-WmiObject win32_operatingsystem | Select-Object @{Name='LastBootUpTime'; Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
  } else
  {
    net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
  }
}

function reloadprofile
{
  & $profile
}

function unzip ($file)
{
  Write-Output("Extracting", $file, "to", $pwd)
  $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
  Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function grep($regex, $dir)
{
  if ( $dir )
  {
    Get-ChildItem $dir | select-string $regex
    return
  }
  $input | select-string $regex
}

function df
{
  get-volume
}

function which($name)
{
  Get-Command $name | Select-Object -ExpandProperty Definition
}

function export($name, $value)
{
  set-item -force -path "env:$name" -value $value;
}

function pkill($name)
{
  Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name)
{
  Get-Process $name
}

function head
{
  param($Path, $n = 10)
  Get-Content $Path -Head $n
}

function tail
{
  param($Path, $n = 10)
  Get-Content $Path -Tail $n
}

# Do scoop exist
$SCOOP_EXIST = Test-CommandExists scoop

function Install-From-Scoop($name)
{
  try
  {
    Invoke-Expression "scoop install $name"
    Write-Host "$name installed successfully. Initializing..."
  } catch
  {
    return $_
  }
}

# Quick File Creation
function nf
{ param($name) New-Item -ItemType "file" -Path . -Name $name 
}

# Directory Management
function mkcd
{ param($dir) mkdir $dir -Force; Set-Location $dir 
}

### Quality of Life Aliases

# Navigation Shortcuts
function docs
{ Set-Location -Path $HOME\Documents 
}

function dtop
{ Set-Location -Path $HOME\Desktop 
}

# Enhanced Listing
function ll
{ Get-ChildItem -Path . -Force | Format-Table -AutoSize 
}
function la
{ Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize 
}

# Git Shortcuts
Set-Alias g git

# Quick Access to System Information
function sysinfo
{ Get-ComputerInfo 
}

# Networking Utilities
function flushdns
{ Clear-DnsClientCache 
}

# Clipboard Utilities
function cpy
{ Set-Clipboard $args[0] 
}

function pst
{ Get-Clipboard 
}


# Enhanced PowerShell Experience
Set-PSReadLineOption -Colors @{
  Command = 'Yellow'
  Parameter = 'Green'
  String = 'DarkCyan'
}


if (Test-CommandExists starship)
{
  Invoke-Expression (& { (starship init powershell | Out-String) })
} else
{
  if ($SCOOP_EXIST)
  {
    Write-Host "starship command not found. Attempting to install via scoop..."
    try
    {
      Install-From-Scoop "starship"
      Invoke-Expression (& { (starship init powershell | Out-String) })
    } catch
    {
      Write-Error "Failed to install starship. Error: $_"
    }
  } else
  {
    Write-Error "Install scoop in order to install starship."
  }
}

if (Test-CommandExists zoxide)
{
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
} else
{
  if ($SCOOP_EXIST)
  {
    Write-Host "zoxide command not found. Attempting to install via scoop..."
    try
    {
      Install-From-Scoop "zoxide"
      Invoke-Expression (& { (zoxide init powershell | Out-String) })
    } catch
    {
      Write-Error "Failed to install zoxide. Error: $_"
    }
  } else
  {
    Write-Error "Install scoop in order to install zoxide."
  }
}

if (Test-CommandExists mise)
{
  fnm env --use-on-cd --shell power-shell | Out-String | Invoke-Expression
} else
{
  if ($SCOOP_EXIST)
  {
    Write-Host "mise command not found. Attempting to install via scoop..."
    try
    {
      Install-From-Scoop "mise"
      mise install
    } catch
    {
      Write-Error "Failed to install mise. Error: $_"
    }
  } else
  {
    Write-Error "Install scoop in order to install mise."
  }
}
