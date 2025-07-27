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
    bind --erase --preset -M visual \ev
    bind --erase --preset -M insert \ev
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

# cd to folder when quitting yazi
function yazi_cd
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end

# Custom keybindings
function peekr_dispatch_semicolon
    if test -z (commandline)
        set -l k (read -l -n 1)
        switch $k
            case c
                peekr_search_configs
            case s
                peekr_search_scripts
            case f
                peekr_search_files_cwd
            case F
                peekr_search_nested_files_cwd
            case d
                peekr_select_dir_cwd
            case D
                peekr_select_nested_dir_cwd
            case '*'
                commandline ";$k"
        end
    else
        commandline -i ';'
    end
end

bind -M insert \; "peekr_dispatch_semicolon; commandline -f repaint"
bind -M insert \cy "yazi_cd; commandline -f repaint"

# function peekr_dispatch_semicolon
#     if test -z (commandline)
#         set -l k (read -s -l -n 1)
#         switch $k
#             case c
#                 peekr_search_configs
#             case s
#                 peekr_search_scripts
#             case f
#                 peekr_search_files_cwd
#             case F
#                 peekr_search_nested_files_cwd
#             case d
#                 peekr_select_dir_cwd
#             case D
#                 peekr_select_nested_dir_cwd
#             case '*'
#                 commandline ";$k"
#         end
#     else
#         commandline -i ';'
#     end
# end
# bind -M insert \; "peekr_dispatch_semicolon; commandline -f repaint"

# set -l custom_binds \
#     \;h prevd \
#     \;l nextd \
#     \;y yazi_cd \
#     \;c peekr_search_configs \
#     \;s peekr_search_scripts \
#     \;f peekr_search_files_cwd \
#     \;F peekr_search_nested_files_cwd \
#     \;d peekr_select_dir_cwd \
#     \;D peekr_select_nested_dir_cwd
#
# for i in (seq 1 2 (count $custom_binds))
#     set -l key $custom_binds[$i]
#     set -l func $custom_binds[(math $i + 1)]
#     bind -M insert $key "$func; commandline -f repaint"
# end

# set -l peekr_binds \
#     \;c peekr_search_configs \
#     \;s peekr_search_scripts \
#     \;f peekr_search_files_cwd \
#     \;F peekr_search_nested_files_cwd \
#     \;d peekr_select_dir_cwd \
#     \;D peekr_select_nested_dir_cwd
#
# for i in (seq 1 2 (count $peekr_binds))
#     set -l key $peekr_binds[$i]
#     set -l func $peekr_binds[(math $i + 1)]
#     set -l wrapper "{$func}_wrapper"
#
#     eval "
#     function $wrapper
#         if test -z (commandline)
#             $func
#         else
#             commandline -i '$key'
#         end
#     end
#     "
#
#     bind -M insert $key "$wrapper; commandline -f repaint"
# end

# System info on launch if interactive
if status is-interactive
    fastfetch
end

# Shell integrations
starship init fish | source
zoxide init --cmd cd fish | source
fzf --fish | FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= source
