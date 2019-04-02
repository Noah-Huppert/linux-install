# Allow user to search through command history

# Save history
export HISTSIZE=10000  # history size
export SAVEHIST=10000  # history size after logout
export HISTFILE=~/.zhistory
setopt INC_APPEND_HISTORY  # Append into history
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY  # Save timestamp for history entries

# Search command history with ctrl+r
bindkey "^R" history-incremental-search-backward

