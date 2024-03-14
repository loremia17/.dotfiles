setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# VI mode
#bindkey jj vi-cmd-mode«

# Use modern completion system
autoload -Uz compinit
compinit

# alias update="sudo apt update && sudo apt upgrade -y"
alias la="ls -lah"

# plugins
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# starship (prompt)
eval "$(starship init zsh)"

# export bin
export PATH="/home/$USER/.local/bin:$PATH"

# zoxide & fzf
eval "$(zoxide init --cmd cd zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ROS
source /opt/ros/humble/setup.zsh
