#  _____ _     _
# |  ___(_)___| |__
# | |_  | / __| '_ \
# |  _| | \__ \ | | |
# |_|   |_|___/_| |_|
#

# Disable default fish greeting
set fish_greeting

# Setup vi mode keybindings and configure defaults
function fish_user_key_bindings
    fish_vi_key_bindings
    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind p fish_clipboard_paste
    bind -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
    bind -M insert -m default jk 'commandline -f repaint'
end

# Support for !! and !$
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -M insert ! __history_previous_command
    bind -M insert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

function yazi_cd
    bass "source $HOME/.config/yazi/yazi-cd '\$@'"
end

# Utility to run peekr commands
function peekr
    bass "$HOME/.config/shell/peekr $argv"
end

function peekr_source
    bass "source $HOME/.config/shell/peekr $argv"
end

# Custom keybindings
set -l custom_binds \
    \;h prevd \
    \;l nextd \
    \;y yazi_cd \
    \;c "peekr search_configs" \
    \;s "peekr search_scripts" \
    \;f "peekr search_files_cwd" \
    \;F "peekr search_nested_files_cwd" \
    \;d "peekr_source select_dir_cwd" \
    \;D "peekr_source select_nested_dir_cwd"

for i in (seq 1 2 (count $custom_binds))
    set -l key $custom_binds[$i]
    set -l func $custom_binds[(math $i + 1)]
    bind -M insert $key "$func; commandline -f repaint"
end

# Load shell globals
function load_shell_globals
    set -l file "$XDG_CONFIG_HOME/shell/load-shell-globals"
    test -f $file && bass "source $file"
end
load_shell_globals

# System info on launch if interactive
if status is-interactive
    fastfetch
end

# Shell integrations
starship init fish | source
zoxide init --cmd cd fish | source
fzf --fish | FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= source
