#  _____ _     _
# |  ___(_)___| |__
# | |_  | / __| '_ \
# |  _| | \__ \ | | |
# |_|   |_|___/_| |_|
#

# My fish config. Not much to see here; just some pretty standard stuff.

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.local/bin/my-scripts $HOME/.bun/bin $HOME/.cache/.bun/bin $fish_user_paths

### EXPORT ###
set fish_greeting # Supresses fish's intro message
set TERM xterm-256color # Sets the terminal type
# set EDITOR "emacsclient -t -a ''"                 # $EDITOR use Emacs in terminal
# set VISUAL "emacsclient -c -a emacs"              # $VISUAL use Emacs in GUI mode
set -x EDITOR nvim
set -x VISUAL neovide
set -x TERMINAL wezterm
set -x BROWSER zen-browser
set -x FZF_DEFAULT_OPTS "--exact --height 40% --layout=reverse --border --cycle --preview='$HOME/.local/bin/my-scripts/fzf-preview {}'"
set -x ATAC_MAIN_DIR "$HOME/.local/share/atac"
set -x NODE_OPTIONS --no-warnings
set -x BAT_THEME "Catppuccin Mocha"
set -x FULLNAME (getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1)
set -x GROQ_API_KEY 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
set -x STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -x MANPAGER "nvim +Man!"
set -x ELECTRON_OZONE_PLATFORM_HINT wayland

### SET MANPAGER
# function man
#     command man $argv[1..-1] | col -bx | bat -l man -p
# end

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
    # fish_default_key_bindings
    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind p fish_clipboard_paste
    fish_vi_key_bindings
end

### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### SPARK ###
set -g spark_version 1.0.0

complete -xc spark -n __fish_use_subcommand -a --help -d "Show usage help"
complete -xc spark -n __fish_use_subcommand -a --version -d "$spark_version"
complete -xc spark -n __fish_use_subcommand -a --min -d "Minimum range value"
complete -xc spark -n __fish_use_subcommand -a --max -d "Maximum range value"

