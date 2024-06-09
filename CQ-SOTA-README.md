# CQ-Sota

## Requires

This script requires Termux and Termux-API Android app installed.
This script also requires Python and python modules geopy, folium and tabulate

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

1. **Download the script:**

    ```bash
    git clone https://github.com/w5alc/CQ-SOTA.git
    cd CQ-SOTA
    ```

2. **Install the required Python packages:**

    ```
    pkg install -y termux-api python libgeos python-numpy    
    ```

    ```
    pip install geopy tabulate folium
    ```

3. **(Optional) Configure default location:**

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

4. **Run the script:**

    ```./cq-sota.py``` or ```./cq-sota.py -l(/--log)```

## Usage

When you run the script, you'll be prompted to select an option to chase, activate, or get help for a SOTA summit.

### Commands

- **Chase a SOTA Summit (c):**
    - Enter your location or use Termux location if available.
    - Enter the callsign of the operator.
    - Search for the SOTA summit by name or summit code.
    - Optionally, enter coordinates manually if the summit is not found.
    - View the calculated distance, altitude change, azimuth, and heading.
    - Optionally, save the results to a log file.
 
      ```
      Welcome to CQ-Sota!
      This program is designed to calculate the
      distance, altitude change, azimuth, and heading
      between your location and ANY SOTA Summit.
      Do you want to chase (c), activate (a), or get help (h) for a SOTA summit? c

      Enter callsign of operator: n0call
      Enter search term for the SOTA summit you're chasing
      (or 'manual' to enter coordinates manually): blue sky
      Search Results:
      1. Mount Blue Sky - W0C/FR-003 39.5884, -105.6434
      Select the SOTA summit by number: 1


      QTH: 30.47388, -97.64175332 (Altitude: 652.7 feet)
      Mount Blue Sky: 39.5884, -105.6434 (Altitude: 14264.0 feet)
      +-----------------+-----------------------+-----------------------+
      |     N0CALL      | QTH -> Mount Blue Sky | Mount Blue Sky -> QTH |
      +-----------------+-----------------------+-----------------------+
      |    Distance     |       774.2 Mi        |       774.2 Mi        |
      | Altitude Change |      13611.3 Ft       |      -13611.3 Ft      |
      |     Azimuth     |        326.5 °        |        146.5 °        |
      |     Heading     |          NNW          |          SSE          |
      +-----------------+-----------------------+-----------------------+
      Map saved as /storage/emulated/0/W5ALC-QTH_to_Mount_Blue_Sky-N0CALL.html
      ```

