# install packages
sudo apt install
    stow \
    git \
    vim-gtk3 \
    tmux -y

# install starship
curl -sS https://starship.rs/install.sh | sh

# install zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# stow dotfiles
stow starship
stow vim
stow tmux
stow bash 
stow git
stow kitty

# source zsh
source ~/.bashrc
