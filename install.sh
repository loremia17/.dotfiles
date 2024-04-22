# install packages
sudo apt install zsh \
    stow \
    git \
    tmux -y

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells
# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# install kitty and set as default terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    dest=~/.local/stow
cd ~/.local/stow
stow -v kitty.app
sudo update-alternatives --config x-terminal-emulator
gsetting set org.gnome.desktop.default-applications.terminal exec 'kitty'

# go home
cd ~/

# starship
curl -sS https://starship.rs/install.sh | sh

# zsh plugins
cd ~/.dotfiles/zsh/.zsh/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git

# stow dotfiles
stow starship
stow vim
stow tmux
stow zsh

#zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

#fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# source zsh
source ~/.zshrc
