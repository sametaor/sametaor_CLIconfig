# File: Update-Winget-Apps.ps1
echo "Checking for upgrades..."
winget upgrade --all --accept-source-agreements --accept-package-agreements --include-pinned
echo "Checking for Chocolatey upgrades..."
sudo choco upgrade all -y -i
Write-Host "`nPress any key to exit..." -ForegroundColor Cyan
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")