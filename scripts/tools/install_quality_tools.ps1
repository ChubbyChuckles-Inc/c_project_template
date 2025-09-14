param(
    [switch]$ForceInstall
)

param(
    [switch]$ForceInstall
)

function Test-EnsureAdmin {
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        Write-Host "Script requires elevation. Relaunching as administrator..."
        Start-Process -FilePath pwsh -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit 0
    }
}

function Install-ChocoIfMissing {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Chocolatey..."
        Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
        $installScript = (New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')
        Invoke-Expression $installScript
    }
    else {
        Write-Host "Chocolatey present"
    }
}

function Install-ChocoPackageIfMissing([string]$pkg) {
    # Note: Get-Command may not match package name; choco will handle idempotency
    if ($ForceInstall) {
        choco install -y $pkg
    }
    else {
        Write-Host "Installing (if missing): $pkg"
        choco install -y $pkg --no-progress || Write-Host "choco install returned non-zero for $pkg"
    }
}

Test-EnsureAdmin
Install-ChocoIfMissing

Write-Host "Installing packages via Chocolatey..."
choco feature enable -n allowGlobalConfirmation | Out-Null

$pkgs = @('llvm', 'cppcheck', 'doxygen', 'ruby', 'nodejs', 'python', 'git', 'cloc', 'opencppcoverage')
foreach ($p in $pkgs) { Install-ChocoPackageIfMissing -pkg $p }

Write-Host "Installing npm/pip packages..."
if (Get-Command npm -ErrorAction SilentlyContinue) {
    npm install -g jscpd || Write-Host "Failed to install jscpd"
}
else { Write-Host "npm not found; skipping jscpd" }

if (Get-Command pip -ErrorAction SilentlyContinue -or Get-Command pip3 -ErrorAction SilentlyContinue) {
    if (Get-Command pip -ErrorAction SilentlyContinue) { pip install pre-commit || Write-Host "pip pre-commit install failed" }
    elseif (Get-Command pip3 -ErrorAction SilentlyContinue) { pip3 install pre-commit || Write-Host "pip3 pre-commit install failed" }
}
else { Write-Host "pip not found; skipping pre-commit installation" }

Write-Host "Attempting to install lizard via pip..."
if (Get-Command pip -ErrorAction SilentlyContinue) { pip install lizard || Write-Host "pip lizard install failed" }
elseif (Get-Command pip3 -ErrorAction SilentlyContinue) { pip3 install lizard || Write-Host "pip3 lizard install failed" }
else { Write-Host "pip not found; skip lizard" }

Write-Host "Post-install: Updating environment and re-running detection"
if (Get-Command refreshenv -ErrorAction SilentlyContinue) { refreshenv | Out-Null } else { Write-Host "refreshenv not available; please open a new shell to pick up choco-installed PATH changes" }

pwsh -NoProfile -ExecutionPolicy Bypass -File .\scripts\tools\detect_tools.ps1

Write-Host "Installer finished. Review output above for any failures."
