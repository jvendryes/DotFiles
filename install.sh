#!/usr/bin/env bash

# Script configuration
# Exit if a command fails
set -o errexit
# Exit if script tries to use undeclared variables
set -o nounset
# Exit status of the last command that threw a non-zero exit code
set -o pipefail

# Set default values
timestamp=$(date +%s) # Epoch time
re='^[1-9][0-9]*$' # Valid install options cannot start with 0
vimrc_file=".vimrc"
bashrc_file=".bashrc"

# Prompt for install options
read -p "Available install options:

Config Files
    1) .vimrc
    2) .bashrc

   99) All

Which do you want to install: " install_option

# Check for valid install options
if ! [[ ${install_option} =~ ${re} ]] ; then
    echo "${vimrc_file} | Error: Not a valid option!" >&2; exit 1 # User supplied unexpected input
fi

# Create a backup of a supplied file
function createBackup() {
    file=$1
    echo "${file} already exists, creating a backup..."
    mv -f ~/${file} ~/${file}-${timestamp}.backup
    echo "Backup file (${file}-${timestamp}.backup) created..."
}

# Create a symbolic link
function createSymLink() {
    file=$1
    echo "Creating symbolic link for ${file}..."
    ln -s ${PWD}/${file} ~/${file}
}

# Install selected config
function installConfig() {
    file=$1
    # Does the file already exist?
    if [ -f ~/${file} ] ; then
        echo "${file} already exists as a regular file..."
        # File already exists and is a symbolic link, nothing more to do
        if [ -L ~/${file} ] ; then
            echo "${file} already exists as a symbolic link, exiting..." >&2; exit 1
        else
            # Create a backup of the existing file
            createBackup ${file}
        fi
    else
        # The file does not already exist
        echo "${file} does not currently exist, proceeding with the install..."
    fi
}

# Install .vimrc
if [ ${install_option} == 1 ] ; then

    installConfig ${vimrc_file}

    createSymLink ${vimrc_file}

    # Install completed
    echo "${vimrc_file} | Install complete!"
fi

