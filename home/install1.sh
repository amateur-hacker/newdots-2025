#!/usr/bin/env bash

# Variables
CHAOTIC_AUR_KEY="3056513887B78AEB"
CHAOTIC_URL="https://cdn-mirror.chaotic.cx/chaotic-aur"
USER_DOWNLOADS="$HOME/Downloads"
PACMAN_PACKAGES=(
  mpv figlet lolcat toilet aic94xx-firmware wd719x-firmware
  linux-firmware-qlogic upd72020x-fw alsa-utils tmux tk fzf
  plocate jdk-openjdk composer julia rust python-pip cmake npm nodejs
  tealdeer pipewire-pulse pipewire pipewire-alsa pipewire-audio
  pipewire-jack gst-plugin-pipewire ttf-fira-code ttf-ms-fonts acpi
  visual-studio-code-bin icu69 spotify ffmpeg4.4 zenity zathura
  zathura-djvu zathura-ps zathura-cb zathura-pdf-poppler gtk3 gtk4
  gtk-engines gtk-engine-murrine neovim python-neovim noto-fonts-emoji
  noto-fonts-extra noto-fonts noto-fonts-cjk hyprshot brightnessctl
  discord tmux zoxide bat starship fish exa pkgstats lf capitaine-cursors
  mpv-mpris unzip zip powerpill man-db pacman-contrib wf-recorder reflector
  ipython wlsunset preload p7zip unrar tar ffmpegthumbnailer kitty
  python-pygments thunar catfish tumbler thunar-volman
  thunar-archive-plugin thunar-media-tags-plugin imagemagick mediainfo
  hwinfo perl-file-mimeinfo imv rsync ufw gufw appimagelauncher
  xdg-desktop-portal xdg-desktop-portal-hyprland-git pamixer plasma-framework5
  go ufw less wget cava-git hyprland-git waybar-git network-manager-applet
  polkit-kde-agent polkit-gnome distrobox podman docker ttf-droid
  ttf-dejavu ttf-liberation ttf-fira-code otf-font-awesome noto-fonts-emoji
  adobe-source-code-pro-fonts rofi-wayland yazi wlogout hyprlock-git gvfs
  gvfs-mtp udiskie udisks2 ntfs-3g bluez bluez-utils blueman bluetooth-autoconnect
  linux-zen-headers xdg-user-dirs-gtk lshw inxi yt-dlp-git spotdl wofi
  xf86-video-amdgpu xf86-input-libinput jq pavucontrol qt5ct qt6ct qt6-svg
  swww terminus-font htop openssh wget xdg-utils iwd smartmontools
  wireless_tools vim nano wpa_supplicant fastfetch dunst yad python-requests
  python-pyquery slurp swappy wallust nwg-look wezterm-git kvantum kvantum-qt5
  neofetch sddm atac ddcutil trash-cli bottom silicon ttf-jetbrains-mono
  xarchiver pulsemixer inter-font btop rocm-smi-lib insomnia httpie lazygit
  hyprpicker-git entr ripgrep-all fd lsb-release posting papirus-icon-theme
  stockfish-git chess-tui iniparser fftw qalculate-gtk hypridle netcat
  net-tools glow wmenu bemenu icon-library playerctl grimblast qalculate-gtk
  github-cli
)

AUR_PACKAGES=(
  brillo mongodb-bin bun-bin fontpreview boxes spotx-git
  hyprshade-git pyprland cmatrix-git zen-browser-avx2-bin
  xdg-ninja-git youtube-dl hyprprop-git
)

USER_GROUPS="wheel,audio,video,input,optical,storage,rfkill,power,sys,network,users,lp"

# Function to install Chaotic AUR
install_chaotic_aur() {
  echo "Installing and setting up Chaotic AUR..."
  sudo pacman-key --recv-key $CHAOTIC_AUR_KEY --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key $CHAOTIC_AUR_KEY
  sudo pacman -U "$CHAOTIC_URL/chaotic-keyring.pkg.tar.zst"
  sudo pacman -U "$CHAOTIC_URL/chaotic-mirrorlist.pkg.tar.zst"

  if ! grep -qxF "[chaotic-aur]" /etc/pacman.conf; then
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
  else
    echo "Chaotic mirrors are already set up."
  fi
}

# Function to install packages from Pacman
install_pacman_packages() {
  echo "Installing packages from Pacman..."
  sudo pacman -S --needed "${PACMAN_PACKAGES[@]}"
}

# Function to install AUR packages
install_aur_packages() {
  echo "Installing AUR packages..."
  if ! command -v paru &>/dev/null; then
    echo "Installing Paru (AUR Helper)..."
    git clone https://aur.archlinux.org/paru-bin.git "$USER_DOWNLOADS"/paru-bin
    cd "$USER_DOWNLOADS"/paru-bin || exit
    makepkg -si
    cd "$HOME" || exit
  fi

  paru -S "${AUR_PACKAGES[@]}"
}

# Function to add user to important groups
add_groups_to_user() {
  echo "Adding important groups to the user..."
  sudo usermod -aG "$USER_GROUPS" "$LOGNAME"
}

# Function to enable system services
enable_services() {
  echo "Enabling system services..."
  sudo systemctl enable --now preload.service
  sudo systemctl enable --now mongodb.service
  sudo systemctl enable --now ufw
}

# Function to install custom scripts
install_custom_scripts() {
  echo "Installing custom scripts..."

  git clone https://github.com/amateur-hacker/scheduler.git "$USER_DOWNLOADS"/scheduler
  bash "$USER_DOWNLOADS"/scheduler/install.sh

  git clone https://github.com/amateur-hacker/pokemon-cli.git "$USER_DOWNLOADS"/pokemon-cli
  bash "$USER_DOWNLOADS"/pokemon-cli/install.sh
}

# Function to install tmux plugin manager
install_tmux_plugins() {
  echo "Installing Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Function to update user directories
update_user_dirs() {
  echo "Updating user directories..."
  xdg-user-dirs-gtk-update
  xdg-user-dirs-update
}

# Update tldr pages
update_tldr() {
  echo "Updating tldr..."
  tldr --update
}

# Main script
install_pacman_packages
install_aur_packages
add_groups_to_user
enable_services
update_user_dirs
install_tmux_plugins
update_tldr

echo "Setup completed successfully."
