unsetopt menu_complete
unsetopt flowcontrol

setopt prompt_subst
setopt globdots
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt no_list_ambiguous


# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# export bin
export PATH="/home/$USER/.local/bin:$PATH"
export ZSHPLUG="$HOME/.zsh"

# VI mode
#bindkey jj vi-cmd-mode«

# Use modern completion system
# autoload -U compinit 
# compinit

# alias update="sudo apt update && sudo apt upgrade -y"
alias lla="ls -lah"
alias la="ls -a"

# plugins
source $ZSHPLUG/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSHPLUG/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZSHPLUG/catppuccin_mocha-zsh-syntax-highlighting.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# starship (prompt)
eval "$(starship init zsh)"

# zoxide & fzf
eval "$(zoxide init --cmd cd zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# ROS
source /opt/ros/humble/setup.zsh
