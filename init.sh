# /usr/bin/bash
set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

############
# BashRC
############

rm $HOME/.bashrc
ln -s $SCRIPT_DIR/.bashrc $HOME/.bashrc

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