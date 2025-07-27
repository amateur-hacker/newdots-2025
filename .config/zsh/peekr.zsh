# ~/.config/zsh/peekr.zsh

# --- Peekr Keychord Prefix Bindings ---

# Wrapper commands
peekr_search_configs()          { ~/.config/shell/peekr search_configs }
peekr_search_scripts()          { ~/.config/shell/peekr search_scripts }
peekr_search_files_cwd()        { ~/.config/shell/peekr search_files_cwd }
peekr_search_nested_files_cwd() { ~/.config/shell/peekr search_nested_files_cwd }
peekr_select_dir_cwd()          { ~/.config/shell/peekr select_dir_cwd }
peekr_select_nested_dir_cwd()   { ~/.config/shell/peekr select_nested_dir_cwd }

# Register as ZLE widgets
for fn in \
  peekr_search_configs peekr_search_scripts peekr_search_files_cwd \
  peekr_search_nested_files_cwd peekr_select_dir_cwd peekr_select_nested_dir_cwd; do
  zle -N "$fn"
done

# Prefix-mode state
peekr_prefix_mode=0

peekr_reset_hook() {
  peekr_prefix_mode=0
  zle -N self-insert self-insert
}

peekr_chord_dispatch() {
  if (( peekr_prefix_mode )); then
    peekr_prefix_mode=0
    case $KEYS in
      c) peekr_search_configs ;;
      s) peekr_search_scripts ;;
      f) peekr_search_files_cwd ;;
      F) peekr_search_nested_files_cwd ;;
      d) peekr_select_dir_cwd ;;
      D) peekr_select_nested_dir_cwd ;;
      *) zle self-insert ;;
    esac
  else
    zle self-insert
  fi
  zle -N self-insert self-insert
  zle -N zle-line-pre-redraw
}

peekr_prefix_widget() {
  if [[ -z "$LBUFFER" ]]; then
    LBUFFER+=';'
    return
  fi

  peekr_prefix_mode=1
  zle -I
  zle -N self-insert peekr_chord_dispatch
  zle -N zle-line-pre-redraw peekr_reset_hook
  zle -R

  {
    sleep 0.3
    if (( peekr_prefix_mode )); then
      peekr_prefix_mode=0
      zle -U ";"
      zle -N self-insert self-insert
      zle -N zle-line-pre-redraw
    fi
  } &
}
zle -N peekr_prefix_widget
bindkey ';' peekr_prefix_widget
