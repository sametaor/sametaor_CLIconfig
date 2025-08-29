# Add .dotnet/tools to PATH for global tools
set -gx PATH $PATH $HOME/.dotnet/tools
# Fish completion for dotnet (requires fish >= 3.1)
if type -q dotnet
	complete -c dotnet -a "(dotnet complete (commandline -cp))"
end
