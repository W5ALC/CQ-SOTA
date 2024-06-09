#!/bin/bash

ryt () {
    function cleanup () {
        printf "\nInterrupted. Exiting...\n"
        exit 1
    }
    trap cleanup INT

    if [ -f "$1" ]; then
        pv -qL $((11 + (-1 + RANDOM % 5))) < "$1"
    else
        printf "%s\n" "$@" | pv -qL $((11 + (-1 + RANDOM % 5)))
    fi

    trap - INT
    printf "\n"
}

# Function to check command existence
check_command () {
    if ! command -v "$1" &> /dev/null; then
        ryt "Error: %s command not found. Please install it first.\n" "$1"
        exit 1
    fi
}

# Ensure the script is running in Termux
if [ -z "$TERMUX_VERSION" ]; then
    ryt "This script is intended to run in Termux only.\n"
    exit 1
fi

# Ensure required commands are available
for cmd in pv pkg curl pip; do
    check_command "$cmd"
done

# Install pv if not already installed
if ! dpkg -s pv >/dev/null 2>&1; then
    pkg install -y pv
    if [ $? -ne 0 ]; then
        ryt "Error: Failed to install pv.\n"
        exit 1
    fi
fi

# Install curl if not already installed
if ! dpkg -s curl >/dev/null 2>&1; then
    pkg install -y curl
    if [ $? -ne 0 ]; then
        ryt "Error: Failed to install curl.\n"
        exit 1
    fi
fi

# Update and upgrade existing packages, then install required packages
ryt "Updating package lists and upgrading existing packages. This may take a few minutes...\n"
pkg update -y && pkg upgrade -y
if [ $? -ne 0 ]; then
    ryt "Error: Failed to update or upgrade packages.\n"
    exit 1
fi

ryt "Installing required packages: curl and python...\n"
pkg install -y termux-api python libgeos python-numpy
if [ $? -ne 0 ]; then
    ryt "Error: Failed to install required packages.\n"
    exit 1
fi

ryt "Package installation complete.\n"
sleep 3

# Install necessary Python packages
ryt "Installing necessary Python packages: geopy, tabulate, folium...\n"
pip install geopy tabulate folium
if [ $? -ne 0 ]; then
    ryt "Error: Failed to install necessary Python packages.\n"
    exit 1
fi

ryt "Python package installation complete.\n"
sleep 3

# Create the 'bin' directory if it doesn't exist
ryt "Creating the 'bin' directory in your home directory to store scripts...\n"
mkdir -p ~/bin
if [ $? -ne 0 ]; then
    ryt "Error: Failed to create the 'bin' directory.\n"
    exit 1
fi
ryt "Directory creation complete.\n"
sleep 2

# Add ~/bin to PATH if not already added
if ! grep -q "export PATH=\$PATH:~/bin" "$PREFIX/etc/bash.bashrc"; then
    ryt "Adding ~/bin to your PATH for easier script execution...\n"
    printf "export PATH=\$PATH:~/bin\n" >> "$PREFIX/etc/bash.bashrc"
    source "$PREFIX/etc/bash.bashrc"
    if [ $? -ne 0 ]; then
        ryt "Error: Failed to add ~/bin to your PATH.\n"
        exit 1
    fi
    ryt "Path update complete.\n"
else
    ryt "~/bin is already in your PATH.\n"
fi
sleep 2

# Download the cq-sota script and save it to ~/bin
ryt "Downloading the cq-sota script, which calculates SOTA summit details...\n"
curl -s https://gist.githubusercontent.com/W5ALC/607855b995374c505732a9d07349f124/raw/52d98d231853ca700f86b15270628aab9f88d2cd/cq-sota > ~/bin/cq-sota
if [ $? -ne 0 ]; then
    ryt "Error: Failed to download the cq-sota script.\n"
    exit 1
fi
ryt "cq-sota script downloaded successfully.\n"
sleep 2

# Make the cq-sota script executable
ryt "Making the cq-sota script executable...\n"
chmod +x ~/bin/cq-sota
if [ $? -ne 0 ]; then
    ryt "Error: Failed to make the cq-sota script executable.\n"
    exit 1
fi
ryt "2 scripts are now executable.\n"
sleep 2

# Create the 'sota' config folder if it doesn't exist
ryt "Creating the 'sota' config folder to store configuration files...\n"
mkdir -p ~/.config/sota
if [ $? -ne 0 ]; then
    ryt "Error: Failed to create the 'sota' config folder.\n"
    exit 1
fi
ryt "Configuration folder created.\n"
sleep 2

# Download and process the SOTA Summits List CSV file
ryt "Downloading the SOTA Summits List CSV file...\n"
curl -s https://storage.sota.org.uk/summitslist.csv | sed '1d' > ~/.config/sota/SOTA_Summits_List.csv
if [ $? -ne 0 ]; then
    ryt "Error: Failed to download and process the CSV file.\n"
    exit 1
fi
ryt "CSV file downloaded and processed successfully.\n"
sleep 2

# Completion message
ryt "Installation complete! You can now run either script using the command 'cq-sota.active' for activations and 'cq-sota.chase' for chases.\n"
ryt "These scripts calculate the distance, altitude change, azimuth, and heading between your location/SOTA summit and ANY SOTA summit/location.\n"

# Wait for the user to press any key before exiting
ryt "Press any key to exit..."
read -n 1 -s -r
exit
