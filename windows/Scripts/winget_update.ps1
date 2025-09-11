# File: Update-Winget-Apps.ps1
Set-ExecutionPolicy Unrestricted CurrentUser
echo "Checking for upgrades..."
winget upgrade --all --accept-source-agreements --accept-package-agreements --include-pinned
echo "Checking for Chocolatey upgrades..."
choco upgrade all -y -i