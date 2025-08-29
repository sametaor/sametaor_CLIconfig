
# --- PATH logic (ported from .zshenv/.zprofile) ---

# Custom user bin
set -gx PATH $HOME/.local/bin $PATH
# pipx
set -gx PATH $HOME/.local/pipx/bin $PATH
# pnpm
set -gx PATH $HOME/.local/share/pnpm $PATH
# pyenv
set -gx PATH $HOME/.pyenv/bin $PATH
# cargo
set -gx PATH $HOME/.cargo/bin $PATH
# Perl5
set -gx PATH $HOME/perl5/bin $PATH
# Go
set -gx PATH $HOME/go/bin $PATH
# Ruby gems
set -gx PATH $HOME/.gem/ruby/*/bin $PATH
# Nix (if present)
if test -d /nix/var/nix/profiles/default/bin
	set -gx PATH /nix/var/nix/profiles/default/bin $PATH
end
# Homebrew (if present)
if test -d /home/linuxbrew/.linuxbrew/bin
	set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH
end
# MacPorts (if present)
if test -d /opt/local/bin
	set -gx PATH /opt/local/bin $PATH
end

