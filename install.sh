#!/usr/bin/env bash

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
tmux_conf=".tmux.conf"

# Set default values
timestamp=$(date +%s) # Epoch time
re='^[1-9][0-9]*$' # Valid install options cannot start with 0

# Prompt for install options
read -p "Available install options:

Config Files
    1) ${vimrc}
    2) ${bashrc}
    3) ${tmux_conf}

   99) All

What do you want to install: " install_option

# Create a backup of selected config
function createBackup() {
    file=$1
    backup_file="${file}-${timestamp}.bak"

    # Create backup
    echo "${file} already exists, creating a backup..."
    mv -f ~/${file} ~/${backup_file}

    # Check for backup
    if ! [ -f ~/${backup_file} ] ; then
        echo "Error: Backup file was not created, exiting..." >&2; exit 1
    else
        echo "Backup file (~/${backup_file}) successfully created..."
    fi
}

# Installs the selected config
function installConfig() {
    file=$1

    # Create symlink
    echo "Creating symlink for ${file}..."
    ln -s ${PWD}/${file} ~/${file}

    # Check for symlink
    if ! [ -L ~/${file} ] ; then
        echo "Error: Symlink was not created, exiting..." >&2; exit 1
    else
        echo "Symlink (~/${file}) successfully created..."
    fi
}

# Checks to see if the selected config already exists
function checkConfig() {
    file=$1

    # Does the file already exist?
    if [ -f ~/${file} ] ; then
        echo "${file} already exists as a regular file..."
        # File already exists and is a symlink, nothing more to do
        if [ -L ~/${file} ] ; then
            echo "${file} already exists as a symlink, exiting..." >&2; exit 1
        else
            # Create a backup of the existing file
            createBackup ${file}
        fi
    else
        # The file does not already exist
        echo "${file} does not currently exist, installing..."
    fi
}

# What do you want to install?
if ! [[ ${install_option} =~ ${re} ]] ; then
    echo "Error: Not a valid option..." >&2; exit 1 # User supplied unexpected input
else
    case ${install_option} in
        1) install_file=${vimrc} ;;
    #    2) install_file=${bashrc} ;;
    #    3) install_file=${tmux_config} ;;
        *) echo "Error: Invalid selection, exiting..." >&2; exit 1
    esac
fi

# Install selected config
if [[ ${install_file} ]] ; then
    checkConfig ${install_file}
    installConfig ${install_file}
    echo "Installation of ${install_file} completed successfully!"
fi

