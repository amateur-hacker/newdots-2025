#  _____    _
# |__  /___| |__
#   / // __| '_ \
#  / /_\__ \ | | |
# /____|___/_| |_|
#

# Source shell aliases, envvars and functions
for cfg in aliases envvars.interactive functions; do
  file="$XDG_CONFIG_HOME/shell/$cfg"
  [ -f "$file" ] && source "$file"
done

# Exit early if not running interactively
[[ $- != *i* ]] && return

# Refresh the prompt cleanly
__refresh_prompt() {
    zle -I
    zle reset-prompt
}
zle -N __refresh_prompt

# cd to folder when quitting yazi
__yazi_cd_widget() {
  yazi_cd "$@"
  __refresh_prompt
}

# Completion setup
autoload -Uz compinit
zmodload zsh/complist
autoload -U colors && colors
compinit
_comp_options+=(globdots)

zstyle ':completion:*' menu select                    # tab opens cmp menu
zstyle ':completion:*' special-dirs true              # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # colorize cmp menu
zstyle ':completion:*' squeeze-slashes false          # explicit disable to allow /*/ expansion

# Completion bindings
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[[Z' reverse-menu-complete

# History configuration
HISTSIZE=20000
SAVEHIST=$HISTSIZE
HISTFILE=$XDG_DATA_HOME/zsh/zsh_history
HISTDUP=erase

# Shell options
setopt appendhistory         # Append history to the file, don't overwrite
setopt sharehistory          # Share history across sessions
setopt hist_ignore_space     # Ignore commands starting with a space
setopt hist_ignore_dups      # Don't record duplicate of last command
setopt hist_save_no_dups     # Don't save dupes to history file
setopt hist_ignore_all_dups  # Erase older dupes in history list
setopt hist_find_no_dups     # Don't find dupes while searcing history
setopt interactive_comments  # allow comments in shell
setopt globdots              # include dotfiles
setopt extended_glob         # match ~ # ^
setopt auto_param_slash      # when a dir is completed, add a / instead of a trailing space
setopt autocd                # type a dir to cd
unsetopt prompt_sp           # don't autoclean blanklines
stty stop undef              # disable accidental ctrl s

# prevd/nextd setup
setopt auto_pushd            # every 'cd' adds to the dir stack
setopt pushd_ignore_dups     # don't add the same dir twice in a row
setopt pushdminus            # use `pushd -1` for back, like Fish

prevd() {
  pushd -1 > /dev/null
}
__prevd_widget() {
  prevd
  __refresh_prompt
}
nextd() {
  pushd +0 > /dev/null
}
__nextd_widget() {
  nextd
  __refresh_prompt
}

# vi mode
bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q'
preexec() { echo -ne '\e[6 q' ;}

# Custom keybindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^R' fzf-history-widget
bindkey -M viins '^K' history-search-backward
bindkey -M viins '^J' history-search-forward
autoload edit-command-line && zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -v '^?' backward-delete-char
zle -N __yazi_cd_widget && bindkey '^y' __yazi_cd_widget
zle -N __prevd_widget && bindkey '^[[1;5D' __prevd_widget
zle -N __nextd_widget && bindkey '^[[1;5C' __nextd_widget

# Peekr setup
bindkey -r ';'

__peekr() {
  local file="$HOME/.config/shell/peekr"
  [[ -f $file ]] && "$file" "$@"
}
__peekr_source() {
  local file="$HOME/.config/shell/peekr"
  [[ -f $file ]] && source "$file" "$@"
}

peekr_generate_paths()         { __peekr generate_paths}
peekr_search_configs()         { __peekr search_configs }
peekr_search_scripts()         { __peekr search_scripts }
peekr_search_files_cwd()       { __peekr search_files_cwd }
peekr_search_nested_files_cwd(){ __peekr search_nested_files_cwd }
peekr_select_dir_cwd() {
  __peekr_source select_dir_cwd
  __refresh_prompt
}
peekr_select_nested_dir_cwd() {
  __peekr_source select_nested_dir_cwd
  __refresh_prompt
}

for fn in \
  peekr_search_configs \
  peekr_search_scripts \
  peekr_search_files_cwd \
  peekr_search_nested_files_cwd \
  peekr_select_dir_cwd \
  peekr_select_nested_dir_cwd; do
  zle -N "$fn"
done

__peekr_semicolon_prefix() {
  if [[ -z $BUFFER ]]; then
    read -k next
    case "$next" in
      c) zle peekr_search_configs ;;
      s) zle peekr_search_scripts ;;
      f) zle peekr_search_files_cwd ;;
      F) zle peekr_search_nested_files_cwd ;;
      d) zle peekr_select_dir_cwd ;;
      D) zle peekr_select_nested_dir_cwd ;;
      *) LBUFFER+=";$next" ;;
    esac
  else
    LBUFFER+=';'
  fi
} # Prefix handler for ';' when buffer is empty

zle -N peekr_semicolon_prefix __peekr_semicolon_prefix
bindkey ';' peekr_semicolon_prefix

# Zinit plugin manager setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Load Zinit plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# System info on launch
fastfetch

# Shell integrations
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= eval "$(fzf --zsh)"
