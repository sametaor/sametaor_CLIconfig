export alias dbl = docker build
export alias dcin = docker container inspect
export alias dcls = docker container ls
export alias dclsa = docker container ls -a
export alias dib = docker image build
export alias dii = docker image inspect
export alias dils = docker image ls
export alias dipu = docker image push
export alias dipru = docker image prune -a
export alias dirm = docker image rm
export alias dit = docker image tag
export alias dlo = docker container logs
export alias dnc = docker network create
export alias dncn = docker network connect
export alias dndcn = docker network disconnect
export alias dni = docker network inspect
export alias dnls = docker network ls
export alias dnrm = docker network rm
export alias dpo = docker container port
export alias dps = docker ps
export alias dpsa = docker ps -a
export alias dpu = docker pull
export alias dr = docker container run
export alias drm! = docker container rm -f
export alias dst = docker container start
export alias drs = docker container restart

# These use subcommands or parameter expansion in ZSH, 
# so need to be explicitly written as Nushell functions:

export def dsta [] {
  docker stop (docker ps -q)
}
export alias dstp = docker container stop
export alias dsts = docker stats
export alias dtop = docker top
export alias dvi = docker volume inspect
export alias dvprune = docker volume prune
export alias dxc = docker container exec
export alias drit = docker run -it
export alias deit = docker exec -it
export alias dlog = docker logs

# Parameter expansion needs a function in Nushell:
export def dip [...args] {
  docker inspect --format "{{ .NetworkSettings.IPAddress }}" $args
}
export def dstop-all [] {
  docker stop (docker ps -q -f "status=running")
}
export alias drm = docker rm
export def dvls [...args] {
  docker volume ls $args
}