# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Env
$env:XDG_CONFIG_HOME = "$HOME/.config"
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Alias
Set-Alias ll "eza -l -g --icons"
Set-Alias lla "ll -a"
Set-Alias g git

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Local Config
$localConfig = Join-Path $PSScriptRoot 'local.ps1'
if (Test-Path -Path $localConfig -PathType Leaf) {
    . $localConfig
}

# Init tools
Invoke-Expression (&starship init powershell)
