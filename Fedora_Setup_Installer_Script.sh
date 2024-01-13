#!/usr/bin/bash

function FontInstaller {
    sudo cp -r ${HOME}/dotfiles_and_themes/Fonts/* /usr/share/fonts/
    echo -e "copying: $(ls ${HOME}/dotfiles_and_themes/Fonts/) \n to /usr/share/fonts/"
    echo "beginning siji font install"
    git clone https://github.com/stark/siji && cd siji
    cd siji 
    sudo ./install.sh /usr/share/fonts/
    rm -rf ./siji
}

function CodeInstaller {
    #VSCode Install
    sudo dnf upgrade --refresh
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    printf "[vscode]\nname=packages.microsoft.com\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscode.repo
    sudo dnf install code
}

function HWAcceleratedCodecs {
    sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
    sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
    sudo dnf swap ffmpeg-free ffmpeg --allowerasing
    sudo dnf groupupdate multimedia
    flatpak install com.obsproject.Studio com.obsproject.Studio.Plugin.GStreamerVaapi com.obsproject.Studio.Plugin.Gstreamer  
    sudo dnf install radeontop
}

function LaptopTouchpadInstaller {
    ### Install Fusuma (Touch Gestures)
    cp ${HOME}/dotfiles_and_themes/fedora_installer_helper_scripts/touchpad_fix/90-touchpad.conf /etc/X11/xorg.conf.d/
    sudo gem install fusuma
}

function ThemeInstaller {
    sudo cp -r ${HOME}/dotfiles_and_themes/Theme_Files/gtk/* /usr/share/themes/
    sudo cp -r ${HOME}/dotfiles_and_themes/Theme_Files/icons/* /usr/share/icons/
}

function OhMyZshInstaller {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    rm ${HOME}/.zshrc
    cp ${HOME}/dotfiles_and_themes/OMZ/.zshrc ${HOME}/
    cp ${HOME}/dotfiles_and_themes/OMZ/lsd_alias.zsh ${ZSH_CUSTOM}/
}

function EnableFedoraRepos {
    #Install free and non-free repos
    sudo dnf install   https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install   https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf update && sudo dnf upgrade
    #Install Flatpak
    sudo dnf install flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org
}

function BETTERLOCKSCREENINSTALLER {
    sudo dnf install -y xset autoconf automake cairo-devel fontconfig gcc libev-devel libjpeg-turbo-devel libXinerama libxkbcommon-devel libxkbcommon-x11-devel libXrandr pam-devel pkgconf xcb-util-image-devel xcb-util-xrm-devel
    git clone https://github.com/Raymo111/i3lock-color.git
    cd i3lock-color
    ./build.sh
    ./install-i3lock-color.sh
    wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user
}

function rofiAppletInstaller {
    echo "installing rofi-applets"
    source "${HOME}/dotfiles_and_themes/Rofi_Install_Scripts/rofi_applet_installer.sh"
    echo "[*] Installing/Copying Fonts"
}

function execConfigCopier {
    source "${HOME}/dotfiles_and_themes/universal_config_copier.sh"
}

# Array of dependencies
BASEANDGIT=("git" "picom" "i3" "vlc" "zsh" "bat" "qlipper" 
"arandr" "redshift" "rofi" "polybar" "pasystray" "blueman" 
"lxappearance" "lsd" "alacritty" "nitrogen" "gnome-screenshot" "thunar" "pip")
DESKTOPDEPENDENCIES=("ddcutil")
LAPTOPDEPENDENCIES=("brightnessctl" "gem" "tlp")

function DNFWrapper {
    local -n PACKAGELIST=${1}
    echo "Installing ${PACKAGELIST[@]}"
    sudo dnf install ${PACKAGELIST[@]}
}


function dependencyInstaller {
    echo "Executing dependency installer"
    echo "Installing universal dependencies"
    EnableFedoraRepos
    FontInstaller
    ThemeInstaller
    CodeInstaller
    HWAcceleratedCodecs
    DNFWrapper BASEANDGIT
    OhMyZshInstaller
    rofiAppletInstaller
    BETTERLOCKSCREENINSTALLER

    read -p " Select device type 1. Desktop | 2. Laptop ? [1|2]: " INPUTOPTIONAL
        if [ "${INPUTOPTIONAL}" == "1" ] 
        then
        echo "Installing desktop dependencies"
        DNFWrapper DESKSTOPDEPENDENCIES
    elif [ "${INPUTOPTIONAL}" == "2" ]
        then
        echo "Installing laptop dependencies"
        DNFWrapper LAPTOPDEPENDENCIES
        LaptopTouchpadInstaller
    else
        echo "Invalid exiting script"
    fi
    execConfigCopier
}


function main {
    read -p "First Install? [y/n] :" USERIN
    if [ "${USERIN}" == "y" ] || [ "${USERIN}" == "Y" ]
        then
        dependencyInstaller
    elif [ "${USERIN}" == "n" ] || [ "${USERIN}" == "N" ]
        then
        execConfigCopier
    else
        echo "Invalid exiting script"
    fi
}

main