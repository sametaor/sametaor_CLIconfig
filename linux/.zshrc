# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# fzf-tab stuff
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-j:accept' 'ctrl-a:toggle-all'


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux command-not-found copypath gh themes zsh-autosuggestions zsh-syntax-highlighting fzf-tab 1password aliases alias-finder zoxide battery brew chezmoi colored-man-pages colorize common-aliases cp direnv dotenv dotnet eza fzf git-auto-fetch git-commit git-escape-magic git-extras github git-lfs git-prompt gnu-utils history httpie man marktext npm pipenv pylint python rclone rsync ruby snap ssh ssh-agent sudo systemd thefuck themes tldr tmux tmuxinator torrent vscode yum zsh-aur-install zsh-bat emoji-fzf autoupdate last-working-dir zsh-expand alias-tips prettyping zsh-git-fzf flatpak)

# Completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh
source /usr/share/doc/git-extras/git-extras-completion.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias upgrade='sudo pacman -Syu --noconfirm && yay -Syu'
alias yay='yay'
alias cd=z
alias z1="z .."
alias z2="z ../.."
alias z3="z ../../.."
alias c=clear
alias rm="rm -r"
alias rmf="rm -rf"
alias cp="cp -rv"
alias mkd="mkdir -p"
alias path='echo -e "${PATH//:/\\n}"'
alias ping=prettyping
alias what='navi --query'
alias nano='nano --modernbindings'
alias sudo=doas
alias sudoedit='doas rnano'
alias codew='codium --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland'
alias code=codium
alias vim=nvim
alias vi=nvim
alias neo='tmatrix -s 15 --fade -c default -C cyan -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10'
alias matrix='tmatrix -s 15 --fade -c default -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10'
alias ':q'=exit
alias ls='eza -a -l --icons=always --colour=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o'
alias lsg='ls -G'
alias lsm='eza -lbhHigUmuSa@ --time-style=long-iso --git --icons=always --colour=always'
alias lt='ls -T -L 2 --no-user'
alias pkgsearch="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias pkgbrowse="pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse"
alias pkgtop="pkgtop -pacman yay"
alias lolcat="lolcat -t"
alias git-send='_git-send() { git add . && git commit -m "$1" && git push }; _git-send'
alias emoj="emoji-fzf preview | fzf -m --preview "emoji-fzf get --name {1}" | cut -d " " -f 1 | emoji-fzf get"
alias bs="brew search"
alias bsd="brew search --desc"
alias binf="brew info"
alias bins="brew install"
alias buns="brew uninstall"
alias bcat="brew cat"
alias btap="brew tap"
alias btapinf="brew tap-info"
alias cask="brew cask"
alias ci="cask info"
alias cis="cask install"
alias brewup="brew -v update && brew -v upgrade && brew cask upgrade && brew -v cleanup --prune=5 && brew doctor"
alias bdr="brew doctor"
alias bls="brew list"
alias cus="brew cask uninstall"
alias cuz="brew cask zap"
alias blv="brew leaves"
alias ga="git add"
alias gall="git add ."
alias gb="git branch"
alias gba="git branch -a"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gci="git commit --interactive"
alias gcl="git clone"
alias gcm="git commit -v -m"
alias gdel="git branch -D"
alias gexport="git archive --format=zip --output"
alias gl="git pull"
alias gm="git merge"
alias gp="git push"
alias gpp="gill pull && git push"
alias gpr="git pull --rebase"
alias gs="git status"
alias gw="git whatchanged"
alias gha='gh auth'
alias ghli='gh auth login'
alias ghlih='gh auth login --hostname'
alias ghliw='gh auth login --web'
alias ghlo='gh auth logout'
alias ghloh='gh auth logout --hostname'
alias ghast='gh auth status'
alias ghasth='gh auth status --hostname'
alias ghastt='gh auth status --show-token'
alias ghatk='gh auth token'
alias ghatkh='gh auth token --hostname'
alias ghb='gh browse'
alias ghbc='gh browse --commit'
alias ghbn='gh browse --no-browser'
alias ghbp='gh browse --projects'
alias ghbs='gh browse --settings'
alias ghbw='gh browse --wiki'
alias ghbx='xdg-open $(gh browse --no-browser)'
alias ghcf='gh config'
alias ghcfg='gh config get'
alias ghcfl='gh config list'
alias ghcfs='gh config set'
alias ghh='gh help'
alias ghst='gh status'
alias ghste='gh status --exclude'
alias ghsto='gh status --org'
alias ghw='gh workflow'
alias ghwd='gh workflow disable'
alias ghwe='gh workflow enable'
alias ghwl='gh workflow list'
alias ghwla='gh workflow list --all'
alias ghwlL='gh workflow list --limit'
alias ghwr='gh workflow run'
alias ghwrj='gh workflow run --json'
alias ghwv='gh workflow view'
alias ghwvw='gh workflow view --web'
alias ghwvy='gh workflow view --yaml'
alias ghg='gh gist'
alias ghgcl='gh gist clone'
alias ghgcr='gh gist create'
alias ghgcrp='gh gist create --public'
alias ghgcrw='gh gist create --web'
alias ghgd='gh gist delete'
alias ghge='gh gist edit'
alias ghgl='gh gist list'
alias ghgll='gh gist list --limit'
alias ghglp='gh gist list --public'
alias ghgls='gh gist list --secret'
alias ghgv='gh gist view'
alias ghgvf='gh gist view --files'
alias ghgvr='gh gist view --raw'
alias ghgvw='gh gist view --web'
alias ghi='gh issue'
alias ghicl='gh issue close'
alias ghicm='gh issue comment'
alias ghicme='gh issue comment --editor'
alias ghicml='gh issue comment --edit-last'
alias ghicmw='gh issue comment --web'
alias ghicr='gh issue create'
alias ghicra='gh issue create --assignee'
alias ghicrl='gh issue create --label'
alias ghicrm='gh issue create --milestone'
alias ghicrp='gh issue create --project'
alias ghicrw='gh issue create --web'
alias ghid='gh issue delete'
alias ghidc='gh issue delete --confirm'
alias ghie='gh issue edit'
alias ghil='gh issue list'
alias ghila='gh issue list --assignee'
alias ghilA='gh issue list --author'
alias ghilj='gh issue list --json'
alias ghill='gh issue list --label'
alias ghilL='gh issue list --limit'
alias ghilM='gh issue list --mention'
alias ghilm='gh issue list --milestone'
alias ghilS='gh issue list --search'
alias ghils='gh issue list --state'
alias ghilw='gh issue list --web'
alias ghip='gh issue pin'
alias ghir='gh issue reopen'
alias ghis='gh issue status'
alias ghisj='gh issue status --json'
alias ghit='gh issue transfer'
alias ghiu='gh issue unpin'
alias ghiv='gh issue view'
alias ghivc='gh issue view --comments'
alias ghivw='gh issue view --web'
alias ghp='gh pr'
alias ghpco='gh pr checkout'
alias ghpcod='gh pr checkout --detach'
alias ghpcof='gh pr checkout --force'
alias ghpcor='gh pr checkout --recurse-submodules'
alias ghpcs='gh pr checks'
alias ghpcsr='gh pr checks --required'
alias ghpcsW='gh pr checks --watch'
alias ghpcsw='gh pr checks --web'
alias ghpcl='gh pr close'
alias ghpcld='gh pr close --delete-branch'
alias ghpcm='gh pr comment'
alias ghpcme='gh pr comment --editor'
alias ghpcml='gh pr comment --edit-last'
alias ghpcmw='gh pr comment --web'
alias ghpcr='gh pr create'
alias ghpcra='gh pr create --assignee'
alias ghpcrd='gh pr create --draft'
alias ghpcrf='gh pr create --fill'
alias ghpcrl='gh pr create --label'
alias ghpcrm='gh pr create --milestone'
alias ghpcrn='gh pr create --no-maintainer-edit'
alias ghpcrp='gh pr create --project'
alias ghpcrw='gh pr create --web'
alias ghpd='gh pr diff'
alias ghpdn='gh pr diff --name-only'
alias ghpdp='gh pr diff --patch'
alias ghpdw='gh pr diff --web'
alias ghpe='gh pr edit'
alias ghpl='gh pr list'
alias ghpla='gh pr list --assignee'
alias ghplA='gh pr list --author'
alias ghplb='gh pr list --base'
alias ghpld='gh pr list --draft'
alias ghplh='gh pr list --head'
alias ghplj='gh pr list --json'
alias ghpll='gh pr list --label'
alias ghplL='gh pr list --limit'
alias ghplS='gh pr list --search'
alias ghpls='gh pr list --state'
alias ghplw='gh pr list --web'
alias ghpm='gh pr merge'
alias ghpma='gh pr merge --admin'
alias ghpmau='gh pr merge --auto'
alias ghpmd='gh pr merge --delete-branch'
alias ghpmda='gh pr merge --disable-auto'
alias ghpmm='gh pr merge --merge'
alias ghpmr='gh pr merge --rebase'
alias ghpms='gh pr merge --squash'
alias ghprd='gh pr ready'
alias ghprdu='gh pr ready --undo'
alias ghpro='gh pr reopen'
alias ghprv='gh pr review'
alias ghprva='gh pr review --approve'
alias ghprvc='gh pr review --comment'
alias ghprvr='gh pr review --request-changes'
alias ghps='gh pr status'
alias ghpsc='gh pr status --conflict-status'
alias ghpsj='gh pr status --json'
alias ghpv='gh pr view'
alias ghpvc='gh pr view --comments'
alias ghpvj='gh pr view --json'
alias ghpvw='gh pr view --web'
alias ghrl='gh release'
alias ghrlc='gh release create'
alias ghrlcd='gh release create --draft'
alias ghrlcg='gh release create --generate-notes'
alias ghrlcl='gh release create --latest'
alias ghrlcp='gh release create --prerelease'
alias ghrld='gh release delete'
alias ghrldc='gh release delete --cleanup-tag'
alias ghrldy='gh release delete --yes'
alias ghrlda='gh release delete-asset'
alias ghrlday='gh release delete-asset --yes'
alias ghrldo='gh release download'
alias ghrldoc='gh release download --clobber'
alias ghrldos='gh release download --skip-existing'
alias ghrle='gh release edit'
alias ghrled='gh release edit --draft'
alias ghrlel='gh release edit --latest'
alias ghrlep='gh release edit --prerelease'
alias ghrll='gh release list'
alias ghrlle='gh release list --exclude-drafts'
alias ghrlu='gh release upload'
alias ghrluc='gh release upload --clobber'
alias ghrlv='gh release view'
alias ghrlvw='gh release view --web'
alias ghrp='gh repo'
alias ghrpa='gh repo archive'
alias ghrpay='gh repo archive --confirm'
alias ghrpcl='gh repo clone'
alias ghrpc='gh repo create'
alias ghrpca='gh repo create --add-readme'
alias ghrpcc='gh repo create --clone'
alias ghrpcdi='gh repo create --disable-issues'
alias ghrpcdw='gh repo create --disable-wiki'
alias ghrpcia='gh repo create --include-all-branches'
alias ghrpci='gh repo create --internal'
alias ghrpcpv='gh repo create --private'
alias ghrpcpb='gh repo create --public'
alias ghrpcps='gh repo create --push'
alias ghrpd='gh repo delete'
alias ghrpdc='gh repo delete --confirm'
alias ghrpdk='gh repo deploy-key'
alias ghrpdka='gh repo deploy-key add'
alias ghrpdkaw='gh repo deploy-key add --allow-write'
alias ghrpdkd='gh repo deploy-key delete'
alias ghrpdkl='gh repo deploy-key list'
alias ghrpe='gh repo edit'
alias ghrpeat='gh repo edit --add-topic'
alias ghrpeaf='gh repo edit --allow-forking'
alias ghrpeau='gh repo edit --allow-update-branch'
alias ghrpedb='gh repo edit --default-branch'
alias ghrpedm='gh repo edit --delete-branch-on-merge'
alias ghrpeds='gh repo edit --description'
alias ghrpeam='gh repo edit --enable-auto-merge'
alias ghrped='gh repo edit --enable-discussions'
alias ghrpei='gh repo edit --enable-issues'
alias ghrpemc='gh repo edit --enable-merge-commit'
alias ghrpep='gh repo edit --enable-projects'
alias ghrperm='gh repo edit --enable-rebase-merge'
alias ghrpesm='gh repo edit --enable-squash-merge'
alias ghrpew='gh repo edit --enable-wiki'
alias ghrpeh='gh repo edit --homepage'
alias ghrpert='gh repo edit --remove-topic'
alias ghrpet='gh repo edit --template'
alias ghrpev='gh repo edit --visibility'
alias ghrpf='gh repo fork'
alias ghrpfc='gh repo fork --clone'
alias ghrpfr='gh repo fork --remote'
alias ghrpl='gh repo list'
alias ghrpla='gh repo list --archived'
alias ghrplf='gh repo list --fork'
alias ghrpln='gh repo list --no-archived'
alias ghrpls='gh repo list --source'
alias ghrpr='gh repo rename'
alias ghrprc='gh repo rename --confirm'
alias ghrps='gh repo sync'
alias ghrpsf='gh repo sync --force'
alias ghrpv='gh repo view'
alias ghrpvw='gh repo view --web'
alias pipc='pip config'
alias pipcg='pip config --global'
alias pipcgd='pip config --global debug'
alias pipcge='pip config --global edit'
alias pipcgg='pip config --global get'
alias pipcgl='pip config --global list'
alias pipcgs='pip config --global set'
alias pipcgu='pip config --global unset'
alias pipcu='pip config --user'
alias pipcud='pip config --user debug'
alias pipcue='pip config --user edit'
alias pipcug='pip config --user get'
alias pipcul='pip config --user list'
alias pipcus='pip config --user set'
alias pipcuu='pip config --user unset'
alias pipde='pip debug'
alias piph='pip help'
alias pipi='pip install'
alias pipiu='pip install --upgrade'
alias pipl='pip list'
alias piplo='pip list --outdated'
alias piplu='pip list --uptodate'
alias piple='pip list --editable'
alias pipll='pip list --local'
alias pipsh='pip show'
alias pipu='pip uninstall'
alias pipuy='pip uninstall --yes'
alias pipUp='python -m pip install --upgrade pip'
alias pipV='pip --version'
alias dps="docker ps"
alias drit="docker run -it"
alias deit="docker exec -it"
alias dlog="docker logs"
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}" $*'
alias dstop-all='docker stop $(docker ps -q -f "status=running")'
alias drm='docker rm'
alias dvls='docker volume ls $*'
alias fd="fd | fzf"
alias fzf="fzf --preview 'bat --color=always {}' --preview-window '~3'"
alias gpglk="gpg --list-secret-key --keyid-format LONG"
alias gpgep="gpg --armor --export"
alias ytnpl="yt-dlp --no-playlist --restrict-filenames"
alias ytp="ytnpl --write-subs --write-auto-subs --format 244+299"
alias ytpp="ytnpl --write-subs --write-auto-subs --format 247+299"
alias yts="ytnpl --write-subs --write-auto-subs --format worstaudio --extract-audio"
alias ytm="ytnpl --format bestaudio --extract-audio"
alias sc-lsu="sudo systemctl list-units"
alias sc-iact="sudo systemctl is-active"
alias sc-status="sudo systemctl status"
alias sc-show="sudo systemctl show"
alias sc-help="sudo systemctl help"
alias sc-lsuf="sudo systemctl list-unit-files"
alias sc-ien="sudo systemctl is-enabled"
alias sc-lsj="sudo systemctl list-jobs"
alias sc-showenv="sudo systemctl show-environment"
alias sc-cat="sudo systemctl cat"
alias sc-lst="sudo systemctl list-timers"
alias sc-start="sudo systemctl start"
alias sc-stop="sudo systemctl stop"
alias sc-reload="sudo systemctl reload"
alias sc-restart="sudo systemctl restart"
alias sc-trystart="sudo systemctl try-restart"
alias sc-iso="sudo systemctl isolate"
alias sc-kill="sudo systemctl kill"
alias sc-repass="sudo systemctl reset-failed"
alias sc-en="sudo systemctl enable"
alias sc-dis="sudo systemctl disable"
alias sc-reen="sudo systemctl reenable"
alias sc-pre="sudo systemctl preset"
alias sc-mask="sudo systemctl mask"
alias sc-unmask="sudo systemctl unmask"
alias sc-link="sudo systemctl link"
alias sc-load="sudo systemctl load"
alias sc-cancel="sudo systemctl cancel"
alias sc-setenv="sudo systemctl set-environment"
alias sc-unsetenv="sudo systemctl unset-environment"
alias sc-edit="sudo systemctl edit"
alias sc-ennow="sudo systemctl enable --now"
alias sc-disnow="sudo systemctl disable --now"
alias sc-masknow="sudo systemctl mask --now"
alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
alias hless='function hdi(){ howdoi $* -c | less --raw-control-chars --quit-if-one-screen --no-init; }; hdi'
alias hcook='function hcook(){ HOWDOI_URL=cooking.stackexchange.com howdoi $* ; }; hcook'
alias hso='function hso(){ HOWDOI_URL=stackoverflow.com howdoi $* ; }; hso'
alias hpol='function hpol(){ HOWDOI_URL=politics.stackexchange.com howdoi $* ; }; hpol'
alias htor='function htor(){ HOWDOI_URL=tor.stackexchange.com howdoi $* ; }; htor'
alias hsnd='function hsnd(){ HOWDOI_URL=sound.stackexchange.com howdoi $* ; }; hsnd'
alias hastro='function hastro(){ HOWDOI_URL=astronomy.stackexchange.com howdoi $* ; }; hastro'
alias haub='function haub(){ HOWDOI_URL=askubuntu.com howdoi $* ; }; haub'
alias hacad='function hacad(){ HOWDOI_URL=academia.stackexchange.com howdoi $* ; }; hacad'
alias hmov='function hmov(){ HOWDOI_URL=movies.stackexchange.com howdoi $* ; }; hmov'
alias htrav='function htrav(){ HOWDOI_URL=travel.stackexchange.com howdoi $* ; }; htrav'
alias hjp='function hjp(){ HOWDOI_URL=japanese.stackexchange.com howdoi $* ; }; hjp'
alias hgd='function hgd(){ HOWDOI_URL=graphicdesign.stackexchange.com howdoi $* ; }; hgd'
alias hcs='function hcse(){ HOWDOI_URL=computer-science.stackexchange.com howdoi $* ; }; hcse'
alias hsec='function hse(){ HOWDOI_URL=security.stackexchange.com howdoi $* ; }; hse'
alias hchess='function hchess(){ HOWDOI_URL=chess.stackexchange.com howdoi $* ; }; hchess'
alias hvid='function hvid(){ HOWDOI_URL=video.stackexchange.com howdoi $* ; }; hvid'
alias hwapps='function hwapps(){ HOWDOI_URL=webapps.stackexchange.com howdoi $* ; }; hwapps'
alias hunix='function hunix(){ HOWDOI_URL=unix.stackexchange.com howdoi $* ; }; hunix'
alias hux='function hux(){ HOWDOI_URL=ux.stackexchange.com howdoi $* ; }; hux'
alias hphil='function hphil(){ HOWDOI_URL=philosophy.stackexchange.com howdoi $* ; }; hphil'
alias hphoto='function hphoto(){ HOWDOI_URL=photo.stackexchange.com howdoi $* ; }; hphoto'
alias hdiy='function hdiy(){ HOWDOI_URL=diy.stackexchange.com howdoi $* ; }; hdiy'
alias hgdev='function hgdev(){ HOWDOI_URL=gamedev.stackexchange.com howdoi $* ; }; hgdev'
alias hsu='function hsu(){ HOWDOI_URL=superuser.com howdoi $* }; hsu'
alias hgame='function hgame(){ HOWDOI_URL=gaming.stackexchange.com howdoi $* }; hgame'
alias hdroid='function hdroid(){ HOWDOI_URL=android.stackexchange.com howdoi $* }; hdroid'
alias hfr='function hfr(){ HOWDOI_URL=french.stackexchange.com howdoi $* }; hfr'
alias hru='function hru(){ HOWDOI_URL=russian.stackexchange.com howdoi $* }; hru'
alias hlance='function hlance(){ HOWDOI_URL=freelancing.stackexchange.com howdoi $* }; hlance'
alias hmeta='function hmeta(){ HOWDOI_URL=meta.stackexchange.com howdoi $* }; hmeta'
alias hsapps='function hsapps(){ HOWDOI_URL=stackapps.com howdoi $* }; hsapps'
alias hwrite='function hwrite(){ HOWDOI_URL=writing.stackexchange.com howdoi $* }; hwrite'
alias hmech='function hmech(){ HOWDOI_URL=mechanics.stackexchange.com howdoi $* }; hmech'
alias hmus='function hmus(){ HOWDOI_URL=music.stackexchange.com howdoi $* }; hmus'
alias hout='function hout(){ HOWDOI_URL=outdoors.stackexchange.com howdoi $* }; hout'
alias hspace='function hspace(){ HOWDOI_URL=space.stackexchange.com howdoi $* }; hspace'
alias hcgi='function hcgi(){ HOWDOI_URL=computergraphics.stackexchange.com howdoi $* }; hcgi'
alias hblend='function hblend(){ HOWDOI_URL=blender.stackexchange.com howdoi $* }; hblend'
alias hiot='function hiot(){ HOWDOI_URL=iot.stackexchange.com howdoi $* }; hiot'
alias hlang='function hlang(){ HOWDOI_URL=languagelearning.stackexchange.com howdoi $* }; hlang'
alias hai='function hai(){ HOWDOI_URL=ai.stackexchange.com howdoi $* }; hai'
alias hoss='function hoss(){ HOWDOI_URL=opensource.stackexchange.com howdoi $* }; hoss'
alias hhack='function hhack(){ HOWDOI_URL=lifehacks.stackexchange.com howdoi $* }; hhack'
alias hvim='function hvim(){ HOWDOI_URL=vi.stackexchange.com howdoi $* }; hvim'
alias hemacs='function hemacs(){ HOWDOI_URL=emacs.stackexchange.com howdoi $* }; hemacs'
alias hebooks='function hebooks(){ HOWDOI_URL=ebooks.stackexchange.com howdoi $* }; hebooks'
alias hsdg='function hsdg(){ HOWDOI_URL=sustainability.stackexchange.com howdoi $* }; hsdg'
alias hhwrec='function hhwrec(){ HOWDOI_URL=hardwarerecs.stackexchange.com howdoi $* }; hhwrec'
alias helem='function helem(){ HOWDOI_URL=elementaryos.stackexchange.com howdoi $* }; helem'
alias hgenai='function hgenai(){ HOWDOI_URL=genai.stackexchange.com howdoi $* }; hgenai'

