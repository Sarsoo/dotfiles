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
link_file "shell/bash/bashrc" ".bashrc"

############
#   zsh
############
link_file "shell/zsh/zshrc" ".zshrc"
link_file "shell/zsh/zprofile" ".zprofile"
link_file "shell/zsh/zshenv" ".zshenv"

############
# SaRC
############
link_file ".sarc" ".sarc"

############
# profile
############
link_file ".profile" ".profile"

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
link_file "shell/util/starship/starship.toml" ".config/starship.toml"

############
#  FONTS
############
link_file "font/fonts.conf" ".config/fontconfig/fonts.conf"

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
link_file "shell/emu/alacritty" ".config/alacritty"

############
#  HALLOY
############
link_file "halloy" ".var/app/org.squidowl.halloy/config/halloy"

############
#  ZED
############
if [[ -z "${SAR_SKIP_ZED}" ]]; then
  link_file "zed/settings.json" ".config/zed/settings.json"
  link_file "zed/keymap.json" ".config/zed/keymap.json"
  link_file "zed/tasks.json" ".config/zed/tasks.json"
fi

############
#  VSCODE
############

if [[ -z "${SAR_SKIP_VSCODE}" ]]; then
  case $machine in

      Mac)
          link_file "vscode/settings.json" "Library/Application Support/Code/User/settings.json"
      ;;

      Linux)
          link_file "vscode/settings.json" ".config/Code/User/settings.json"
      ;;

  esac
fi

############
#  HTOP
############
link_file "htop/htoprc" ".config/htop/htoprc"

############
#  LINEAR MOUSE
############
link_file "mac/linearmouse" ".config/linearmouse"

############
#  npm
############
link_file "npm/npmrc" ".npmrc"

############
#   K9S
############

if [[ -z "${SAR_SKIP_K9S}" ]]; then
  case $machine in

      Mac)
          link_file "ctr/k9s/aliases.yaml" "Library/Application Support/k9s/aliases.yaml"
          link_file "ctr/k9s/config.yaml" "Library/Application Support/k9s/config.yaml"
          link_file "ctr/k9s/views.yaml" "Library/Application Support/k9s/views.yaml"
      ;;

      Linux)
          link_file "ctr/k9s/aliases.yaml" ".config/k9s/aliases.yaml"
          link_file "ctr/k9s/config.yaml" ".config/k9s/config.yaml"
          link_file "ctr/k9s/views.yaml" ".config/k9s/views.yaml"
      ;;

  esac
fi

############
#  flux9s
############
link_file "ctr/flux9s" ".config/flux9s"

############
# opencode
############
if [[ -z "${SAR_SKIP_OPENCODE}" ]]; then
  link_file "ai/opencode/opencode.jsonc" ".config/opencode/opencode.jsonc"
  link_file "ai/opencode/tui.jsonc" ".config/opencode/tui.jsonc"
fi

############
#  herdr
############
link_file "ai/herdr/config.toml" ".config/herdr/config.toml"

################
#  aerospace
################
link_file "mac/aerospace/.aerospace.toml" ".aerospace.toml"

################
#   tmux
################
link_file "tmux/tmux.conf" ".tmux.conf"

################
#   sway
################
link_file "wm/sway/config" ".config/sway/config"
link_file "wm/sway/keybindings" ".config/sway/keybindings"
link_file "wm/sway/mac" ".config/sway/mac"

# swaybar
link_file "wm/sway/status.sh" ".config/sway/status.sh"
link_file "wm/sway/swaybar" ".config/sway/swaybar"
# waybar
link_file "wm/sway/waybar" ".config/sway/waybar"

################
#   waybar
################
link_file "wm/util/waybar/config.jsonc" ".config/waybar/config.jsonc"

################
#   rofi
################
link_file "wm/util/rofi/config.rasi" ".config/rofi/config.rasi"
link_file "wm/util/rofi/scripts/slaunch.sh" ".config/rofi/scripts/slaunch.sh"

link_file "wm/niri/config.kdl" ".config/niri/config.kdl"

################
#  distrobox
################
link_file "ctr/distrobox/distrobox.conf" ".config/distrobox/distrobox.conf"
