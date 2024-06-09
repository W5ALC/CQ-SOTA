3. Download dependencies: 
  -download curl python
     ```
     pkg update && pkg upgrade && pkg install curl python
     ```

10. Create the 'bin' Directory and Move the Script:
    - In the Termux terminal, type:
      ```
      mkdir ~/bin
      ```

    - Press Enter to create the 'bin' directory.

9. Add ~/bin to $PATH:
    - In the Termux terminal, type:
      ```
      echo "export PATH=$PATH:~/bin" >> $PREFIX/etc/bash.bashrc && source $PREFIX/etc/bash.bashrc
      ```

4. Download the script:
   - In the Termux terminal, type:
     ```
     curl -s https://gist.githubusercontent.com/W5ALC/607855b995374c505732a9d07349f124/raw/e9b38f1f32fd2ec511a16edec148d56bc424df34/cq-sota > bin/cq-sota
     ```

5. Create the 'sota' config Folder:
   - In the Termux terminal, type:
     ```
     mkdir -p ~/.config/sota
     ```

   - Press Enter to create the folder structure.

6. Download the CSV File:
   - In the Termux terminal, type:
     ```
     curl -s https://storage.sota.org.uk/summitslist.csv | sed '1d' | sed 's| / |-|g' > .config/sota/SOTA_Summits_List.csv
     ```

   - Press Enter to download the CSV file to the newly created 'sota' folder.

    - Make the script executable:
      ```
      chmod +x ~/bin/cq-sota
      ```

11. Run the Script:
    - In the Termux terminal, type:
      ```
      cq-sota
      ```

    - Press Enter to execute the script.

12. Follow the Instructions:
    - Follow the prompts to search for a summit and provide location information as needed.
    - The script will calculate various parameters such as distance, altitude change, azimuth, and heading between two geographical locations.
