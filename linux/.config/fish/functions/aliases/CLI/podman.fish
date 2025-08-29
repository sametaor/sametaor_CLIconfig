# Fish shell aliases for podman (ported from bash/zsh)
alias pbl 'podman build'
alias pcin 'podman container inspect'
alias pcls 'podman container ls'
alias pclsa 'podman container ls --all'
alias pib 'podman image build'
alias pii 'podman image inspect'
alias pils 'podman image ls'
alias pipu 'podman image push'
alias pirm 'podman image rm'
alias pit 'podman image tag'
alias plo 'podman container logs'
alias pnc 'podman network create'
alias pncn 'podman network connect'
alias pndcn 'podman network disconnect'
alias pni 'podman network inspect'
alias pnls 'podman network ls'
alias pnrm 'podman network rm'
alias ppo 'podman container port'
alias ppu 'podman pull'
alias pr 'podman container run'
alias prit 'podman container run --interactive --tty'
alias prm 'podman container rm'
function prmf
    podman container rm --force $argv
end
alias pst 'podman container start'
alias prs 'podman container restart'
function psta
    podman stop (podman ps --quiet)
end
alias pstp 'podman container stop'
alias ptop 'podman top'
alias pvi 'podman volume inspect'
alias pvls 'podman volume ls'
alias pvprune 'podman volume prune'
alias pxc 'podman container exec'
alias pxcit 'podman container exec --interactive --tty'
