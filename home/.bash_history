eval echo \${XDG_${1}_DIR:-$DOWNLOADS}
cd
fish
./fzf.sh
cd
echo $key

fish
echo $SHELL
ls /bin/sh
echo $BROWSER
v .bashrc
fish
tofish
fish
fish
vo -u
echo hi | tofi
echo "hi\\nhello" | tofi
echo "hi\nhello" | tofi
tofi
tofi-run
fish
tofi-run
fish
exit
fish
tofi-run
fish
notify-send "hello"
fish
fish
fish
fish
exit
column -mts ',' -o $'\t' path_to_the_index_file.csv | fzf -d '\t' --with-nth=1,2,3 --header-lines=1 --bind 'enter:close+execute(echo {1})'
column -mts ',' -o $'\t' index.csv | fzf -d '\t' --with-nth=1,2,3 --header-lines=1 --bind 'enter:close+execute(echo {1})'
fish
exit
    while true; do echo -ne "`date`\r"; done
    while true; do echo -ne "`date`\r"; done
exit
shellcheck --help
whereis shellcheck
exit
fish
exit
bun run build
bat ./src/!(types)/**/*.ts
bat ./src/**/*.ts
fish
[200~bat ./src/**/*.ts
fish
ls ./src/*.ts
ls ./src/**.ts
ls ./src/**/*.ts
fish
which biome
biome --version
exit
biome -v
biome --version
exit 
bun farm-ui
fish
bun farm-ui
bun farm-ui --help
sh
format=$(date +%d-%m-%y)-$(date +%I\-%M\-%p)
echo $format
biome --version
exit 
bun farm-ui
bun farm-ui
bun farm-ui --help
sh
format=$(date +%d-%m-%y)-$(date +%I\-%M\-%p)
echo $format
# Step 3: Concatenate both parts
ffmpeg -f concat -safe 0 -i <(echo "file 'part1.mp4'"; echo "file 'part2_fixed.mp4'") -c copy final_output.mp4
# Step 1: Extract the first 6 seconds
ffmpeg -i 'Video by sanatan_world2.0 [C_nwf9-yIhP].mp4' -t 6 -c copy part1.mp4
# Step 2: Extract the rest of the video from 7 seconds onward with adjusted audio
ffmpeg -i 'Video by sanatan_world2.0 [C_nwf9-yIhP].mp4' -itsoffset 0.3 -i 'Video by sanatan_world2.0 [C_nwf9-yIhP].mp4' -map 0:v -map 1:a -c:v copy -c:a aac -ss 7 part2_fixed.mp4
# Step 3: Create a text file for concatenation
echo "file 'part1.mp4'" > concat_list.txt
echo "file 'part2_fixed.mp4'" >> concat_list.txt
# Step 4: Concatenate using the list
ffmpeg -f concat -safe 0 -i concat_list.txt -c copy final_output.mp4
mpv final_output.mp4 
ll
ls
fish
ffmpeg -f concat -safe 0 -i concat_list.txt -c copy final_output.mp4
mpv final_output.mp4 
ll
ls
fish
format=$(date +%d-%m-%y)-$(date +%I-%M-%p)
format=$(date +%d-%m-%y)-$(date +%I-%M-%S-%p)
format=$(date +"%dD-%mM-%yY_%Ih-%Mm-%Ss_%p")
[200~format=$(date +%dD-%mM-%yY_%Ih-%Mm-%Ss_%p)
format=$(date +%dD-%mM-%yY_%Ih-%Mm-%Ss_%p)
echo $format
ls | progress --monitor --pid $!
command ls | progress --monitor --pid $!
echo $!
ls | echo $!
if paru -Qu | grep -q .; echo "update available" fi; 
if paru -Qu | grep -q .;then echo "update available" fi; 
if pacman -Qu | grep -q .;then echo "update available" fi; 
if pacman -Qu &>/dev/null; then    echo "Update available"; fi
[200~  sudo pacman -Su --noconfirm
  sudo pacman -Su --noconfirm
fish
exit
fish
exit
ll
clear
fish
 echo 'उद्योजकता' | grep -oE  $'[\u0900-\u097f]+'
exit
ll
 echo 'उद्योजकता' | grep -oE  $'[\u0900-\u097f]+'
zsh
nvim .config/fish/config.fish
ls
clear
fish
ls
fish
[200~~   amateur_hacker@machine                                                 
❯ bash <(curl -sSL https://github.com/amateur-hacker/battery-notifier/raw/main/install.sh)
fish: Invalid redirection target: 
bash <(curl -sSL https://github.com/amateur-hacker/battery-notifier/raw/main/install.sh)
fish
bash <(curl -sSL https://github.com/amateur-hacker/battery-notifier/raw/main/install.sh)
[200~while true; do
  wl-paste --type 'x-special/gnome-copied-files' --watch | while read line; do     echo "Copied: $line";   done
le true; do
  wl-paste --type 'x-special/gnome-copied-files' --watch | while read line; do     echo "Copied: $line";   done
done
h
fish
< .local/share/pokefetch/pokemon-list.txt 
fish
bash <"$(curl -sSL https://raw.githubusercontent.com/amateur-hacker/pokefetch/main/install.sh)
bash <$(curl -sSL https://raw.githubusercontent.com/amateur-hacker/pokefetch/main/install.sh)
fish
bash <(curl -sSL https://raw.githubusercontent.com/amateur-hacker/pokefetch/main/install.sh)
fish
echo "$!
"
echo "$!
"
echo "$!"
fish
echo "$!"
sudo pacman -S at
at --help
fish
nerdfont-test
exit
exit
fzf
fish
fzf
[200~input=$(tofi --prompt-text "Enter something: " <<< "")
nput=$(tofi --prompt-text "Enter something: " <<< "")
echo "You typed: $input"
tofi --prompt-text "Enter something: " <<< ""
tldr tofi
fish
tldr tofi
ls -a
clear
fish
clear
[200~input=$(echo " " | tofi --prompt-text "Enter your input:")
nput=$(echo " " | tofi --prompt-text "Enter your input:")
echo "You entered: $input":contentReference[oaicite:16]{index=16}
fish
[200~expr=$(echo '' | bemenu --prompt "Calc:" <&-) && [ -n "$expr" ] && result=$(qalc "$expr" | head -n1) && echo "$result" | wl-copy && notify-send "Calc: $expr" "$result"
expr=$(echo '' | bemenu --prompt "Calc:" <&-) && [ -n "$expr" ] && result=$(qalc "$expr" | head -n1) && echo "$result" | wl-copy && notify-send "Calc: $expr" "$result"
fish
res=$(qalc "$(rofi -dmenu -p "Calculate:" || exit)") && echo "$res" | head -n 1 | tee >(wl-copy) | notify-send
[200~34 + 2 = 36
fish
clear
fish
clear
v .conf
fish
MONITORS=$(hyprctl monitors | grep -o 'ID \d+' | awk '{print $2}')
echo $MONITORS
hyprctl monitors
fish
 grim -g "$(slurp -o -r -c '#ff0000ff')" -t ppm - | satty --filename - --fullscreen --output-filename ~/pictures/screenshots/screenshot-$(date '+%d-%b-%y_%Ih%Mm%Ss%p').png
fish
[200~[[ ! $(pidof wlogout) ]] && $powerMenU
[[ ! $(pidof wlogout) ]] && $powerMenu
[[ ! $(pidof wlogout) ]] && wlogout
command ls
fish
sudo pacman -S zsh
zsh
[200~ueberzugpp layer --parser bash <<EOF
add [identifier]=img [path]="$1" [x]=$x [y]=$y [width]=$w [height]=$h
EOF

[200~ueberzugpp layer --parser bash <<EOF
add [identifier]=img [path]="$HOME/.face" [x]=$x [y]=$y [width]=$w [height]=$h
EOF

sudo pacman -S ueberzugpp
[200~ueberzug layer --parser bash <<EOF
add [identifier]=img [path]="$HOME/.face" [x]=$x [y]=$y [width]=$w [height]=$h
EOF

ueberzug layer --parser bash <<EOF
add [identifier]=img [path]="$HOME/.face" [x]=$x [y]=$y [width]=$w [height]=$h
EOF

ueberzug layer --parser bash <<EOF
add [identifier]=img [path]="$HOME/.face" [x]=0 [y]=0 [width]=33 [height]=31OF

ueberzug layer --parser bash <<EOF
add [identifier]=img [path]="$HOME/.face" [x]=0 [y]=0 [width]=33 [height]=31EOF



ueberzug layer --parser bash <<EOF
add [identifier]=img [path]="$HOME/.face" [x]=0 [y]=0 [width]=33 [height]=31OF

ueberzug layer --parser bash <<EOF
add [identifier]=img [path]="$HOME/.face" [x]=0 [y]=0 [width]=33 [height]=31 EOF





ueberzugpp layer --parser bash <<EOF
add [identifier]=img [path]="$HOME/.face" [x]=0 [y]=0 [width]=33 [height]=23
EOF

fish
downgit [200~https://github.com/vercel/next.js/tree/canary/tesT
downgit https://github.com/vercel/next.js/tree/canary/test
fish
echo $FULLNAME
zsh
zsh
source .bashrc
v
ls
v
cd documents
ls
arch-update
sudo pacman -S blesh-git
fish
./yazi-cd
./yazicd
clear
fish
clear
fish
./yazi
./yazicd
source yazicd "$@"
yazi
source yazicd "$@"
./yazicd "$@"
source ~/.config/yazi/yazi-cd
zsh
getent
zsh
v
echo $name
fish
zsh
v
echo $name



fish
clear
ls -a
clear
ls -a
v .config/fish/config.fish
fish
echo $TERM
cd .config/shell
source functions
search_configs
cd .config/shell
source functions
search_configs
fish
cd .config/shell
source functions
search_configs
source functions
search_configs
search_configs
zsh
cd .config/shell
source functions
search_configs
source functions
search_configs
source functions
search_configs
search_configs
search_configs
search_configs
source functions
search_configs
source functions
search_configs
ls ~/.config/wlogout(layout|style.css)
ls ~/.config/wlogout(layout|style\.css)
ls ~/.config/wlogout/(layout|style\.css)
ls ~/.config/wlogout/layout|style.css
ls ~/.config/wlogout/(layout|style.css)
ls ~/.config/wlogout/^(layout|style.css)
find ~/.config/wlogout -type f ! -regex '.*\(layout\|style\.css\)$'
find ~/.config/wlogout -type f -regex '.*\(layout\|style\.css\)$'
cd .config/functions
cd .config/shell
source functions
search_configs
cd .config/shell
source functions
ls
search_configs
search_configs
find "$HOME/.config" -type f -regex "$HOME/.config/(wlogout/(layout|style.css))"
find "$HOME/.config" -type f -regex "$HOME/.config/(wlogout/(layout|style.css))"
find "$HOME/.config" -type f   -regextype posix-extended   -regex "$HOME/.config/wlogout/(layout|style\.css)"
find "$HOME/.config" -type f   -regextype posix-extended   -regex "$HOME/.config/wlogout/(layout|style\.css)"
find "$HOME/.config" -type f   -regextype posix-extended   -regex "$HOME/.config/wlogout"
find "$HOME/.config" -type f  -regextype posix-extended   -regex "$HOME/.config/wlogout"
find "$HOME/.config" -type f  -regextype posix-extended   -regex "$HOME/.config/wlogout/"
source functions
search_configs
search_configs
search_configs
source functions
search_configs
source functions
search_configs
search_configs
search_configs
source functions
search_configs
fish
$HOME/.config/shell/functions search_configs
$HOME/.config/shell/functions select_dir_cwd
$HOME/.config/shell/functions select_dir_cwd
source ~/.config/shell/functions
source ~/.config/shell/functions
source ~/.config/shell/functions
source ~/.config/shell/functions
source ~/.config/shell/functions
zsh
bash $HOME/.config/shell/functions
zsh
bash $HOME/.config/shell/functions
zsh
bash $HOME/.config/shell/peekr search_files_cwd
bash $HOME/.config/shell/peekr search_files_cwd
bash $HOME/.config/shell/peekr select_dir_cwd
bash -c "source $HOME/.config/shell/peekr select_dir_cwd"
bash -c "source $HOME/.config/shell/peekr; select_dir_cwd"
bash -c "source $HOME/.config/shell/peekr; select_dir_cwd"
bash -c "source $HOME/.config/shell/peekr; select_dir_cwd"
bash -c "source $HOME/.config/shell/peekr; select_dir_cwd"
select_dir_cwd
bash -c "source $HOME/.config/shell/peekr; $HOME/.config/shell/peekr select_dir_cwd"
v .config/shell/peekr
v .config/shell/peekr
v .config/shell/peekr
select_dir_cwd
ls
echo $SHELL
echo $0
bash -c "source $HOME/.config/shell/peekr; select_dir_cwd"
bash -c "source $HOME/.config/shell/peekr select_dir_cwd"
bash -c "source $HOME/.config/shell/peekr select_dir_cwd"
bash -c "source $HOME/.config/shell/peekr"
search_configs
peekr search_configs
v .config/shell/peekr
peekr search_configs
bash -c "source $HOME/.config/shell/peekr"
search_configs
v .config/shell/peekr
bash -c "source $HOME/.config/shell/peekr"
v .config/shell/peekr
bash -c 'source "$HOME/.config/shell/peekr"; select_dir_cwd'
[200~eza --only-files --git-ignore --color=never -1b
eza --only-files --git-ignore --color=never -1
bash -c 'source "$HOME/.config/shell/peekr" search_files_cwd'
bash -c 'source "$HOME/.config/shell/peekr" search_files_cwd'
bash 'source "$HOME/.config/shell/peekr" search_files_cwd'
bash 'source "$HOME/.config/shell/peekr" search_files_cwd'
bash "$HOME/.config/shell/peekr" search_files_cwd
source "$HOME/.config/shell/peekr" && select_dir_cwd
bash -c 'source "$HOME/.config/shell/peekr" && select_dir_cwd'
zsh
source ~/.config/shell/peekr select_dir_cwd
$HOME/.config/shell/peekr search_configs
$HOME/.config/shell/peekr select_dir_cwd
$HOME/.config/shell/peekr select_dir_cwd
source $HOME/.config/shell/peekr select_dir_cwd
exit
bash --version
v .bash_history
ls -a
clear
ls -a
zsh
setopt -h
setopt --help
pushd +1
cd ~/.config/nvim
pushd -1
pushd -1
cd ~/.config/fish
pushd -1
pushd -1
❯ # Copy file with a progress bar
cpp() {     set -e;     strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |     awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0; }
ls -a
v .config/fish
clear
ls -a
ls -a
ls -a
clear
clear
clear
bash
clear
ls -a
v .c
cpp() {     set -e;     strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |     awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0; }
cpp ~/downloads/iMe\ Desktop/Twilight.of.the.Warriors.Walled.In.\(2024\).BluRay.1080p.x264..mkv ~/videos/
cd ~/videos/
ls
yazi
rm Twilight.of.the.Warriors.Walled.In.\(2024\).BluRay.1080p.x264..mkv 
cd
clear
sedit .bashrc
du -h -max-depth=1
fish
alias example='f() { echo Your arg was $1. };f'
example hello
shopt expand_aliases 
example hello
alias example='f() { echo Your arg was $1. };f'
example hello
alias example="f() { echo Your arg was $1. };f"
example hello
v notes.txt
comm -23 <(pacman -Qqe | sort) <(pacman -Qqd | sort)
comm -23 <(pacman -Qqe | sort) <(pacman -Qqd | sort) | fzf
comm -23 <(pacman -Qqe | sort) <(pacman -Qqd | sort) | fzf
zsh
