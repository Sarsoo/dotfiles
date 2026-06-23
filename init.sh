# /usr/bin/bash
set -x

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

############
# BashRC
############

rm $HOME/.bashrc
ln -s $SCRIPT_DIR/.bashrc $HOME/.bashrc

############
# ZshRC
############

rm $HOME/.zshrc
ln -s $SCRIPT_DIR/.zshrc $HOME/.zshrc

############
# SaRC
############

rm $HOME/.sarc
ln -s $SCRIPT_DIR/.sarc $HOME/.sarc

############
# profile
############

rm $HOME/.profile
ln -s $SCRIPT_DIR/.profile $HOME/.profile

############
# zprofile
############

rm $HOME/.zprofile
ln -s $SCRIPT_DIR/.zprofile $HOME/.zprofile

############
# zprofile
############

rm $HOME/.zshenv
ln -s $SCRIPT_DIR/.zshenv $HOME/.zshenv

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

if [ -e "$HOME/.config/starship.toml" ]; then
    rm $HOME/.config/starship.toml
fi
ln -s $SCRIPT_DIR/starship/starship.toml $HOME/.config/starship.toml

############
#   VIM
############

if [ -e "$HOME/.vimrc" ]; then
    rm $HOME/.vimrc
fi
ln -s $SCRIPT_DIR/vim/.vimrc $HOME/.vimrc

if [ ! -d "$HOME/.vim" ]; then
    # Directory does not exist, so create it
    mkdir "$HOME/.vim"
fi
if [ -e "$HOME/.vim/plugins.vim" ]; then
    rm $HOME/.vim/plugins.vim
fi
if [ ! -d "$HOME/.vim/bundle" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
ln -s $SCRIPT_DIR/vim/plugins.vim $HOME/.vim/plugins.vim
vim +PluginInstall +qall

############
#  RANGER
############

if [ -d "$HOME/.config/ranger" ]; then
    rm -rf $HOME/.config/ranger
fi
ln -s $SCRIPT_DIR/ranger $HOME/.config/ranger

############
# ALACRITTY
############

if [ -d "$HOME/.config/alacritty" ]; then
    rm -rf $HOME/.config/alacritty
fi
ln -s $SCRIPT_DIR/alacritty $HOME/.config/alacritty

############
#  HALLOY
############

if [ -d "$HOME/.var/app/org.squidowl.halloy/config/halloy" ]; then
    rm -rf $HOME/.var/app/org.squidowl.halloy/config/halloy
fi
ln -s $SCRIPT_DIR/halloy $HOME/.var/app/org.squidowl.halloy/config/halloy

############
#  ZED
############

if [ ! -d "$HOME/.config/zed" ]; then
    mkdir $HOME/.config/zed
fi
if [ -e "$HOME/.config/zed/settings.json" ]; then
    rm $HOME/.config/zed/settings.json
fi
if [ -e "$HOME/.config/zed/keymap.json" ]; then
    rm $HOME/.config/zed/keymap.json
fi
if [ -e "$HOME/.config/zed/tasks.json" ]; then
    rm $HOME/.config/zed/tasks.json
fi
ln -s $SCRIPT_DIR/zed/settings.json $HOME/.config/zed/settings.json
ln -s $SCRIPT_DIR/zed/keymap.json $HOME/.config/zed/keymap.json
ln -s $SCRIPT_DIR/zed/tasks.json $HOME/.config/zed/tasks.json

############
#  VSCODE
############

case $machine in

    Mac)
        if [ -e "$HOME/Library/Application Support/Code/User/settings.json" ]; then
            rm "$HOME/Library/Application Support/Code/User/settings.json"
        fi
        ln -s $SCRIPT_DIR/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
    ;;

    Linux)
        if [ -e "$HOME/.config/Code/User/settings.json" ]; then
            rm $HOME/.config/Code/User/settings.json
        fi
        ln -s $SCRIPT_DIR/vscode/settings.json "$HOME/.config/Code/User/settings.json"
    ;;

esac

############
#  HTOP
############

