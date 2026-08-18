abbr -a dbl   'docker build'
abbr -a dcin  'docker container inspect'
abbr -a dcls  'docker container ls'
abbr -a dclsa 'docker container ls -a'
abbr -a dib   'docker image build'
abbr -a dii   'docker image inspect'
abbr -a dils  'docker image ls'
abbr -a dipu  'docker image push'
abbr -a dipru 'docker image prune -a'
abbr -a dirm  'docker image rm'
abbr -a dit   'docker image tag'
abbr -a dlo   'docker container logs'
abbr -a dnc   'docker network create'
abbr -a dncn  'docker network connect'
abbr -a dndcn 'docker network disconnect'
abbr -a dni   'docker network inspect'
abbr -a dnls  'docker network ls'
abbr -a dnrm  'docker network rm'
abbr -a dpo   'docker container port'
abbr -a dps   'docker ps'
abbr -a dpsa  'docker ps -a'
abbr -a dpu   'docker pull'
abbr -a dr    'docker container run'
abbr -a drm\! 'docker container rm -f'
abbr -a dst   'docker container start'
abbr -a drs   'docker container restart'
abbr -a dstp  'docker container stop'
abbr -a dsts  'docker stats'
abbr -a dtop  'docker top'
abbr -a dvi   'docker volume inspect'
abbr -a dvprune 'docker volume prune'
abbr -a dxc   'docker container exec'
abbr -a drit  'docker run -it'
abbr -a deit  'docker exec -it'
abbr -a dlog  'docker logs'
abbr -a drm   'docker rm'
# Stop all running containers
function dsta
    docker stop (docker ps -q)
end

# Show IP addresses from docker inspect
function dip
    docker inspect --format "{{ .NetworkSettings.IPAddress }}" $argv
end

# Stop all running containers (alternate)
function dstop-all
    docker stop (docker ps -q -f 'status=running')
end

# List docker volumes (accepts arguments)
function dvls
    docker volume ls $argv
end