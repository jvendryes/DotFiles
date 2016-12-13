#!/usr/bin/env bash
# TODO: Better error handling
# TODO: install_files and install_scripts should be done in a more scalable way
# TODO: Better folder organization

# Script configuration
# Exit if a command fails
set -o errexit
# Exit if script tries to use undeclared variables
set -o nounset
# Exit status of the last command that threw a non-zero exit code
set -o pipefail

# Config files
vimrc=".vimrc"
bashrc=".bashrc"
bash_profile=".bash_profile"
tmux_conf=".tmux.conf"

# All config files
declare -a all_conf_files=(
    [1]=${vimrc}
    [2]=${bashrc}
    [3]=${bash_profile}
    [4]=${tmux_conf}
)

# Install scripts
vim_install="vim_install.sh"

# All install scripts
declare -a all_install_scripts=(
    [11]=${vim_install}
)

# Set default values
heading="DotFile"
seperator="------------------------------------------------------------------------------"
timestamp=$(date +%s) # Epoch time
install_options_re='^[1-9][0-9]*$' # Valid install options cannot start with 0

# Prompt for install options
read -p "
________        _____ _______________ ______
___  __ \______ __  /____  ____/___(_)___  /_____ ________
__  / / /_  __ \_  __/__  /_    __  / __  / _  _ \__  ___/
_  /_/ / / /_/ // /_  _  __/    _  /  _  /  /  __/_(__  )
/_____/  \____/ \__/  /_/       /_/   /_/   \___/ /____/
-------------------------------------------------------
         https://github.com/jvendryes/DotFiles
-------------------------------------------------------

What do you want to do?

${seperator}
Install Config Files
${seperator}

$(for i in "${!all_conf_files[@]}" ; do
    echo "    ${i}) ${all_conf_files[${i}]}"
done)

   10) All Configs

${seperator}
Install Scripts
${seperator}

$(for i in "${!all_install_scripts[@]}" ; do
    echo "   ${i}) ${all_install_scripts[${i}]}"
done)

   20) All Install Scripts

${seperator}
Enter a number: " install_option
echo "${seperator}"

# Checks to see if source file exists before attempting install
function checkForSourceFile() {
    file=$1

    # If source file does not exist
    if ! [ -f ${PWD}/${file} ] ; then
        echo "${file} | Source file does not exist, exiting..." >&2; exit 1
    fi
}

# Create a backup of selected config
function createBackup() {
    file=$1
    backup_file="${file}-${timestamp}.bak"

    # Create backup
    echo "${file} | File is not a symlink, creating a backup..."
    mv -f ${HOME}/${file} ${HOME}/${backup_file}

    # Check for backup
    if ! [ -f ${HOME}/${backup_file} ] ; then
        echo "${heading} | Error: Backup file (${HOME}/${backup_file}) was not created, exiting..." >&2; exit 1
    else
        echo "${file} | Backup file (${HOME}/${backup_file}) successfully created..."
    fi
}

# Checks to see if the selected config already exists
function checkForExistingConfig() {
    file=$1

    # Does the file already exist?
    if [ -f ${HOME}/${file} ] ; then
        echo "${file} | File already exists..."
        # File already exists and is not a symlink
        if ! [ -L ${HOME}/${file} ] ; then
            # Create a backup of the existing file
            createBackup ${file}
        fi
    else
        # The file does not already exist
        echo "${file} | File does not currently exist, installing..."
    fi
}

# Creates a symlink to the selected config
function createSymlink() {
    file=$1

    # Does the file already exist as a symlink?
    if [ -L ${HOME}/${file} ] ; then
        echo "${file} | File is already a symlink, skipping the install..."
    else
        # Create symlink
        echo "${file} | Creating symlink..."
        ln -s ${PWD}/${file} ${HOME}/${file}

        # Check for symlink
        if ! [ -L ${HOME}/${file} ] ; then
            echo "${heading} | Error: Symlink was not created, exiting..." >&2; exit 1
        else
            echo "${file} | Symlink (${HOME}/${file}) successfully created..."
        fi
    fi
}

# Runs the selected install script
function runInstallScript() {
    file=$1

    # Executing install script
    /usr/bin/env bash ${file}
}

# Installs the selected config(s)
function installConfigs() {
    files=("$@") # Array of configs

    # Install process
    for file in "${files[@]}" ; do
        checkForSourceFile ${file}
        checkForExistingConfig ${file}
        createSymlink ${file}
        echo "${file} | Installation completed successfully!"
        echo "${seperator}"
    done
}

# Installs the selected install script(s)
function installScripts() {
    scripts=("$@") # Array of install scripts

    # Install process
    for script in "${scripts[@]}" ; do
        checkForSourceFile ${script}
        echo "${script} | Running script..."
        runInstallScript ${script}
        echo "${script} | Script completed!"
        echo "${seperator}"
    done
}

# What do you want to install?
if ! [[ ${install_option} =~ ${install_options_re} ]] ; then
    echo "${heading} | Error: Not a valid option..." >&2; exit 1 # User supplied unexpected input
else
    # Install options
    case ${install_option} in
        [1-9]) # Options 1-9
            install_files=("${all_conf_files[${install_option}]}") ;;
        10) # All configs
            install_files=("${all_conf_files[@]}") ;;
        1[1-9]) # vim_install.sh
            install_files=("${all_conf_files[1]}") # Install .vimrc
            install_scripts=("${all_install_scripts[${install_option}]}") ;;
        # 20) install_scripts= ;; # All install scripts
        *) echo "${heading} | Error: Invalid selection, exiting..." >&2; exit 1
    esac

    # Install config(s)
    if [[ -n ${install_files:-} ]] ; then
        installConfigs ${install_files[@]} # Array of install_files
    fi

    # Install script(s)
    if [[ -n ${install_scripts:-} ]] ; then
        installScripts ${install_scripts[@]} # Array of install_scripts
    fi

    # If both install_files and install_scripts are empty, something is wrong...
    if [[ -z ${install_files} && -z ${install_scripts} ]] ; then
        echo "${heading} | Error: Something went terribly wrong, exiting..." >&2; exit 1
    fi
fi

