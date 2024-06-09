# CQ-Sota

## Requires

This script requires the Termux and Termux-API Android app installed. It also requires Python and the following Python modules: `geopy`, `folium`, and `tabulate`.

## Description

CQ-Sota is a tool designed to calculate the distance, altitude change, azimuth, and heading between your location and any SOTA (Summits on the Air) summit. Additionally, it allows you to map any two points on Earth, not limited to SOTA summits.

## Features

- **Chase a SOTA Summit:** Calculate the distance, altitude change, azimuth, and heading from your location to a SOTA summit.
- **Activate a SOTA Summit:** Calculate the distance, altitude change, azimuth, and heading between two SOTA summits.
- **Termux Integration:** Automatically fetch your current location if Termux is installed.
- **Manual Location Entry:** Manually enter your location coordinates if Termux is not installed.
- **Offline Functionality:** Fully functional offline using an offline CSV file containing all SOTA summits.
- **Logging:** Save the results to a log file for future reference.

## Installation

1. **Install the required Python packages:**

    ```bash
    pkg install -y termux-api python libgeos python-numpy
    pip install geopy tabulate folium
    ```

2. **Create necessary directories and configure PATH:**

    ```bash
    mkdir ~/bin
    echo "export PATH=$PATH:~/bin" >> $PREFIX/etc/bash.bashrc && source $PREFIX/etc/bash.bashrc
    mkdir -p ~/.config/sota
    ```

3. **Download and setup the script and CSV file:**

    ```bash
    curl -s https://gist.githubusercontent.com/W5ALC/607855b995374c505732a9d07349f124/raw/e9b38f1f32fd2ec511a16edec148d56bc424df34/cq-sota > ~/bin/cq-sota
    curl -s https://storage.sota.org.uk/summitslist.csv | sed '1d' | sed 's| / |-|g' > ~/.config/sota/SOTA_Summits_List.csv
    chmod +x ~/bin/cq-sota
    ```

4. **(Optional) Configure default location:**

    Open the script file in a text editor and find the section with default values:

    ```python
    # Define default values for point one. Comment these lines out to disable defaults.
    #DEFAULT_LATITUDE = 40.7128  # Example default latitude
    #DEFAULT_LONGITUDE = -74.0060  # Example default longitude
    #DEFAULT_ALTITUDE = 33  # Example default altitude in feet
    ```

    Uncomment the lines and replace the example coordinates with your actual home coordinates and elevation:

    ```python
    DEFAULT_LATITUDE = 40.7128  # Example default latitude
    DEFAULT_LONGITUDE = -74.0060  # Example default longitude
    DEFAULT_ALTITUDE = 33  # Example default altitude in feet
    ```

## Usage

Run the script by typing:

```bash
cq-sota
```
or
```bash
cq-sota -l
```
or
```bash
cq-sota --log
```

### Commands

- **Chase a SOTA Summit (c):**
    - Enter your location or use Termux location if available.
    - Enter the callsign of the operator.
    - Search for the SOTA summit by name or summit code.
    - Optionally, enter coordinates manually if the summit is not found.
    - View the calculated distance, altitude change, azimuth, and heading.
    - Optionally, save the results to a log file.
 
- **Activate a SOTA Summit (a):**
    - Search for the summit you are activating by name or summit code.
    - Enter the callsign of the operator.
    - Search for another SOTA summit or enter coordinates manually.
    - View the calculated distance, altitude change, azimuth, and heading.
    - Optionally, save the results to a log file.

- **Help (h):**
    - Display the help section with detailed usage instructions.
    
### Options

- **--log, -l:** Enable logging to save the results to a log file.

## Examples

1. **Chasing a SOTA Summit:**

    ```bash
    cq-sota
    ```

    - Select 'c'.
    - Enter your location or use Termux location.
    - Enter the operator's callsign. (e.g., N0CALL)
    - Search for the SOTA summit by name or code (e.g., "W6/CC-004") or type 'manual' to enter manually.
    - View the results and optionally save them to a log file.

2. **Activating a SOTA Summit:**

    ```bash
    cq-sota
    ```

    - Select 'a'.
    - Search for the summit you are activating (e.g., "W6/CC-004").
    - Enter the operator's callsign.
    - Search for another summit or enter coordinates manually.
    - View the results and optionally save them to a log file.

## Additional Use Cases

- **Termux Location Integration:** If Termux is installed, the program can automatically fetch your current location.
- **Manual Location Entry:** If Termux is not installed or if you prefer, you can manually enter your location coordinates.
- **Summits Not in the List:** If a SOTA summit is not found in the CSV file, you can enter its coordinates manually to proceed with the calculations.
- **Viewing Results:** After performing the calculations, the results will be displayed on the screen, showing the distance, altitude change, azimuth, and heading between your location and the selected summit.
- **Saving Results:** You have the option to save the results to a log file for future reference. Use the `--log` or `-l` option when running `cq-sota` to enable logging.

## Note

This program is fully functional offline, as it uses an offline CSV file containing all SOTA summits. You can operate the program in remote locations without an active internet connection.