# Invoke auto update
sudo pacman -Syu && yay -a && sudo pacman -Qdtq | ifne sudo pacman -Rns - && sudo pacman -Scc --noconfirm && yay -a -Scc --noconfirm

clear

# Invoke Fastfetch
fastfetch

export EDITOR=/usr/bin/nvim

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(oh-my-posh init zsh --config "https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/misc/sametaor.omp.json")"

eval "$(zoxide init zsh)"

export GPG_TTY=$(tty)

export FZF_DEFAULT_OPTS='--color=fg:#c8d3f5,fg+:#c8d3f5,bg:#222436,bg+:#2a2e54 --color=hl:#82aaff,hl+:#86e1fc,info:#c3e88d,marker:#ffc777 --color=prompt:#ff757f,spinner:#c099ff,pointer:#c099ff,header:#828bb8 --color=border:#6c75ba,label:#9da8ee,query:#c8d3f5 --border="rounded" --border-label="FZF" --border-label-pos="0" --preview-window="border-double" --padding="1" --margin="1" --prompt=">_ " --marker=">>" --pointer="=>" --separator="─" --scrollbar="|" --layout="reverse" --info="right" --tmux left,80% --height=80%'
# zsh parameter completion for the dotnet CLI

# Values accepted (min: 1, max: 16)
# Parallel downloads will not be enabled if value is out-of-range
ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=8

