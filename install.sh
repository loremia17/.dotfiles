#!/usr/bin/env bash

set -e  # Exit on error
set -u  # Treat unset variables as errors
set -o pipefail  # Catch errors in pipelines

#############################
## Update & Install Packages
#############################
sudo apt update
sudo apt install -y \
    tmux \
    stow \
    git \
    vim-gtk3 \
    bash-completion \
    curl \
    # Add more packages as needed

#############################
## Install Starship (prompt)
#############################
curl -sS https://starship.rs/install.sh | sh 

#############################
## Install Zoxide
#############################
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

#############################
## Stow Your Dotfiles
##
##    Make sure you have cloned your dotfiles repo
##    and that you're in the correct folder.
#############################
# Example:
# git clone https://github.com/<your-username>/<dotfiles-repo>.git ~/dotfiles
# cd ~/dotfiles

stow starship
stow vim
stow tmux
stow git
stow fonts
rm ~/.bashrc
stow bash

#############################
## Ensure .bashrc is properly set
#############################
check_and_append() {
    local line="$1"
    local file="$2"
    if ! grep -Fxq "$line" "$file"; then
        echo "$line" >> "$file"
    fi
}
# Source bash-completion
check_and_append "source /etc/profile.d/bash_completion.sh"  "$HOME/.bashrc"
# Initialize Starship in Bash
check_and_append 'eval "$(starship init bash)"' "$HOME/.bashrc"
# Initialize Zoxide in Bash
check_and_append 'eval "$(zoxide init bash)"' "$HOME/.bashrc"

#############################
## Install Tmux Plugin Manager (TPM) and Catppuccin theme
##
##    Clones TPM into ~/.tmux/plugins/tpm
#############################
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "TPM is already installed. Skipping clone."
else
    echo "Cloning TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

if [ -d "$HOME/.tmux/plugins/catppuccin" ]; then
    echo "Catppuccin is already installed. Skipping clone."
else
    echo "Cloning Catppuccin..."
    git clone -b v2.1.2 https://github.com/catppuccin/tmux.git "$HOME/.tmux/plugins/catppuccin/tmux"
fi

#############################
##  Install Tmux Plugins Immediately
##
##    If your .tmux.conf references the plugins:
##      set -g @plugin 'tmux-plugins/tpm'
##      set -g @plugin 'tmux-plugins/tmux-yank'
##      set -g @plugin 'tmux-plugins/tmux-resurrect'
##      set -g @plugin 'tmux-plugins/tmux-continuum'
##      run '~/.tmux/plugins/tpm/tpm'
##
##    Then we can manually install/clean them here:
#############################
~/.tmux/plugins/tpm/scripts/install_plugins.sh
~/.tmux/plugins/tpm/scripts/clean_plugins.sh

#############################
## Clear & Regenerate Font Cache
#############################
fc-cache -f -v

echo "All done! Tmux, TPM, Starship, and Zoxide should now be set up."

#############################
## Source .bashrc
#############################
source $HOME/.bashrc

