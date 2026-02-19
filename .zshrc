alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

autoload -Uz compinit
compinit
_comp_options+=(globdots)

. "$HOME/.sarc"

eval "$(starship init zsh)"