# Functional aliases for easy yt-dlp usage
play_latest() {
	latest_file=$(find . -type f -ctime -1s | head -1)
	vlc --rate 1.33 "$latest_file"
}

ytf() { # List formats & prompt for which one(s) to download
	set -eux -pipefail
	which ffmpeg

	FORMATS=$(ytnpl --list-formats "$1")

	echo "$FORMATS" | grep --invert-match "(audio|video) only"
	echo ""
	
	for type in audio video
	do
		echo "$FORMATS" | grep "$type only"
		echo ""
	done

	echo "== Please copy-paste 👇 a 'format code' (or vid+aud) ☝️"
	read -r FORMAT
	ytnpl --format "$FORMAT" "$1"
	
	play_latest
}

yw() {
	cd /tmp
	ytp "$1"
	play_latest
}

yww() {
	cd /tmp
	yth "$1"
	play_latest
}

# Auto update commmands for omz plugins/themes
function zupdate (){
 plugins_path=~/.oh-my-zsh/custom/plugins/;

 if ([[ $1 == 'ls' ]]); then
        echo $(ls $plugins_path);
        return;
 fi

 if ([[ $1 == '' ]]); then
        list=$(ls $plugins_path);

        for plugin in $plugins_path*/;
        do
         result=$(cd $plugin && git pull);
         echo $plugin $result;
        done
        return;
 fi

 result=$(cd $plugins_path/$1 && git pull);
 echo $1 $result;
}

# Define 'y' function for yazi+zoxide navigation
# Add a `y` function to zsh that opens ranger either at the given directory or
# at the one zoxide suggests
y() {
  if [ "$1" != "" ]; then
    if [ -d "$1" ]; then
      yazi "$1"
    else
      yazi "$(zoxide query $1)"
    fi
  else
    yazi
  fi
    return $?
}

# Define mkdircd functional alias 
function mkdircd() {
    mkdir $1 && cd $1
}

_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

compdef _dotnet_zsh_complete dotnet

# pnpm
export PNPM_HOME="/home/sametaor/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Created by `pipx` on 2024-12-28 05:44:32
export PATH="$PATH:/home/sametaor/.local/bin"

if [ -e /home/sametaor/.nix-profile/etc/profile.d/nix.sh ]; then . /home/sametaor/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
