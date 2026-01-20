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
ln -s $SCRIPT_DIR/vim/plugins.vim $HOME/.vim/plugins.vim
vim +PluginInstall +qall