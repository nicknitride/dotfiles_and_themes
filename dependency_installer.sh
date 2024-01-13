#!/usr/bin/bash

function execConfigCopier {
    source "${HOME}/dotfiles_and_themes/universal_config_copier.sh"
}



function dependencyInstaller {
    echo "Executing dependency installer"
    read -p "Install github dependencies as well? (i3lock-color, rofi-applets, and Betterlockscreen) [y/n] ?" INPUTOPTIONAL
        if [ "${INPUTOPTIONAL}" == "y" ] || [ "${INPUTOPTIONAL}" == "Y" ]
        then
        echo "installing rofi-applets and rofi"
        sudo dnf install rofi
        source "${HOME}/dotfiles_and_themes/Rofi_Install_Scripts/rofi_applet_installer.sh"
    elif [ "${INPUTOPTIONAL}" == "n" ] || [ "${INPUTOPTIONAL}" == "N" ]
        then
        echo "nawp"
    else
        echo "Invalid exiting script"
    fi
}

# execConfigCopier
function main {
    execConfigCopier
    read -p "First Install? [y/n] :" USERIN
    if [ "${USERIN}" == "y" ] || [ "${USERIN}" == "Y" ]
        then
        echo "yeah"
    elif [ "${USERIN}" == "n" ] || [ "${USERIN}" == "N" ]
        then
        echo "nawp"
    else
        echo "Invalid exiting script"
    fi

}
