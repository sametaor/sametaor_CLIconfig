# Fish shell aliases for podman (ported from bash/zsh)
abbr -a pbl 'podman build'
abbr -a pcin 'podman container inspect'
abbr -a pcls 'podman container ls'
abbr -a pclsa 'podman container ls --all'
abbr -a pib 'podman image build'
abbr -a pii 'podman image inspect'
abbr -a pils 'podman image ls'
abbr -a pipu 'podman image push'
abbr -a pirm 'podman image rm'
abbr -a pit 'podman image tag'
abbr -a plo 'podman container logs'
abbr -a pnc 'podman network create'
abbr -a pncn 'podman network connect'
abbr -a pndcn 'podman network disconnect'
abbr -a pni 'podman network inspect'
abbr -a pnls 'podman network ls'
abbr -a pnrm 'podman network rm'
abbr -a ppo 'podman container port'
abbr -a ppu 'podman pull'
abbr -a pr 'podman container run'
abbr -a prit 'podman container run --interactive --tty'
abbr -a prm 'podman container rm'
function prmf
    podman container rm --force $argv
end
abbr -a pst 'podman container start'
abbr -a prs 'podman container restart'
function psta
    podman stop (podman ps --quiet)
end
abbr -a pstp 'podman container stop'
abbr -a ptop 'podman top'
abbr -a pvi 'podman volume inspect'
abbr -a pvls 'podman volume ls'
abbr -a pvprune 'podman volume prune'
abbr -a pxc 'podman container exec'
abbr -a pxcit 'podman container exec --interactive --tty'
