
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias ytmpv='mpv --hwdec=auto --ytdl-format="bestvideo+bestaudio/best"'
alias ytmpvqhd='mpv --hwdec=auto --ytdl-format="bestvideo[height<=?1800]+bestaudio/best"'
alias ytmpvhd='mpv --hwdec=auto --ytdl-format="bestvideo[height<=?1080]+bestaudio/best"'

alias gitlog='git log --graph --all --oneline'

alias rdoc='cargo doc --open'
alias cdicloud='cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs'
alias cdans='cd ~/dev/infra/ansible'

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

PS1='%F{green}%n@%m%f %1/ %F{red}%#%f '
export PATH="/opt/homebrew/opt/python@3.10/bin:$HOME/lab/scripts:$PATH"

autoload -Uz compinit
compinit
_comp_options+=(globdots)

source /Users/andy/.docker/init-zsh.sh || true # Added by Docker Desktop

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"