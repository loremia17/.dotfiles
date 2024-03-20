# Setup fzf
# ---------
if [[ ! "$PATH" == */home/loremia_wsl/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/loremia_wsl/.fzf/bin"
fi

eval "$(fzf --zsh)"
