#!/bin/bash
# Author: Samúel Jón Gunnarsson
# Description: Bootstraps Neovim by downloading configuration files and setting up plugins.
# Backup of existing configurations is made before applying new settings.

DATE=$(date +%y%m%d%H%M)

# Function to check if required tools are installed
function check_tools() {
    echo "Checking required tools..."
    which git > /dev/null
    if [ $? -ne 0 ]; then
        echo "Git is not installed. Please install Git before proceeding."
        exit 1
    fi

    which nvim > /dev/null
    if [ $? -ne 0 ]; then
        echo "Neovim is not installed. Please install Neovim before proceeding."
        exit 1
    fi
}

# Function to clone configuration repository
function fetch_config() {
    echo "Fetching Neovim configuration from GitHub..."
    git clone --recursive https://samueljon@github.com/samueljon/nvim-config.git ~/.config/nvim
}

# Function to backup existing configuration
function backup_config() {
    echo "Backing up existing Neovim configuration..."
    if [ -d ~/.config/nvim ]; then
        mv ~/.config/nvim ~/.config/nvim.$DATE
    fi
}

# Function to install plugins
function install_plugins() {
    echo "Installing plugins using Packer..."
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

# Main script execution
echo "***************************************************************************"
echo "Starting Neovim bootstrap process"
echo "***************************************************************************"
read -sn 1 -p "Press 'y' to continue or any other key to cancel: "
echo
if [ "$REPLY" == "y" ]; then
    check_tools
    backup_config
    fetch_config
    install_plugins
    echo "***************************************************************************"
    echo "* Neovim bootstrap completed! Existing configuration backed up as ~/.config/nvim.$DATE"
    echo "***************************************************************************"
else
    echo "***************************************************************************"
    echo "Bootstrap process canceled."
    echo "***************************************************************************"
fi

