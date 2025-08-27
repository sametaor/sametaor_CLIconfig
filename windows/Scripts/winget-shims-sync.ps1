# Folder containing Winget-installed packages
$wingetPackages = "$env:USERPROFILE\AppData\Local\Microsoft\WinGet\Packages"
# Your single shims directory to be added to PATH
$shims = "$env:USERPROFILE\winget-shims"

# Ensure shim folder exists
if (-not (Test-Path $shims)) { New-Item -ItemType Directory -Path $shims | Out-Null }

# Remove any old shims (to clean up removed exes)
Get-ChildItem -Path $shims -Filter *.exe -File | Remove-Item -Force

# Recursively find all Winget .exe files
$executables = Get-ChildItem -Path $wingetPackages -Recurse -Filter *.exe -File

foreach ($exe in $executables) {
    $shimPath = Join-Path $shims $exe.Name
    # Make symlink only if the same-named exe doesn't already exist
    if (-not (Test-Path $shimPath)) {
        # Creates a symlink in the shims folder pointing to the actual exe
        New-Item -ItemType SymbolicLink -Path $shimPath -Target $exe.FullName | Out-Null
    }
}
Write-Host "Shims updated! Add $shims to your PATH if not already present."