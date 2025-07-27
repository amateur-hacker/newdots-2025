#  ____            _
# | __ )  __ _ ___| |__
# |  _ \ / _` / __| '_ \
# | |_) | (_| \__ \ | | |
# |____/ \__,_|___/_| |_|
#

# Source shell aliases and envvars
for cfg in aliases envvars; do
  file="$XDG_CONFIG_HOME/shell/$cfg"
  [ -f "$file" ] && source "$file"
done

# Exit if not running interactively
[[ $- != *i* ]] && return

# Custom touch override for verbose output
touch() {
  local file
  for file in "$@"; do
    if [[ -e "$file" ]]; then
      echo "touch: updated timestamp '$file'"
    else
      echo "touch: created file '$file'"
    fi
    command touch "$file"
  done
}

# Set Vi keybindings
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# Set shell options
shopt -s autocd         # auto cd into dirs
shopt -s cdspell        # fix cd typos
shopt -s cmdhist        # join multi-line cmds
shopt -s dotglob        # include dotfiles in globs
shopt -s histappend     # append to history
shopt -s expand_aliases # allow aliases in scripts
shopt -s checkwinsize   # auto adjust terminal size
shopt -s globstar       # enable **

# Configure tab completion
bind "set completion-ignore-case on"

# Show system information on launch
fastfetch

# Shell integrations
eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"
FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= eval "$(fzf --bash)"
