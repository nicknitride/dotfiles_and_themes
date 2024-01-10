#!/usr/bin/bash

CONFIGFILEPATH="${HOME}/.config"
DOTFILESDIRPATH="${HOME}/dotfiles_and_themes"



function homeSymLink {
    APPLICATIONNAME="${1}" 
    INTERNALFILENAME="${2}" # The filename used inside the dotfiles folder
    CONFIGFOLDERFILENAME="${3}" # Final filename for the symoblic link
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




homeSymLink alacritty alacritty.toml alacritty.toml

APPSINCLUDED=("alacritty" "polybar" "i3" "fusuma")
# Helps us navigate both the dotfile and config folders
INTERNALFILENAMEARRAY=("alacritty.toml" "polybar_config" "config" "config.yml")
# Filenames used inside the dotfiles folder
DESTINATIONFILENAMEARRAY=("alacritty.toml" "config" "config" "config")
# Filenames used in the actual config folder

# * From online: To find the length of an array in Bash, you can use the ${#array[@]} syntax. This command will return the number of elements in the array.
# function homeSymArrayCall {
#     for ITEM in "${APPSINCLUDED}"
#         do
#         echo "$ITEM"
        
#     done
# }

# homeSymArrayCall