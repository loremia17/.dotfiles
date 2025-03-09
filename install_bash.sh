#!/usr/bin/env bash

set -e  # Exit on error
set -u  # Treat unset variables as errors
set -o pipefail  # Catch errors in pipelines

#############################
## 1) Update & Install Packages
#############################
sudo apt update
sudo apt install -y \
    tmux \
    stow \
    git \
    vim-gtk3 \
    bash-completion \
    curl \
    fonts-powerline \
    # Add more packages as needed

#############################
## 2) Install Tmux Plugin Manager (TPM)
##
##    Clones TPM into ~/.tmux/plugins/tpm
#############################
mkdir -p ~/.tmux/plugins
if [ ! -d "~/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

#############################
## 3) Install Starship (prompt)
#############################
curl -sS https://starship.rs/install.sh | sh -s -- --yes

#############################
## 4) Install Zoxide
#############################
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash -s -- --yes

#############################
## 5) Ensure .bashrc is properly set
#############################
check_and_append() {
    local line="$1"
    local file="$2"
    if ! grep -Fxq "$line" "$file"; then
        echo "$line" >> "$file"
    fi
}

# 5a) Source bash-completion
check_and_append "source /etc/profile.d/bash_completion.sh"  "$HOME/.bashrc"

# 5b) Initialize Starship in Bash
check_and_append 'eval "$(starship init bash)"' "$HOME/.bashrc"

# 5c) Initialize Zoxide in Bash
check_and_append 'eval "$(zoxide init bash)"' "$HOME/.bashrc"

#############################
## 6) Stow Your Dotfiles
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
stow bash
stow git
stow fonts

#############################
## 7) (Optional) Install Tmux Plugins Immediately
##
##    If your .tmux.conf references the plugins:
##      set -g @plugin 'tmux-plugins/tpm'
##      set -g @plugin 'tmux-plugins/tmux-yank'
##      set -g @plugin 'tmux-plugins/tmux-resurrect'
##      set -g @plugin 'tmux-plugins/tmux-continuum'
##      set -g @plugin 'catppuccin/tmux'
##      # (Catppuccin options, e.g.):
##      set -g @catppuccin_flavour "mocha"
##      run '~/.tmux/plugins/tpm/tpm'
##
##    Then we can manually install/clean them here:
#############################
~/.tmux/plugins/tpm/scripts/install_plugins.sh
~/.tmux/plugins/tpm/scripts/clean_plugins.sh

#############################
## 8) Clear & Regenerate Font Cache
#############################
fc-cache -f -v

#############################
## 9) Source .bashrc
#############################
source "$HOME/.bashrc"

echo "All done! Tmux, TPM, Starship, and Zoxide should now be set up."
