# Dnf
dnfprog="dnf"
command -v dnf5 > /dev/null && dnfprog=dnf5

alias dnfl="${dnfprog} list"                       # List packages
alias dnfli="${dnfprog} list installed"            # List installed packages
alias dnfgl="${dnfprog} grouplist"                 # List package groups
alias dnfmc="${dnfprog} makecache"                 # Generate metadata cache
alias dnfp="${dnfprog} info"                       # Show package information
alias dnfs="${dnfprog} search"                     # Search package
alias dnfu="sudo ${dnfprog} upgrade"               # Upgrade package
alias dnfi="sudo ${dnfprog} install"               # Install package
alias dnfgi="sudo ${dnfprog} groupinstall"         # Install package group
alias dnfr="sudo ${dnfprog} remove"                # Remove package
alias dnfgr="sudo ${dnfprog} groupremove"          # Remove package group
alias dnfc="sudo ${dnfprog} clean all"             # Clean cache

# Yum
alias yums="yum search"                       # search package
alias yump="yum info"                         # show package info
alias yuml="yum list"                         # list packages
alias yumgl="yum grouplist"                   # list package groups
alias yumli="yum list installed"              # print all installed packages
alias yumc="yum makecache"                   # rebuilds the yum package list
alias yumu="sudo yum update"                  # upgrade packages
alias yumi="sudo yum install"                 # install package
alias yumgi="sudo yum groupinstall"           # install package group
alias yumr="sudo yum remove"                  # remove package
alias yumgr="sudo yum groupremove"            # remove pagage group
alias yumrl="sudo yum remove --remove-leaves" # remove package and leaves
alias yumc="sudo yum clean all"               # clean cache