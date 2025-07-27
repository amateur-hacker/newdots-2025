#!/usr/bin/env bash

# echo "Installing and setting up chaotic aur"
# sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
# sudo  pacman-key --lsign-key 3056513887B78AEB
# sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
# sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
# grep -qxF "[chaotic-aur]" /etc/pacman.conf && echo "Chaotic mirrors are already at their own place." || ( echo " "; echo "[chaotic-aur]"; echo "Include = /etc/pacman.d/chaotic-mirrorlist" ) | sudo tee -a /etc/pacman.conf

echo "Installing packages from pacman"
sudo pacman -S mpv figlet lolcat toilet aic94xx-firmware wd719x-firmware linux-firmware-qlogic upd72020x-fw alsa-utils tmux tk fzf plocate jdk-openjdk composer julia rust python-pip cmake npm nodejs tealdeer pipewire-pulse pipewire pipewire-alsa pipewire-audio pipewire-jack gst-plugin-pipewire ttf-fira-code ttf-ms-fonts acpi visual-studio-code-bin icu69 spotify ffmpeg4.4 zenity zathura zathura-djvu zathura-ps zathura-cb zathura-pdf-poppler gtk3 gtk4 gtk-engines gtk-engine-murrine neovim python-neovim noto-fonts-emoji noto-fonts-extra noto-fonts noto-fonts-cjk hyprshot brightnessctl discord tmux zoxide bat starship fish exa pkgstats lf capitaine-cursors mpv-mpris unzip zip powerpill man-db pacman-contrib wf-recorder reflector ipython wlsunset preload p7zip unrar tar ffmpegthumbnailer kitty python-pygments thunar catfish tumbler thunar-volman thunar-archive-plugin thunar-media-tags-plugin imagemagick mediainfo hwinfo perl-file-mimeinfo imv rsync ufw gufw appimagelauncher xdg-desktop-portal xdg-desktop-portal-hyprland-git pamixer plasma-framework5 go ufw less wget cava-git hyprland-git waybar-git network-manager-applet polkit-kde-agent polkit-gnome distrobox podman docker ttf-droid ttf-dejavu ttf-liberation ttf-fira-code otf-font-awesome noto-fonts-emoji adobe-source-code-pro-fonts rofi-wayland yazi wlogout hyprlock-git gvfs gvfs-mtp udiskie udisks2 ntfs-3g bluez bluez-utils blueman bluetooth-autoconnect linux-zen-headers xdg-user-dirs-gtk lshw inxi yt-dlp-git spotdl wofi xf86-video-amdgpu xf86-input-libinput jq pavucontrol qt5ct qt6ct qt6-svg swww terminus-font htop openssh wget xdg-utils iwd smartmontools wireless_tools vim nano wpa_supplicant fastfetch dunst yad python-requests python-pyquery slurp swappy wallust nwg-look wezterm-git kvantum kvantum-qt5 neofetch sddm atac ddcutil trash-cli bottom silicon ttf-jetbrains-mono xarchiver pulsemixer inter-font btop rocm-smi-lib insomnia httpie lazygit hyprpicker-git entr ripgrep-all fd lsb-release posting papirus-icon-theme stockfish-git chess-tui iniparser fftw qalculate-gtk hypridle netcat net-tools glow wmenu bemenu icon-library playerctl grimblast qalculate-gtk
sudo systemctl enable sddm

xdg-user-dirs-gtk-update
xdg-user-dirs-update

tldr --update
# echo "Installing paru (AUR Helper)"
# git clone https://archlinux.aur.org/paru-bin.git $HOME/Downloads/paru-bin
# cd $HOME/Downloads/paru-bin
# makepkg -si
# cd $HOME

# echo "Installing aur packages"
paru -S brillo mongodb-bin bun-bin fontpreview boxes spotx-git hyprshade-git pyprland cmatrix-git zen-browser-avx2-bin xdg-ninja-git aur/youtube-dl hyprprop-git

echo "Adding important groups to the user"
sudo usermod -aG wheel,audio,video,input,optical,storage,rfkill,power,sys,network,users,lp $LOGNAME

echo "Enabling preload"
sudo systemctl enable --now preload.service

echo "Enabling mongodb"
sudo systemctl enable --now mongodb.service

echo "Enabling ufw"
sudo ufw enable

echo "Installing scheduler"
git clone https://github.com/amateur-hacker/scheduler.git $HOME/Downloads/scheduler
bash $HOME/Downloads/scheduler/install.sh

echo "Installing pokemon-cli"
git clone https://github.com/amateur-hacker/pokemon-cli.git $HOME/Downloads/pokemon-cli
bash $HOME/Downloads/pokemon-cli/install.sh

echo "Installing tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# echo "Copying hyprland and additional config files"
# cp -r ./config/* $HOME/.config/
kemon-list.txt" "$POKEMON_LIST_URL"

echo ""
echo "${GREEN}✔ Pokemon images saved to:${RESET} $POKEFETCH_DATA_DIR/pokemons"
echo "${GREEN}✔ Pokemon list saved to:${RESET} $POKEFETCH_DATA_DIR"
echo "${GREEN}✔ Program installed to:${RESET} $BIN_DIR/pokefetch"

echo ""
echo "${YELLOW}To run the program:${RESET}"
echo "    ${GREEN}pokefetch${RESET}"
echo ""
echo "${YELLOW}Terminal Support:${RESET} Pokefetch works best in these terminals with image preview support:"
echo "  - ${CYAN}Kitty${RESET}      (required — uses 'kitten icat')      -> $(print_install_status kitty)"
echo "  - ${CYAN}WezTerm${RESET}    (optional — uses 'wezterm imgcat')   -> $(print_install_status wezterm)"
echo "  - ${CYAN}Ghostty${RESET}    (optional — uses same as kitty)      -> $(print_install_status ghostty)"
echo ""
echo "${CYAN}${BOLD}Installation complete!${RESET} 🎉 Now go catch 'em all!"
