$winget_script = "https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/windows/wingetinstall.json"
$winutil_script = "https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/windows/winutilconfig.json"

winget upgrade all

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco upgrade chocolatey

Invoke-Expression "& { $(Invoke-RestMethod christitus.com/win) } -Config $winutil_script -Run"

winget import -i $winget_script --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements --nowarn --disable-interactivity --wait

try {
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name

    if ($fontFamilies -notcontains "CaskaydiaCove NF") {
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFileAsync((New-Object System.Uri("https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip")), ".\CascadiaCode.zip")
        
        while ($webClient.IsBusy) {
            Start-Sleep -Seconds 2
        }

        Expand-Archive -Path ".\CascadiaCode.zip" -DestinationPath ".\CascadiaCode" -Force
        $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
        Get-ChildItem -Path ".\CascadiaCode" -Recurse -Filter "*.ttf" | ForEach-Object {
            If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {        
                $destination.CopyHere($_.FullName, 0x10)
            }
        }

        Remove-Item -Path ".\CascadiaCode" -Recurse -Force
        Remove-Item -Path ".\CascadiaCode.zip" -Force
    }
}
catch {
    Write-Error "Failed to download or install the Cascadia Code font. Error: $_"
}

try {
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force
}
catch {
    Write-Error "Failed to install Terminal Icons module. Error: $_"
}

try {
    Install-Module PSReadLine -AllowPrerelease -Force
}
catch {
    Write-Error "Failed to install PSReadLine module. Error: $_"
}

wsl --install
wsl --update
wsl --set-default-version 2
wsl --install -d Ubuntu

Invoke-WebRequest -Uri https://bootstrap.pypa.io/get-pip.py -OutFile get-pip.pyp
python get-pip.py
python -m pip install -U pip
pip install -r https://raw.githubusercontent.com/sametaor/Test-bot-for-Discord/requirements.txt

npm install -g npm

Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop bucket add extras
scoop bucket add games
scoop bucket add nerd-fonts
scoop bucket add nirsoft
scoop bucket add sysinternals
scoop install aria2
scoop install archwsl

Install-Module AnyPackage

Invoke-WebRequest -Uri “https://download.scdn.co/SpotifySetup.exe” -OutFile SpotifySetup.exe
Start-Process -FilePath SpotifySetup.exe
Invoke-WebRequest -useb https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.ps1 | Invoke-Expression

Invoke-RestMethod https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/windows/Microsoft.PowerShell_profile.ps1 -OutFile $PROFILE

Invoke-WebRequest -useb https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/refs/heads/master/.config/fastfetch/config.jsonc -OutFile $HOME\fastfetch

git config --global user.name "sametaor"
git config --global user.email "71749831+sametaor@users.noreply.github.co"

gh auth login
gh config set editor code
gh alias set ~s search
gh alias set st status
gh alias set ex extension
gh ex install jrnxf/gh-eco
gh ex install dlvhdr/gh-dash
gh ex install vilmibm/gh-screensaver
gh ex install redraw/gh-install
gh ex install korosuke613/gh-user-stars
gh alias set scr screensaver
gh alias set stars user-stars

$osInfo = Get-CimInstance -ClassName Win32_OperatingSystem

if ($osInfo.Caption -like "*Home*") { & "HyperV_on_HomeEdition.bat" } else {

    Write-Output "Skipping HyperV installation as detected version is not Home Edition"

}