function spark -d "sparkline generator"
    if isatty
        switch "$argv"
            case {,-}-v{ersion,}
                echo "spark version $spark_version"
            case {,-}-h{elp,}
                echo "usage: spark [--min=<n> --max=<n>] <numbers...>  Draw sparklines"
                echo "examples:"
                echo "       spark 1 2 3 4"
                echo "       seq 100 | sort -R | spark"
                echo "       awk \\\$0=length spark.fish | spark"
            case \*
                echo $argv | spark $argv
        end
        return
    end

    command awk -v FS="[[:space:],]*" -v argv="$argv" '
        BEGIN {
            min = match(argv, /--min=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
            max = match(argv, /--max=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
        }
        {
            for (i = j = 1; i <= NF; i++) {
                if ($i ~ /^--/) continue
                if ($i !~ /^-?[0-9]/) data[count + j++] = ""
                else {
                    v = data[count + j++] = int($i)
                    if (max == "" && min == "") max = min = v
                    if (max < v) max = v
                    if (min > v ) min = v
                }
            }
            count += j - 1
        }
        END {
            n = split(min == max && max ? "▅ ▅" : "▁ ▂ ▃ ▄ ▅ ▆ ▇ █", blocks, " ")
            scale = (scale = int(256 * (max - min) / (n - 1))) ? scale : 1
            for (i = 1; i <= count; i++)
                out = out (data[i] == "" ? " " : blocks[idx = int(256 * (data[i] - min) / scale) + 1])
            print out
        }
    '
end
### END OF SPARK ###

### FUNCTIONS ###
# Spark functions
function letters
    cat $argv | awk -vFS='' '{for(i=1;i<=NF;i++){ if($i~/[a-zA-Z]/) { w[tolower($i)]++} } }END{for(i in w) print i,w[i]}' | sort | cut -c 3- | spark | lolcat
    printf '%s\n' abcdefghijklmnopqrstuvwxyz ' ' | lolcat
end

function commits
    git log --author="$argv" --format=format:%ad --date=short | uniq -c | awk '{print $1}' | spark | lolcat
end

# Functions needed for !! and !$
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
# The bindings for !! and !$
if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function bak --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
    sed -n "$index p"
end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
function skip --argument n
    tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
    head -$number
end

function lfcd
    set tmp (mktemp)
    lf -last-dir-path="$tmp" $argv
    if test -f "$tmp"
        set dir (cat "$tmp")
        command rm -f "$tmp"
        if test -d "$dir" -a "$dir" != (pwd)
            cd "$dir"
        end
    end
end

function yazicd
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd "$cwd"
    end
    command rm -f "$tmp"
end

# nl -v 0 # line number command
# xargs -r -I % $EDITOR %

function search-configs
    set config_dir $HOME/.config
    set files cava/config dunst/dunstrc fish/config.fish hypr kitty/kitty.conf lf/lfrc mpv neofetch nvim/lua qt5ct/qt5ct.conf rofi scheduler swaylock tmux/tmux.conf waybar wezterm/wezterm.lua wlogout starship.toml zathura mimeapps.list

    set file_paths

    for file in $files
        set -a file_paths (find $config_dir/$file -type f -not -path '*/wlogout/*.png')
    end

    find $file_paths -type f | sed "s|$HOME|~|" | fzf -m --header="search-configs" --header-first | sed "s|~|$HOME|" | xargs -r $EDITOR
end

function search-scripts
    set scripts_dir $HOME/.local/bin/my-scripts
    find $scripts_dir -type f | sed "s|$HOME|~|" | fzf -m --header="search-scripts" --header-first | sed "s|~|$HOME|" | xargs -r $EDITOR
end

function search-files-cwd
    exa -af --git-ignore -I ".git" | fzf -m --header="search-files-cwd" --header-first | xargs -r $EDITOR
end

function search-nested-files-cwd
    tree -Fifa --gitignore -I ".git" --noreport | grep -v "/\$" | sed 's|^\./||' | fzf -m --header="search-nested-files-cwd" --header-first | xargs -r $EDITOR
end

function select-dir-cwd
    cd (exa -aD --git-ignore -I ".git" | fzf --header="select-dir-cwd" --header-first)
end

function select-nested-dir-cwd
    cd (tree -fida --gitignore -I ".git" --noreport | tail -n +2 | sed 's|^\./||' | fzf --header="select-nested-dir-cwd" --header-first)
end

function move-to-trash
    set selected_items (exa -a | fzf -m --header="move-to-trash" --header-first)
    set item_count (count $selected_items)

    if test $item_count -gt 0
        echo "Selected items: "
        for index in (seq (count $selected_items))
            echo "$index: $selected_items[$index]"
        end

        echo "Move all selected items to trash? (Type 'a' to move all, otherwise type the number space separated to move)"
        read -P "> " input

        if test "$input" = a
            trash-put -v $selected_items
        else if test (count $input) -gt 0
            set is_valid_input true
            set -l input_array (string split " " $input)
            for num in $input_array
                if not string match -r '^[0-9]+$' $num >/dev/null
                    set is_valid_input false
                    break
                end
            end

            if test $is_valid_input = true
                set items_to_move
                for num in (echo $input)
                    set item $selected_items[$num]
                    if test -n "$item"
                        set items_to_move $items_to_move $item
                    end
                end
                trash-put -v $items_to_move
            else
                echo "Error: Input should contain only numbers."
            end
        else
            echo "Error: Input is empty."
        end
    else
        echo "No files/folder selected to move in trash"
    end
end

# bind -e--preset \co
bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste
bind -M insert -m default jk 'commandline -f repaint'
bind -M insert \;o 'lfcd; commandline -f repaint'
bind -M default \;o 'lfcd; commandline -f repaint'
bind -M insert \;y 'yazicd; commandline -f repaint'
bind -M default \;y 'yazicd; commandline -f repaint'
bind -M insert \;h 'prevd; commandline -f repaint'
bind -M default \;h 'prevd; commandline -f repaint'
bind -M insert \;l 'nextd; commandline -f repaint'
bind -M default \;l 'nextd; commandline -f repaint'
bind -M insert \;c 'search-configs; commandline -f repaint'
bind -M default \;c 'search-configs; commandline -f repaint'
bind -M insert \;s 'search-scripts; commandline -f repaint'
bind -M default \;s 'search-scripts; commandline -f repaint'
bind -M insert \;f 'search-files-cwd; commandline -f repaint'
bind -M default \;f 'search-files-cwd; commandline -f repaint'
bind -M insert \;F 'search-nested-files-cwd; commandline -f repaint'
bind -M default \;F 'search-nested-files-cwd; commandline -f repaint'
bind -M insert \;d 'select-dir-cwd; commandline -f repaint'
bind -M default \;d 'select-dir-cwd; commandline -f repaint'
bind -M insert \;D 'select-nested-dir-cwd; commandline -f repaint'
bind -M default \;D 'select-nested-dir-cwd; commandline -f repaint'
bind -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'

### END OF FUNCTIONS ###

# changing cd to zoxide
alias cd='z'

# navigation
alias ..='z ..'
alias ...='z ../..'
alias .3='z ../../..'
alias .4='z ../../../..'
alias .5='z ../../../../..'

# nvim
alias v='nvim'

# Changing "ls" to "exa"
alias ls='exa --icons --color=always --group-directories-first' # show all files and dirs without hidden files
alias la='exa -a --icons --color=always --group-directories-first' # show all files and dirs with hidden files
alias ll='exa -al --icons --color=always --group-directories-first' # my preferred listing
alias lt='exa -aT --icons --color=always --group-directories-first' # tree listing
alias l.='exa -a | grep -E "^\."' # show only dotfiles

# Changing "cat" to "bat"
alias cat="bat"

# pacman and yay
alias parsua='paru -Sua --noconfirm' # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm' # update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck' # remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)' # remove orphaned packages
alias upd='sudo pacman -Syyu' # To update the system
# alias grubup="update-grub"                      # To update the grub files
alias hw='hwinfo --short' # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" # Recent installed pkgs
alias dir='dir --color=auto' # colorize dir
alias vdir='vdir --color=auto' # colorize vdir

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='trash-put -v'
alias trestore='trash-restore'
alias tlist='trash-list'
alias tempty='trash-empty -v'

# adding flags
alias df='df -h' # human-readable sizes
alias free='free --mega -h' # show sizes in MB

# bigger font in tty and regular font in tty
alias bigfont="setfont ter-132n"
alias regfont="setfont default8x16"

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
# alias pscpu='ps auxf | sort -nr -k 3'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# change your default shell
alias tobash="chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="chsh $USER -s /bin/fish && echo 'Now log out.'"

# Distrobox
alias dbox="/usr/bin/distrobox-enter -T -n System_Hacked -- "
alias kali="distrobox enter System_Hacked"

# Mysql
alias mysql="mariadb"

# bun (Node package manager)
alias npm="bun"
alias npx="bunx"

# icat (image viewer)
alias icat="kitty +kitten icat --align=left"

# mkdir
alias mkdir="mkdir -p"

# source fish config file
alias sof="source ~/.config/fish/config.fish"

# show the date
# %Z
# alias date='date "+%Y-%m-%d %A %T"'

# copy path
alias copypath="pwd | wl-copy"

# open
alias open="xdg-open"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# alias lf=lfrun

#pfetch
# pokemon --random
# pokemon --random --no-name
# neofetch
# colorscript --random
# nerdfetch
# asciifetch
# $HOME/.config/fastfetch/pretty-kernel.sh >/dev/null 2>&1 &

# Load shell globals
function load_shell_globals
    set -l file "$XDG_CONFIG_HOME/shell/load-shell-globals"
    if test -f $file
        replay "source $file"
    end
end

load_shell_globals

if status is-interactive
    fastfetch
end

### setting the starship prompt and zoxide ###
zoxide init fish | source
starship init fish | source
