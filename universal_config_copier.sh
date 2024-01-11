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

APPSINCLUDED=("alacritty" "polybar" "i3" "dunst")
# Helps us navigate both the dotfile and config folders
INTERNALFILENAMEARRAYDESKTOP=("alacritty.toml" "polybar_config" "desktop_config_i3" "dunstrc")
INTERNALFILENAMEARRAYLAPTOP=("alacritty.toml" "laptop_config" "laptop_config" "dunstrc")
# Filenames used inside the dotfiles folder
DESTINATIONFILENAMEARRAY=("alacritty.toml" "config" "config" "dunstrc")
# Filenames used in the actual config folder

read -p "Enter type [desktop/laptop] : " USERANSWERTYPE
    case $USERANSWERTYPE in
    [dD][eE][sS][kK][tT][oO][pP])
    homeSymArrayCall APPSINCLUDED INTERNALFILENAMEARRAYDESKTOP DESTINATIONFILENAMEARRAY
    echo "done"
    ;;
    [lL][aA][pP][tT][oO][pP])
    homeSymArrayCall APPSINCLUDED INTERNALFILENAMEARRAYLAPTOP DESTINATIONFILENAMEARRAY
    ;;
    *)
    echo "Not a valid option"
    ;;
    esac
