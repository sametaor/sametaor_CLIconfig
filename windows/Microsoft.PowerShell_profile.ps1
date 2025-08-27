Import-Module -Name Microsoft.WinGet.Client
Import-Module -Name Microsoft.WinGet.CommandNotFound
Import-Module -Name BurntToast
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
$canConnectToGitHub = Test-Connection github.com -Count 1 -Quiet -TimeoutSeconds 1
function Update-PowerShell {
    if (-not $global:canConnectToGitHub) {
        Write-Host "Skipping PowerShell update check due to GitHub.com not responding within 1 second." -ForegroundColor Yellow
        return
    }

    try {
        Write-Host "Checking for PowerShell updates..." -ForegroundColor Cyan
        $updateNeeded = $false
        $currentVersion = $PSVersionTable.PSVersion.ToString()
        $gitHubApiUrl = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
        $latestReleaseInfo = Invoke-RestMethod -Uri $gitHubApiUrl
        $latestVersion = $latestReleaseInfo.tag_name.Trim('v')
        if ($currentVersion -lt $latestVersion) {
            $updateNeeded = $true
        }

        if ($updateNeeded) {
            Write-Host "Updating PowerShell..." -ForegroundColor Yellow
            winget upgrade "Microsoft.PowerShell" --accept-source-agreements --accept-package-agreements
            Write-Host "PowerShell has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
        } else {
            Write-Host "Your PowerShell is up to date." -ForegroundColor Green
        }
    } catch {
        Write-Error "Failed to update PowerShell. Error: $_"
    }
}
Update-PowerShell
function Update-Profile {
    if (-not $global:canConnectToGitHub) {
        Write-Host "Skipping profile update check due to GitHub.com not responding within 1 second." -ForegroundColor Yellow
        return
    }

    try {
        $url = "https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/refs/heads/master/windows/Microsoft.PowerShell_profile.ps1"
        $oldhash = Get-FileHash $PROFILE
        Invoke-RestMethod $url -OutFile "$env:temp/Microsoft.PowerShell_profile.ps1"
        $newhash = Get-FileHash "$env:temp/Microsoft.PowerShell_profile.ps1"
        if ($newhash.Hash -ne $oldhash.Hash) {
            Copy-Item -Path "$env:temp/Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
            Write-Host "Profile has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
        }
    } catch {
        Write-Error "Unable to check for `$profile updates"
    } finally {
        Remove-Item "$env:temp/Microsoft.PowerShell_profile.ps1" -ErrorAction SilentlyContinue
    }
}
Update-Profile
fastfetch
function cd { z }
function z1 { z .. }
function z2 { z ../.. }
function z3 { z ../../.. }
function c { clear }
function vim { nvim }
function vi { nvim }
function ls { eza -a -l --icons=always --colour=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o }
function lsg { ls -G }
function lsm { eza -lbhHigUmuSa@ --time-style=long-iso --git --icons=always --colour=always }
function lt { ls -T -L 2 --no-user }
function ga { git add }
function gall { git add . }
function gb { git branch }
function gba { git branch -a }
function gc { git commit -v }
function gca { git commit -v -a }
function gci { git commit --interactive }
function gcl { git clone }
function gcm { git commit -v -m }
function gdel { git branch -D }
function gexport { git archive --format=zip --output }
function gl { git pull }
function gm { git merge }
function gp { git push }
function gpp { gill pull && git push }
function gpr { git pull --rebase }
function gs { git status }
function gw { git whatchanged }
function gha { gh auth }
function ghli { gh auth login }
function ghlih { gh auth login --hostname }
function ghliw { gh auth login --web }
function ghlo { gh auth logout }
function ghloh { gh auth logout --hostname }
function ghast { gh auth status }
function ghasth { gh auth status --hostname }
function ghastt { gh auth status --show-token }
function ghatk { gh auth token }
function ghatkh { gh auth token --hostname }
function ghb { gh browse }
function ghbc { gh browse --commit }
function ghbn { gh browse --no-browser }
function ghbp { gh browse --projects }
function ghbs { gh browse --settings }
function ghbw { gh browse --wiki }
function ghcf { gh config }
function ghcfg { gh config get }
function ghcfl { gh config list }
function ghcfs { gh config set }
function ghh { gh help }
function ghst { gh status }
function ghste { gh status --exclude }
function ghsto { gh status --org }
function ghw { gh workflow }
function ghwd { gh workflow disable }
function ghwe { gh workflow enable }
function ghwl { gh workflow list }
function ghwla { gh workflow list --all }
function ghwlL { gh workflow list --limit }
function ghwr { gh workflow run }
function ghwrj { gh workflow run --json }
function ghwv { gh workflow view }
function ghwvw { gh workflow view --web }
function ghwvy { gh workflow view --yaml }
function ghg { gh gist }
function ghgcl { gh gist clone }
function ghgcr { gh gist create }
function ghgcrp { gh gist create --public }
function ghgcrw { gh gist create --web }
function ghgd { gh gist delete }
function ghge { gh gist edit }
function ghgl { gh gist list }
function ghgll { gh gist list --limit }
function ghglp { gh gist list --public }
function ghgls { gh gist list --secret }
function ghgv { gh gist view }
function ghgvf { gh gist view --files }
function ghgvr { gh gist view --raw }
function ghgvw { gh gist view --web }
function ghi { gh issue }
function ghicl { gh issue close }
function ghicm { gh issue comment }
function ghicme { gh issue comment --editor }
function ghicml { gh issue comment --edit-last }
function ghicmw { gh issue comment --web }
function ghicr { gh issue create }
function ghicra { gh issue create --assignee }
function ghicrl { gh issue create --label }
function ghicrm { gh issue create --milestone }
function ghicrp { gh issue create --project }
function ghicrw { gh issue create --web }
function ghid { gh issue delete }
function ghidc { gh issue delete --confirm }
function ghie { gh issue edit }
function ghil { gh issue list }
function ghila { gh issue list --assignee }
function ghilA { gh issue list --author }
function ghilj { gh issue list --json }
function ghill { gh issue list --label }
function ghilL { gh issue list --limit }
function ghilM { gh issue list --mention }
function ghilm { gh issue list --milestone }
function ghilS { gh issue list --search }
function ghils { gh issue list --state }
function ghilw { gh issue list --web }
function ghip { gh issue pin }
function ghir { gh issue reopen }
function ghis { gh issue status }
function ghisj { gh issue status --json }
function ghit { gh issue transfer }
function ghiu { gh issue unpin }
function ghiv { gh issue view }
function ghivc { gh issue view --comments }
function ghivw { gh issue view --web }
function ghp { gh pr }
function ghpco { gh pr checkout }
function ghpcod { gh pr checkout --detach }
function ghpcof { gh pr checkout --force }
function ghpcor { gh pr checkout --recurse-submodules }
function ghpcs { gh pr checks }
function ghpcsr { gh pr checks --required }
function ghpcsW { gh pr checks --watch }
function ghpcsw { gh pr checks --web }
function ghpcl { gh pr close }
function ghpcld { gh pr close --delete-branch }
function ghpcm { gh pr comment }
function ghpcme { gh pr comment --editor }
function ghpcml { gh pr comment --edit-last }
function ghpcmw { gh pr comment --web }
function ghpcr { gh pr create }
function ghpcra { gh pr create --assignee }
function ghpcrd { gh pr create --draft }
function ghpcrf { gh pr create --fill }
function ghpcrl { gh pr create --label }
function ghpcrm { gh pr create --milestone }
function ghpcrn { gh pr create --no-maintainer-edit }
function ghpcrp { gh pr create --project }
function ghpcrw { gh pr create --web }
function ghpd { gh pr diff }
function ghpdn { gh pr diff --name-only }
function ghpdp { gh pr diff --patch }
function ghpdw { gh pr diff --web }
function ghpe { gh pr edit }
function ghpl { gh pr list }
function ghpla { gh pr list --assignee }
function ghplA { gh pr list --author }
function ghplb { gh pr list --base }
function ghpld { gh pr list --draft }
function ghplh { gh pr list --head }
function ghplj { gh pr list --json }
function ghpll { gh pr list --label }
function ghplL { gh pr list --limit }
function ghplS { gh pr list --search }
function ghpls { gh pr list --state }
function ghplw { gh pr list --web }
function ghpm { gh pr merge }
function ghpma { gh pr merge --admin }
function ghpmau { gh pr merge --auto }
function ghpmd { gh pr merge --delete-branch }
function ghpmda { gh pr merge --disable-auto }
function ghpmm { gh pr merge --merge }
function ghpmr { gh pr merge --rebase }
function ghpms { gh pr merge --squash }
function ghprd { gh pr ready }
function ghprdu { gh pr ready --undo }
function ghpro { gh pr reopen }
function ghprv { gh pr review }
function ghprva { gh pr review --approve }
function ghprvc { gh pr review --comment }
function ghprvr { gh pr review --request-changes }
function ghps { gh pr status }
function ghpsc { gh pr status --conflict-status }
function ghpsj { gh pr status --json }
function ghpv { gh pr view }
function ghpvc { gh pr view --comments }
function ghpvj { gh pr view --json }
function ghpvw { gh pr view --web }
function ghrl { gh release }
function ghrlc { gh release create }
function ghrlcd { gh release create --draft }
function ghrlcg { gh release create --generate-notes }
function ghrlcl { gh release create --latest }
function ghrlcp { gh release create --prerelease }
function ghrld { gh release delete }
function ghrldc { gh release delete --cleanup-tag }
function ghrldy { gh release delete --yes }
function ghrlda { gh release delete-asset }
function ghrlday { gh release delete-asset --yes }
function ghrldo { gh release download }
function ghrldoc { gh release download --clobber }
function ghrldos { gh release download --skip-existing }
function ghrle { gh release edit }
function ghrled { gh release edit --draft }
function ghrlel { gh release edit --latest }
function ghrlep { gh release edit --prerelease }
function ghrll { gh release list }
function ghrlle { gh release list --exclude-drafts }
function ghrlu { gh release upload }
function ghrluc { gh release upload --clobber }
function ghrlv { gh release view }
function ghrlvw { gh release view --web }
function ghrp { gh repo }
function ghrpa { gh repo archive }
function ghrpay { gh repo archive --confirm }
function ghrpcl { gh repo clone }
function ghrpc { gh repo create }
function ghrpca { gh repo create --add-readme }
function ghrpcc { gh repo create --clone }
function ghrpcdi { gh repo create --disable-issues }
function ghrpcdw { gh repo create --disable-wiki }
function ghrpcia { gh repo create --include-all-branches }
function ghrpci { gh repo create --internal }
function ghrpcpv { gh repo create --private }
function ghrpcpb { gh repo create --public }
function ghrpcps { gh repo create --push }
function ghrpd { gh repo delete }
function ghrpdc { gh repo delete --confirm }
function ghrpdk { gh repo deploy-key }
function ghrpdka { gh repo deploy-key add }
function ghrpdkaw { gh repo deploy-key add --allow-write }
function ghrpdkd { gh repo deploy-key delete }
function ghrpdkl { gh repo deploy-key list }
function ghrpe { gh repo edit }
function ghrpeat { gh repo edit --add-topic }
function ghrpeaf { gh repo edit --allow-forking }
function ghrpeau { gh repo edit --allow-update-branch }
function ghrpedb { gh repo edit --default-branch }
function ghrpedm { gh repo edit --delete-branch-on-merge }
function ghrpeds { gh repo edit --description }
function ghrpeam { gh repo edit --enable-auto-merge }
function ghrped { gh repo edit --enable-discussions }
function ghrpei { gh repo edit --enable-issues }
function ghrpemc { gh repo edit --enable-merge-commit }
function ghrpep { gh repo edit --enable-projects }
function ghrperm { gh repo edit --enable-rebase-merge }
function ghrpesm { gh repo edit --enable-squash-merge }
function ghrpew { gh repo edit --enable-wiki }
function ghrpeh { gh repo edit --homepage }
function ghrpert { gh repo edit --remove-topic }
function ghrpet { gh repo edit --template }
function ghrpev { gh repo edit --visibility }
function ghrpf { gh repo fork }
function ghrpfc { gh repo fork --clone }
function ghrpfr { gh repo fork --remote }
function ghrpl { gh repo list }
function ghrpla { gh repo list --archived }
function ghrplf { gh repo list --fork }
function ghrpln { gh repo list --no-archived }
function ghrpls { gh repo list --source }
function ghrpr { gh repo rename }
function ghrprc { gh repo rename --confirm }
function ghrps { gh repo sync }
function ghrpsf { gh repo sync --force }
function ghrpv { gh repo view }
function ghrpvw { gh repo view --web }
function pipc { pip config }
function pipcg { pip config --global }
function pipcgd { pip config --global debug }
function pipcge { pip config --global edit }
function pipcgg { pip config --global get }
function pipcgl { pip config --global list }
function pipcgs { pip config --global set }
function pipcgu { pip config --global unset }
function pipcu { pip config --user }
function pipcud { pip config --user debug }
function pipcue { pip config --user edit }
function pipcug { pip config --user get }
function pipcul { pip config --user list }
function pipcus { pip config --user set }
function pipcuu { pip config --user unset }
function pipde { pip debug }
function piph { pip help }
function pipi { pip install }
function pipiu { pip install --upgrade }
function pipl { pip list }
function piplo { pip list --outdated }
function piplu { pip list --uptodate }
function piple { pip list --editable }
function pipll { pip list --local }
function pipsh { pip show }
function pipu { pip uninstall }
function pipuy { pip uninstall --yes }
function pipUp { python -m pip install --upgrade pip }
function pipV { pip --version }
function dps { docker ps }
function drit { docker run -it }
function deit { docker exec -it }
function dlog { docker logs }
function dip { docker inspect --format "{{ .NetworkSettings.IPAddress }}" $* }
function dstop-all { docker stop $(docker ps -q -f "status=running") }
function drm { docker rm }
function dvls { docker volume ls $* }
function fd {
    fd
    fzf
}
function fzf { fzf --preview 'bat --color=always {}' --preview-window '~3' }
function gpglk { gpg --list-secret-key --keyid-format LONG }
function gpgep { gpg --armor --export }
function ytnpl { yt-dlp --no-playlist --restrict-filenames }
function ytp { ytnpl --write-subs --write-auto-subs --format 244+299 }
function ytpp { ytnpl --write-subs --write-auto-subs --format 247+299 }
function yts { ytnpl --write-subs --write-auto-subs --format worstaudio --extract-audio }
function ytm { ytnpl --format bestaudio --extract-audio }
function sysinfo { Get-ComputerInfo }
function flushdns { Clear-DnsClientCache }
function cpy { Set-Clipboard $args[0] }
function pst { Get-Clipboard }
function git-send {
    git add .
    git commit -m "$args"
    git push
}
function nf { param($name) New-Item -ItemType "file" -Path . -Name $name }
function mkcd { param($dir) mkdir $dir -Force; Set-Location $dir }
function head {
  param($Path, $n = 5)
  Get-Content $Path -Head $n
}

function tail {
  param($Path, $n = 5)
  Get-Content $Path -Tail $n
}
function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) {
    Get-Process $name
}
function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}
function df {
    get-volume
}
function uptime {
    if ($PSVersionTable.PSVersion.Major -eq 5) {
        Get-WmiObject win32_operatingsystem | Select-Object @{Name='LastBootUpTime'; Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
    } else {
        net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
    }
}
function ff($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Output "$($_.directory)\$($_)"
    }
}
function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}
function sed($file, $find, $replace) {
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}
function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/refs/heads/master/misc/sametaor.omp.json' | Invoke-Expression
Import-Module -Name Terminal-Icons
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Invoke-Expression (& { (zoxide init powershell | Out-String) })
echo "Checking for upgrades..."
winget upgrade --all --include-pinned
sudo choco upgrade all -y -i
