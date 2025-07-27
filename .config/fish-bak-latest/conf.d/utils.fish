# Custom touch override for verbose output
function touch
    for file in $argv
        if test -e "$file"
            echo "touch: updated timestamp '$file'"
        else
            echo "touch: created file '$file'"
        end
        command touch "$file"
    end
end

# cd to folder when quitting yazi
function yazi_cd
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    set -l cwd

    yazi $argv --cwd-file="$tmp"
    set cwd (cat "$tmp")
    if test -n "$cwd" -a "$cwd" != "$PWD"
        cd "$cwd"
    end
    command rm -f -- "$tmp"
end

# Searches for text in all files in the current folder
function ftext
    if test (count $argv) -lt 1
        echo "Usage: ftext <pattern>"
        return 1
    end

    set -l output (grep -iIHrn --color=always "$argv[1]" . 2>/dev/null)

    if test -z "$output"
        echo "No matches found."
        return 1
    end

    set -l lines (count (string split \n -- "$output"))
    set -l screen_lines (tput lines)

    if test "$lines" -gt "$screen_lines"
        echo "$output" | less -R
    else
        echo "$output"
    end
end

# Send a notification after long running command
function alert
    set -l last_command (history | tail -n1 | string replace -r '^[ \t]*[0-9]+[ \t]*' '' | string replace -r '[;&|][ \t]*alert$' '')
    if test $status -eq 0
        set -l icon terminal
    else
        set -l icon error
    end
    notify-send --urgency=low -i "$icon" "$last_command"
end

# Display internal and external IP
function whatismyip
    echo -n "Internal IP: "
    ip addr show wlan0 2>/dev/null | grep "inet " | awk '{print $2}' | cut -d/ -f1
    echo -n "External IP: "
    curl -s -4 ifconfig.me
end

# Count files, links, and directories
function countfiles
    for t in files links directories
        switch $t
            case files
                set type_char f
            case links
                set type_char l
            case directories
                set type_char d
        end
        set -l count (find . -type "$type_char" 2>/dev/null | wc -l)
        echo "$count $t"
    end
end