- **Activate a SOTA Summit (a):**
    - Search for the summit you are activating by name or summit code.
    - Enter the callsign of the operator.
    - Search for another SOTA summit or enter coordinates manually.
    - View the calculated distance, altitude change, azimuth, and heading.
    - Optionally, save the results to a log file.
 
      ```
      Welcome to CQ-Sota!
      This program is designed to calculate the
      distance, altitude change, azimuth, and heading
      between your location and ANY SOTA Summit.
      Do you want to chase (c), activate (a), or get help (h) for a SOTA summit? a
      Enter search term for the SOTA summit you are activating (or 'exit' to quit): nipple
      Search Results:
      1. The Nipples - VE7/BS-005 54.9839, -127.6244
      2. Stone Nipples - VE7/CS-350 49.9768, -127.1765
      3. Nipple Summit - VE7/CS-416 50.1983, -124.9078
      4. The Nipple - VE7/FV-052 49.945, -121.5849
      5. Nipple Mtn - VE7/KB-008 49.6036, -119.1311
      6. Nipple Hill - VP8/WF-044 -51.6938, -60.2246
      7. Nipple Peak - W0C/MZ-020 40.8728, -107.0382
      8. Nipple Mountain - W0C/SC-030 38.2664, -105.797
      9. Nipple Mountain - W0C/SC-057 38.64, -105.1255
      10. Nippletop - W2/GA-007 44.089, -73.8166
      11. Nippletop Mountain - W2/GA-050 43.9918, -73.7537
      12. The Nipple - W6/NS-102 38.6399, -119.9332
      13. Nipple Butte - W7A/NA-023 35.5465, -110.417
      14. Mollies Nipple - W7A/NM-063 36.0839, -113.3636
      15. Nipple Knob - W7I/IC-038 45.9947, -114.5692
      16. Nipple Benchmark - W7I/LE-199 44.7671, -114.0311
      17. Mollys Nipples South - W7N/WP-150 38.8229, -114.7976
      18. Nipple Butte - W7O/NE-088 44.5773, -118.9765
      19. Nannys Nipple - W7O/SE-107 43.5489, -117.3691
      20. Mollies Nipple - W7U/KA-017 37.2708, -112.0552
      21. Nipple Benchmark - W7U/KA-039 37.2059, -111.6467
      22. Marys Nipple - W7U/MI-015 38.6826, -112.4109
      23. Marys Nipple - W7U/SP-005 39.0364, -111.5779
      24. Nippletop - W7U/WS-077 37.2107, -112.9022
      25. Mitchells Nipple - W7Y/SL-065 42.8131, -109.3895
      Select the SOTA summit by number: 9
      Enter callsign of operator: n0call
      Enter 's' to search for a SOTA peak for point 2,
      or 'm' to enter coordinates manually: mest
      Invalid option. Please enter 's' or 'm'.
      Enter callsign of operator: n0call
      Enter 's' to search for a SOTA peak for point 2,
      or 'm' to enter coordinates manually: s
      Enter search term for the SOTA summit (or 'exit' to quit): mesta
      Search Results:
      1. Limestack Mountain - KLF/CW-259 68.1001, -150.77811
      2. Mestaa’ėhehe Mountain - W0C/PR-082 39.6801, -105.4939
      3. Mount Mestas - W0C/SC-035 37.5829, -105.1472
      4. Homestake Peak - W0C/SR-090 39.3675, -106.4146
      Select the SOTA summit by number: 2
      
      
      Nipple Mountain (W0C/SC-057): 38.64, -105.1255 (Altitude: 10050.0 feet)
      Mestaa’ėhehe Mountain (W0C/PR-082): 39.6801, -105.4939 (Altitude: 11500.0 feet)
      +-----------------+---------------------------------------+-------------------------------------+
      |     N0CALL      |     Nipple Mountain (W0C/SC-057)      | Mestaa’ėhehe Mountain (W0C/PR-082)  |
      |                 | -> Mestaa’ėhehe Mountain (W0C/PR-082) |   -> Nipple Mountain (W0C/SC-057)   |
      +-----------------+---------------------------------------+-------------------------------------+
      |    Distance     |                74.4 Mi                |               74.4 Mi               |
      | Altitude Change |               1450.0 Ft               |             -1450.0 Ft              |
      |     Azimuth     |                344.8 °                |               164.8 °               |
      |     Heading     |                  NNW                  |                 SSE                 |
      +-----------------+---------------------------------------+-------------------------------------+
      Map saved as /storage/emulated/0/Nipple_Mountain_to_Mestaa’ėhehe_Mountain-N0CALL.html
      Do you want to log another? (yes/no): no
      Exiting program.

      ```