if [ ! -d "$HOME/.config/htop" ]; then
    mkdir $HOME/.config/htop
fi
if [ -e "$HOME/.config/htop/htoprc" ]; then
    rm $HOME/.config/htop/htoprc
fi
ln -s $SCRIPT_DIR/htop/htoprc $HOME/.config/htop/htoprc

############
#  LINEAR MOUSE
############

if [ -d "$HOME/.config/linearmouse" ]; then
    rm -rf $HOME/.config/linearmouse
fi
ln -s $SCRIPT_DIR/linearmouse $HOME/.config/linearmouse

############
#  npm
############

if [ -e "$HOME/.npmrc" ]; then
    rm $HOME/.npmrc
fi
ln -s $SCRIPT_DIR/npm/npmrc $HOME/.npmrc

############
#   K9S
############

case $machine in

    Mac)
        if [ -e "$HOME/Library/Application Support/k9s/aliases.yaml" ]; then
            rm "$HOME/Library/Application Support/k9s/aliases.yaml"
        fi
        ln -s $SCRIPT_DIR/k9s/aliases.yaml "$HOME/Library/Application Support/k9s/aliases.yaml"

        if [ -e "$HOME/Library/Application Support/k9s/config.yaml" ]; then
            rm "$HOME/Library/Application Support/k9s/config.yaml"
        fi
        ln -s $SCRIPT_DIR/k9s/config.yaml "$HOME/Library/Application Support/k9s/config.yaml"

        if [ -e "$HOME/Library/Application Support/k9s/views.yaml" ]; then
            rm "$HOME/Library/Application Support/k9s/views.yaml"
        fi
        ln -s $SCRIPT_DIR/k9s/config.yaml "$HOME/Library/Application Support/k9s/views.yaml"
    ;;

    Linux)
        if [ -e "$HOME/.config/k9s/aliases.yaml" ]; then
            rm "$HOME/.config/k9s/aliases.yaml"
        fi
        ln -s $SCRIPT_DIR/k9s/aliases.yaml "$HOME/.config/k9s/aliases.yaml"

        if [ -e "$HOME/.config/k9s/config.yaml" ]; then
            rm "$HOME/.config/k9s/config.yaml"
        fi
        ln -s $SCRIPT_DIR/k9s/config.yaml "$HOME/.config/k9s/config.yaml"

        if [ -e "$HOME/.config/k9s/views.yaml" ]; then
            rm "$HOME/.config/k9s/views.yaml"
        fi
        ln -s $SCRIPT_DIR/k9s/config.yaml "$HOME/.config/k9s/views.yaml"
    ;;

esac

############
#  flux9s
############

if [ -e "$HOME/.config/flux9s" ]; then
    rm -rf $HOME/.config/flux9s
fi
ln -s $SCRIPT_DIR/flux9s $HOME/.config/flux9s

############
#  flux9s
############

if [ ! -d "$HOME/.config/opencode" ]; then
    mkdir $HOME/.config/opencode
fi
if [ -e "$HOME/.config/opencode/opencode.jsonc" ]; then
    rm -rf $HOME/.config/opencode/opencode.jsonc
fi
if [ -e "$HOME/.config/opencode/tui.jsonc" ]; then
    rm -rf $HOME/.config/opencode/tui.jsonc
fi
ln -s $SCRIPT_DIR/opencode/opencode.jsonc $HOME/.config/opencode/opencode.jsonc
ln -s $SCRIPT_DIR/opencode/tui.jsonc $HOME/.config/opencode/tui.jsonc

################
#  aerospace
################

if [ -e "$HOME/.aerospace.toml" ]; then
    rm $HOME/.aerospace.toml
fi
ln -s $SCRIPT_DIR/aerospace/.aerospace.toml $HOME/.aerospace.toml

################
#   tmux
################

if [ -e "$HOME/.tmux.conf" ]; then
    rm $HOME/.tmux.conf
fi
ln -s $SCRIPT_DIR/tmux/tmux.conf $HOME/.tmux.conf
