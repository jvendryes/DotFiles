#!/bin/bash

# Set default values
vimrc_file=".vimrc"

# Stop executing if any command in the pipe returns a non-0 status
set -e

# Prompt for install options
read -p "Available install options:

    1) .vimrc
   99) All

Which do you want to install: " install_option

# Check for valid install options
re='^[1-9][0-9]*$' # Install option cannot start with 0
if ! [[ $install_option =~ $re ]] ; then
    echo "$vimrc_file | Error: Not a valid option!" >&2; exit 1 # User supplied unexpected input
fi

# Install .vimrc
if [ $install_option == 1 ] ; then
    # Is this a regular file?
    if [ -f ~/$vimrc_file ] ; then
        # File already exists and is a regular file
        echo "$vimrc_file | $vimrc_file already exists as a regular file, moving on..."
        # Move existing file to a backup file
        if [ -L ~/$vimrc_file ] ; then
            # File already exists and is a symbolic link
            echo "$vimrc_file | $vimrc_file already exists as a symbolic link, exiting..." >&2; exit 1
        else
            echo "$vimrc_file | $vimrc_file does NOT exist as a symbolic link, creating a backup..."
            # Create a backup of the file
            mv -f ~/$vimrc_file ~/$vimrc_file.backup
            echo "$vimrc_file | Created the backup (~/$vimrc_file.backup), moving on..."
        fi
    else
        # This is not a regular file
        echo "$vimrc_file | $vimrc_file does NOT exist as a regular file..."
    fi

    # Create symbolic link?
    echo "$vimrc_file | Creating symbolic link for $vimrc_file..."
    ln -s $PWD/$vimrc_file ~/$vimrc_file

    # Install completed
    echo "$vimrc_file | Install complete!"
fi

