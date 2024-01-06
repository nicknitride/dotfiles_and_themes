#!/usr/bin/bash
#Install free and non-free repos
sudo dnf install   https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install   https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update && sudo dnf upgrade

#Install wifi drivers
sudo dnf install akmod broadcom-wl
sudo dnf install rpmfusion-nonfree-release-tainted
sudo dnf --repo=rpmfusion-nonfree-tainted install "*-firmware"

#Install Flatpak
sudo dnf install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org

#Install base files
sudo dnf install vlc polybar rofi pasystray blueman git lxappearance lsd corectrl lutris

#VSCode Install
sudo dnf upgrade --refresh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
printf "[vscode]\nname=packages.microsoft.com\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscode.repo
sudo dnf install code

# Install fonts
git clone https://github.com/stark/siji && cd siji
sudo ./install.sh -d /usr/share/fonts

cd ..
cp ./alacritty/alacritty.yml/ ~/.config/alacritty/
sudo cp -r ./Fonts/JetBrainsMono /usr/share/fonts/
sudo cp -r ./Fonts/Noto_Emoji /usr/share/fonts/
sudo cp -r ./Fonts/Siji /usr/share/fonts/

# Install Themes
cp -r ./Theme_Files/Nordic-darker-v40/ /usr/share/themes/
cp -r ./Theme_Files/Simp1e-Nord-Dark/ /usr/share/icons/
cp -r ./Theme_Files/Zafiro-Nord-Black/ /usr/share/icons/

# Copy i3 Config
cp ./config ~/.config/i3/config
# Copy polybar config and rename
cp ./polybar_config/ ~/.config/polybar/config/
polybar bar
# Install Better Drivers
sudo dnf swap mesa-va-drivers.x86_64 mesa-va-drivers-freeworld.x86_64
sudo dnf swap mesa-vdpau-drivers.x86_64 mesa-vdpau-drivers-freeworld.x86_64
# Copy SSH keys
mv ./.ssh ~/


#Install OBS Flatpak and GStreamer
flatpak install com.obsproject.Studio com.obsproject.Studio.Plugin.GStreamerVaapi com.obsproject.Studio.Plugin.Gstreamer  

#Oh-My-Zsh Install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cp ./OMZ/.zshrc ~/.zshrc
cp ./OMZ/lsd_alias.zsh ~/.oh-my-zsh/custom/
# Change Shell to zsh
sudo chsh -s $(which zsh)
source .zshrc

sudo dnf install kdenlive