- **Help (h):**
    - Display the help section with detailed usage instructions.
 
      ```
      Welcome to CQ-Sota!
      This program is designed to calculate the
      distance, altitude change, azimuth, and heading
      between your location and ANY SOTA Summit.
      Do you want to chase (c), activate (a), or get help (h) for a SOTA summit? h
      
          CQ-Sota Help Section
      
          This program calculates the distance, altitude change, azimuth, and heading
          between your location and any SOTA (Summits on the Air) summit. Additionally,
          you can use this tool to map any two points on Earth, not limited to SOTA summits.
      
          Usage:
          - To chase a summit: Select 'c' and follow the prompts.
          - To activate a summit: Select 'a' and follow the prompts.
          - To view this help section: Select 'h'.
          - To exit the program: Select 'q'.
      
          Commands:
          - c: Chase a SOTA summit
              1. Enter your location or use Termux location if available.
              2. Enter the callsign of the operator.
              3. Search for the SOTA summit by name or summit code.
              4. Optionally, enter coordinates manually if the summit is not found.
              5. View the calculated distance, altitude change, azimuth, and heading.
              6. Optionally, save the results to a log file.
      
              Bonus: If you mainly chase summits from home, you can set your home location
              as the default. To do this:
                  1. Open the script file in a text editor.
                  2. Find the section of the code that looks like this:
      
                    # Define default values for point one. Comment these lines out to disable defaults.
                    #DEFAULT_LATITUDE = 40.7128  # Example default latitude
                    #DEFAULT_LONGITUDE = -74.0060  # Example default longitude
                    #DEFAULT_ALTITUDE = 33  # Example default altitude in feet
      
                  3. Uncomment the lines by removing the '#' at the beginning of each line:
      
                    # Define default values for point one. Comment these lines out to disable defaults.
                    DEFAULT_LATITUDE = 40.7128  # Example default latitude
                    DEFAULT_LONGITUDE = -74.0060  # Example default longitude
                    DEFAULT_ALTITUDE = 33  # Example default altitude in feet
      
                  4. Replace the example coordinates with your actual home coordinates and elevation.
                  5. Save the changes and run the script. Your home location will now be used
                     as the default location for chasing summits
                     ( if termux-location is not available )
      
          - a: Activate a SOTA summit
              1. Search for the summit you are activating by name or summit code.
              2. Enter the callsign of the operator.
              3. Search for another SOTA summit or enter coordinates manually.
              4. View the calculated distance, altitude change, azimuth, and heading.
              5. Optionally, save the results to a log file.
      
          - h: Display help.
      
          Options:
          - --log, -l: Enable logging to save the results to a log file.
      
              *** NOTE: To save to the log file, you have to use 'cq-sota -l' or 'cq-sota --log' ***
      
          Examples:
          1. Chasing a SOTA Summit:
             - Select 'c'.
             - Enter your location or use Termux location.
             - Enter the operator's callsign. ( e.g. n0call )
             - Search for the SOTA summit by name or code (e.g. "W6/CC-004")
               or type 'manual' to enter manually.
                 - Enter name for point 2: N0CALL
                 - Enter Enter coordinates for N0CALL (or 'exit' to quit): 28.98099,82.9819399
                 - Enter altitude for N0CALL in feet: 36
             - View the results and optionally save them to a log file.
      
          2. Activating a SOTA Summit:
             - Select 'a'.
             - Search for the summit you are activating. (e.g. "W6/CC-004")
             - Enter the operator's callsign.
             - Search for another summit or enter coordinates manually.
             - View the results and optionally save them to a log file.
      
          Additional Use Cases:
      
          - Termux Location Integration: If Termux is installed, the program can
            automatically fetch your current location.
          - Manual Location Entry: If Termux is not installed or if you prefer, you
            can manually enter your location coordinates.
          - Summits Not in the List: If a SOTA summit is not found in the CSV file, you
            can enter its coordinates manually to proceed with the calculations.
          - Viewing Results: After performing the calculations, the results will be
            displayed on the screen, showing the distance, altitude change, azimuth,
            and heading between your location and the selected summit.
          - Saving Results: You have the option to save the results to a log file for
            future reference. Use the --log or -l option when running cq-sota to enable logging.
      
      
          Note: This program is fully functional offline, as it uses an offline CSV file
          containing all SOTA summits. You can operate the program in remote locations
          without an active internet connection.

      ```

### Options

- **--log, -l:** Enable logging to save the results to a log file.

### Examples

1. **Chasing a SOTA Summit:**

    ```./cq-sota.py``` or ```./cq-sota.py -l(/--log)```

    - Select 'c'.
    - Enter your location or use Termux location.
    - Enter the operator's callsign. (e.g., N0CALL)
    - Search for the SOTA summit by name or code (e.g., "W6/CC-004") or type 'manual' to enter manually.
    - View the results and optionally save them to a log file.

2. **Activating a SOTA Summit:**

    ```./cq-sota.py``` or ```./cq-sota.py -l(/--log)```

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
- **Saving Results:** You have the option to save the results to a log file for future reference. Use the --log or -l option when running `cq-sota` to enable logging.

## Note

This program is fully functional offline, as it uses an offline CSV file containing all SOTA summits. You can operate the program in remote locations without an active internet connection.
