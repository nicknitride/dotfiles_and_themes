#!/usr/bin/bash

CONFIGFILEPATH="${HOME}/.config"
DOTFILESDIRPATH="${HOME}/dotfiles_and_themes"



function homeSymLink {
    APPLICATIONNAME="${1}" 
    INTERNALFILENAME="${2}" # The filename used inside the dotfiles folder
    CONFIGFOLDERFILENAME="${3}" # Final filename for the symbolic link
    ACTUALCONFIGFILEPATH="${CONFIGFILEPATH}/${APPLICATIONNAME}/${CONFIGFOLDERFILENAME}"
    INTERNALLOCATION="${DOTFILESDIRPATH}/${APPLICATIONNAME}/${INTERNALFILENAME}"


    #Make Directory if it doesn't exist
    if  ! [ -d "${CONFIGFILEPATH}/${APPLICATIONNAME}/" ];
        then
        echo "Making the directory: ${CONFIGFILEPATH}/${APPLICATIONNAME}/"
        mkdir -p "${CONFIGFILEPATH}/${APPLICATIONNAME}/"
        else
        echo "Filepath in config folder exists"
    fi

    # Replace file if it does exist and overwrite
    if [ -f "${ACTUALCONFIGFILEPATH}" ];
        then
        echo "${ACTUALCONFIGFILEPATH}"
        echo "removing file for overwite"
        rm "${ACTUALCONFIGFILEPATH}"
        echo "result of ls: $(ls ${CONFIGFILEPATH}/${APPLICATIONNAME}/)"
    else
        :
    fi
    FINALLOCATION="${ACTUALCONFIGFILEPATH}"
    echo "symlinking the file ${INTERNALLOCATION}" 
    echo "target directory: ${ACTUALCONFIGFILEPATH}"
    ln -s "${INTERNALLOCATION}" "${ACTUALCONFIGFILEPATH}"
    echo "Final Result: $(ls -l "${ACTUALCONFIGFILEPATH}")"
}




# homeSymLink alacritty alacritty.toml alacritty.toml


#* From online: To find the length of an array in Bash, you can use the ${#array[@]} syntax. This command will return the number of elements in the array.
function homeSymArrayCall {
    local -n INTERNALAPPARRAY=${1}
    local -n INTERNALFNAME=${2}
    local -n INTERNALDESTFNAMEARRAY=${3}
    ARRAYLENGTH=${#INTERNALAPPARRAY[@]}
    for ((i = 0; i < ARRAYLENGTH; i++ ))
        do  
            homeSymLink "${INTERNALAPPARRAY[$i]}" "${INTERNALFNAME[$i]}" "${INTERNALDESTFNAMEARRAY[$i]}"
    done
}

LAPTOPAPPSINCLUDED=("alacritty" "polybar" "i3" "dunst" "betterlockscreen")
# Helps us navigate both the dotfile and config folders
INTERNALFILENAMEARRAYLAPTOP=("alacritty.toml" "laptop_config" "laptop_config" "dunstrc" "betterlockscreenrc")
# Filenames used inside the dotfiles folder
LAPTOPDESTINATIONFILENAMEARRAY=("alacritty.toml" "config" "config" "dunstrc" "betterlockscreenrc")
# Filenames used in the actual config folder

LAPTOPWITHPICOMAPPS=("alacritty" "polybar" "i3" "dunst" "betterlockscreen" "picom")
INTERNALFILENAMELAPTOPPICOM=("alacritty.toml" "laptop_config_picom" "laptop_config_picom" "dunstrc_picom" "betterlockscreenrc" "picom.conf")
LAPTOPDESTINATIONFILENAMEARRAYPICOM=("alacritty.toml" "config" "config" "dunstrc" "betterlockscreenrc" "picom.conf") 

APPSINCLUDEDDESKTOP=("alacritty" "polybar" "i3" "dunst" "betterlockscreen")
DESKINTERNALFILENAME=("alacritty.toml" "polybar_config" "desktop_config_i3" "dunstrc" "betterlockscreenrc")
DESKDESTINATIONFILENAME=("alacritty.toml" "config" "config" "dunstrc" "betterlockscreenrc")

APPDESKPICOM=("alacritty" "polybar" "i3" "dunst" "betterlockscreen" "picom")
DESKPICOMINTERNALFILENAME=("alacritty.toml" "polybar_config_with_picom" "desktop_config_i3_with_picom" "dunstrc_picom" "betterlockscreenrc" "picom.conf")
DESKPICOMDESTINATIONFILENAME=("alacritty.toml" "config" "config" "dunstrc" "betterlockscreenrc" "picom.conf")


BASICAPPS=("alacritty" "polybar" "i3" "dunst")
BASICINTERNALFILENAMES=("alacritty.toml" "polybar_no_dependencies" "i3_no_dependencies" "dunstrc")
BASICDESTINATION=("alacritty.toml" "config" "config" "dunstrc")

read -p "Enter type [1. desktop/2. laptop/3. basic /4. cancel ] : " USERANSWERTYPE
    case $USERANSWERTYPE in
    [1] | [dD][eE][sS][kK][tT][oO][pP])
    read -p "with picom [y/n]? : " SECONDUSERANSWER
        if [ ${SECONDUSERANSWER} == "y" ] || [ ${SECONDUSERANSWER} == "Y" ]
            then
                echo "Installing desktop config with picom"
                homeSymArrayCall APPDESKPICOM DESKPICOMINTERNALFILENAME DESKPICOMDESTINATIONFILENAME
        elif [ ${SECONDUSERANSWER} == "n" ] || [ ${SECONDUSERANSWER} == "N"  ] 
            then 
                echo "Chosen the non-picom option"
                homeSymArrayCall APPSINCLUDEDDESKTOP DESKINTERNALFILENAME DESKDESTINATIONFILENAME   
            else
                echo "Please enter a valid response"
        fi 
    ;;
    [2] | [lL][aA][pP][tT][oO][pP])
    read -p "Enable picom [y/n]? :" LAPTOPUSERANSWER
    if [ "${LAPTOPUSERANSWER}" == "y" ] || [ "${LAPTOPUSERANSWER}" == "Y" ]
        then
            echo "Installing desktop config with picom"
            homeSymArrayCall LAPTOPWITHPICOMAPPS INTERNALFILENAMELAPTOPPICOM LAPTOPDESTINATIONFILENAMEARRAYPICOM
    elif [ "${LAPTOPUSERANSWER}" == "n" ] || [ "${LAPTOPUSERANSWER}" == "N" ]
        then 
            echo "Chosen the non-picom option"
            homeSymArrayCall LAPTOPAPPSINCLUDED INTERNALFILENAMEARRAYLAPTOP LAPTOPDESTINATIONFILENAMEARRAY
    else 
            echo "Please enter a valid option"
    fi
    ;;
    [3] | [bB][aA][sS][iI][cC])
    homeSymArrayCall BASICAPPS BASICINTERNALFILENAMES BASICDESTINATION
    echo "done"
    ;;
    [cC][aA][nN][cC][eE][lL])
    echo "Cancelling config copy"
    ;;
    *)
    echo "Not a valid option"
    ;;
    esac
