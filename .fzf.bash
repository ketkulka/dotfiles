# Setup fzf
# ---------
if [[ ! "$PATH" == */users/ketkulka/.fzf/bin* ]]; then
  export PATH="$PATH:/users/ketkulka/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/users/ketkulka/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/users/ketkulka/.fzf/shell/key-bindings.bash"

