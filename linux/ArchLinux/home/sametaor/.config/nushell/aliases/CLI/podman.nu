export alias pbl = podman build
export alias pcin = podman container inspect
export alias pcls = podman container ls
export alias pclsa = podman container ls --all
export alias pib = podman image build
export alias pii = podman image inspect
export alias pils = podman image ls
export alias pipu = podman image push
export alias pirm = podman image rm
export alias pit = podman image tag
export alias plo = podman container logs
export alias pnc = podman network create
export alias pncn = podman network connect
export alias pndcn = podman network disconnect
export alias pni = podman network inspect
export alias pnls = podman network ls
export alias pnrm = podman network rm
export alias ppo = podman container port
export alias ppu = podman pull
export alias pr = podman container run
export alias prit = podman container run --interactive --tty
export alias prm = podman container rm
export alias prm! = podman container rm --force
export alias pst = podman container start
export alias prs = podman container restart
# Function needed for subcommand substitution:
export def psta [] {
  podman stop (podman ps --quiet)
}
export alias pstp = podman container stop
export alias ptop = podman top
export alias pvi = podman volume inspect
export alias pvls = podman volume ls
export alias pvprune = podman volume prune
export alias pxc = podman container exec
export alias pxcit = podman container exec --interactive --tty
