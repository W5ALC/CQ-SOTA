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
#check_command () {
#    if ! command -v "$1" &> /dev/null; then
#        ryt "Error: %s command not found. Please install it first.\n" "$1"
#        exit 1
#    fi
#}

# Ensure the script is running in Termux
if [ -z "$TERMUX_VERSION" ]; then
    ryt "This script is intended to run in Termux only.\n"
    exit 1
fi

# Ensure required commands are available
#for cmd in pv pkg curl pip; do
#    check_command "$cmd"
#done

# Install pv if not already installed
if ! dpkg -s pv >/dev/null 2>&1; then
    if ! pkg install -y pv; then
        ryt "Error: Failed to install pv."
        exit 1
    fi
fi

# Install curl if not already installed
if ! dpkg -s curl >/dev/null 2>&1; then
    if ! pkg install -y curl; then
        ryt "Error: Failed to install curl."
        exit 1
    fi
fi

# Update and upgrade existing packages, then install required packages
ryt "Updating package lists and upgrading existing packages. This may take a few minutes..."
if ! pkg update -y && pkg upgrade -y; then
    ryt "Error: Failed to update or upgrade packages."
    exit 1
fi

ryt "Installing required packages: curl and python..."
if ! pkg install -y termux-api python libgeos python-numpy; then
    ryt "Error: Failed to install required packages."
    exit 1
fi

sleep 3
ryt "Package installation complete."


# Install necessary Python packages
ryt "Installing necessary Python packages: geopy, tabulate, folium..."
if ! pip install geopy tabulate folium; then
    ryt "Error: Failed to install necessary Python packages."
    exit 1
fi
sleep 3

ryt "Python package installation complete."

# Create the 'bin' directory if it doesn't exist
ryt "Creating the 'bin' directory in your home directory to store scripts..."
if ! mkdir -p ~/bin; then
    ryt "Error: Failed to create the 'bin' directory."
    exit 1
fi

sleep 2
ryt "Directory creation complete."


# Add ~/bin to PATH if not already added
if ! grep -q "export PATH=\$PATH:~/bin" "$PREFIX/etc/bash.bashrc"; then
    ryt "Adding ~/bin to your PATH for easier script execution..."
    printf "export PATH=\$PATH:~/bin\n" >> "$PREFIX/etc/bash.bashrc"
    source "$PREFIX/etc/bash.bashrc"
    if ! source "$PREFIX/etc/bash.bashrc"; then
        ryt "Error: Failed to add ~/bin to your PATH."
        exit 1
    fi
    sleep 2
    ryt "Path update complete."
else
    sleep 2
    ryt "~/bin is already in your PATH."
fi

# Download the cq-sota script and save it to ~/bin
ryt "Downloading the cq-sota script, which calculates SOTA summit details..."
if ! curl -s https://gist.githubusercontent.com/W5ALC/607855b995374c505732a9d07349f124/raw/52d98d231853ca700f86b15270628aab9f88d2cd/cq-sota > ~/bin/cq-sota; then
    ryt "Error: Failed to download the cq-sota script."
    exit 1
fi
sleep 2

ryt "cq-sota script downloaded successfully."


# Make the cq-sota script executable
ryt "Making the cq-sota script executable..."
if ! chmod +x ~/bin/cq-sota; then
    ryt "Error: Failed to make the cq-sota script executable."
    exit 1
fi
sleep 2

ryt "cq-sota script is now executable."


# Create the 'sota' config folder if it doesn't exist
ryt "Creating the 'sota' config folder to store configuration files..."
if ! mkdir -p ~/.config/sota; then
    ryt "Error: Failed to create the 'sota' config folder."
    exit 1
fi
sleep 2
ryt "Configuration folder created."


# Download and process the SOTA Summits List CSV file
ryt "Downloading the SOTA Summits List CSV file..."
if ! curl -s https://storage.sota.org.uk/summitslist.csv | sed '1d' > ~/.config/sota/SOTA_Summits_List.csv; then
    ryt "Error: Failed to download and process the CSV file."
    exit 1
fi
sleep 2

ryt "CSV file downloaded and processed successfully."


# Completion message
ryt "Installation complete! You can now run the script using the command 'cq-sota'."
ryt "This script calculates the distance, altitude change, azimuth, and heading between your location/SOTA summit and ANY SOTA summit/location."

# Wait for the user to press any key before exiting
ryt "Press any key to exit..."
read -n 1 -s -r
exit
