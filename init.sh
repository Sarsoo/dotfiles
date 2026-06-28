# /usr/bin/bash
# set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    MSYS_NT*)   machine=MSys;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "Init-ing [${machine}]"

function link_file(){
  local source="${SCRIPT_DIR}/${1}"
  local destination="${HOME}/${2}"

  mkdir -p "$(dirname "${destination}")"

  if [ -d "${destination}" ]; then

    echo "removing dir (${destination})"
    rm -rf "${destination}"

  elif [ -f "${destination}" ]; then

    echo "removing file (${destination})"
    rm "${destination}"

  elif [ -L "${destination}" ]; then

    echo "removing link (${destination})"
    rm "${destination}"

  fi

  echo "linking (${source}) -> (${destination})"
  ln -s "${source}" "${destination}"
}

mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/.config/systemd/user"

############
# BashRC
############
link_file ".bashrc" ".bashrc"

############
# ZshRC
############
link_file ".zshrc" ".zshrc"

############
# SaRC
############
link_file ".sarc" ".sarc"

############
# profile
############
link_file ".profile" ".profile"

############
# zprofile
############
link_file ".zprofile" ".zprofile"
link_file ".zshenv" ".zshenv"

############
# SSH
############

# # Check if the directory does not exist
# if [ ! -d "$HOME/.ssh" ]; then
#     # Directory does not exist, so create it
#     mkdir "$HOME/.ssh"
#     chmod 700 "$HOME/.ssh"
# fi

# if [ -e "$HOME/.ssh/config" ]; then
#     rm $HOME/.ssh/config
# fi
# ln -s $SCRIPT_DIR/ssh_config $HOME/.ssh/config
# chmod 600 "$HOME/.ssh/config"

############
# Starship
############
link_file "starship/starship.toml" ".config/starship.toml"

############
#   VIM
############
link_file "vim/.vimrc" ".vimrc"
link_file "vim/plugins.vim" ".vim/plugins.vim"

if [ ! -d "$HOME/.vim" ]; then
    # Directory does not exist, so create it
    mkdir "$HOME/.vim"
fi
if [ ! -d "$HOME/.vim/bundle" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

############
#  RANGER
############
link_file "ranger" ".config/ranger"

############
# ALACRITTY
############
link_file "alacritty" ".config/alacritty"

############
#  HALLOY
############
link_file "halloy" ".var/app/org.squidowl.halloy/config/halloy"

############
#  ZED
############
link_file "zed/settings.json" ".config/zed/settings.json"
link_file "zed/keymap.json" ".config/zed/keymap.json"
link_file "zed/tasks.json" ".config/zed/tasks.json"

############
#  VSCODE
############

case $machine in

    Mac)
        link_file "vscode/settings.json" "Library/Application Support/Code/User/settings.json"
    ;;

    Linux)
        link_file "vscode/settings.json" ".config/Code/User/settings.json"
    ;;

esac

############
#  HTOP
############
link_file "htop/htoprc" ".config/htop/htoprc"

############
#  LINEAR MOUSE
############
link_file "linearmouse" ".config/linearmouse"

############
#  npm
############
link_file "npm/npmrc" ".npmrc"

############
#   K9S
############

case $machine in

    Mac)
        link_file "k9s/aliases.yaml" "Library/Application Support/k9s/aliases.yaml"
        link_file "k9s/config.yaml" "Library/Application Support/k9s/config.yaml"
        link_file "k9s/views.yaml" "Library/Application Support/k9s/views.yaml"
    ;;

    Linux)
        link_file "k9s/aliases.yaml" ".config/k9s/aliases.yaml"
        link_file "k9s/config.yaml" ".config/k9s/config.yaml"
        link_file "k9s/views.yaml" ".config/k9s/views.yaml"
    ;;

esac

############
#  flux9s
############
link_file "flux9s" ".config/flux9s"

############
# opencode
############
link_file "opencode/opencode.jsonc" ".config/opencode/opencode.jsonc"
link_file "opencode/tui.jsonc" ".config/opencode/tui.jsonc"

################
#  aerospace
################
link_file "aerospace/.aerospace.toml" ".aerospace.toml"

################
#   tmux
################
link_file "tmux/tmux.conf" ".tmux.conf"

################
#   sway
################
link_file "sway/config" ".config/sway/config"
link_file "sway/keybindings" ".config/sway/keybindings"
link_file "sway/mac" ".config/sway/mac"

# swaybar
link_file "sway/status.sh" ".config/sway/status.sh"
link_file "sway/swaybar" ".config/sway/swaybar"
# waybar
link_file "sway/waybar" ".config/sway/waybar"

################
#   waybar
################
link_file "waybar/config.jsonc" ".config/waybar/config.jsonc"

################
#   rofi
################
link_file "rofi/config.rasi" ".config/rofi/config.rasi"
link_file "rofi/scripts/slaunch.sh" ".config/rofi/scripts/slaunch.sh"

link_file "niri/config.kdl" ".config/niri/config.kdl"

################
#  distrobox
################
link_file "distrobox/distrobox.conf" ".config/distrobox/distrobox.conf"
