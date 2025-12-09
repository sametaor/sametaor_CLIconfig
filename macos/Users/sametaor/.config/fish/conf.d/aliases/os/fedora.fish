# Set dnfprog once at shell start
set -g dnfprog dnf
if type -q dnf5
    set -g dnfprog dnf5
end

abbr -a dnfl '$dnfprog list'
abbr -a dnfli '$dnfprog list installed'
abbr -a dnfgl '$dnfprog grouplist'
abbr -a dnfmc '$dnfprog makecache'
abbr -a dnfp '$dnfprog info'
abbr -a dnfs '$dnfprog search'
abbr -a dnfu "sudo $dnfprog upgrade"
abbr -a dnfi "sudo $dnfprog install"
abbr -a dnfgi "sudo $dnfprog groupinstall"
abbr -a dnfr "sudo $dnfprog remove"
abbr -a dnfgr "sudo $dnfprog groupremove"
abbr -a dnfc "sudo $dnfprog clean all"
abbr -a yums 'yum search'
abbr -a yump 'yum info'
abbr -a yuml 'yum list'
abbr -a yumgl 'yum grouplist'
abbr -a yumli 'yum list installed'
abbr -a yumc 'yum makecache'
abbr -a yumu 'sudo yum update'
abbr -a yumi 'sudo yum install'
abbr -a yumgi 'sudo yum groupinstall'
abbr -a yumr 'sudo yum remove'
abbr -a yumgr 'sudo yum groupremove'
abbr -a yumrl 'sudo yum remove --remove-leaves'
abbr -a yumc 'sudo yum clean all'