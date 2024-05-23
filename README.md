PROJECT REMOTE CONTROL- AMIT PERSKY
This project entails setting up a system that initiates with the installation of required applications, ensuring avoidance of repeated installations. It performs an anonymity check of the network connection, alerting if non-anonymous, and revealing the spoofed country name if anonymous. It also accepts user-specified scan targets. Furthermore, the system can establish a remote SSH connection to retrieve server details and execute commands such as Whois and open port scans. Finally, it saves the gathered data into local files and maintains a log for auditing data collection activities.

In the REMOTE CONTROL PROJECT.pdf, you can see how the script is working and behaving.

Here are the instructions for using the Remote Control Project, which will be placed on GitHub for users to understand how to use it. This tool automates the installation of required applications, checks network anonymity, allows user-specified scan targets, establishes remote SSH connections, executes commands, and logs activities.

## Remote Control Project Instructions

### Overview
This project sets up a system that installs required applications, checks network anonymity, accepts user-specified scan targets, and establishes remote SSH connections to retrieve server details and execute commands. The gathered data is saved locally, and a log is maintained for auditing purposes.

### Requirements
1. Linux operating system (preferably Kali Linux).
2. Root privileges.
3. Necessary dependencies installed (`curl`, `figlet`, `sshpass`, `cpanminus`, `cowsay`, `git`, `nmap`, `whois`, `geoip-bin`).
4. Nipe installed in the `Memorytool` directory.
5. Remote server with SSH access.

### Setup
1. Download or clone this repository to your local machine.
2. Ensure that the script `Remotecontrolproject.sh` is executable. You can set the executable permission by running:
   ```bash
   chmod +x Remotecontrolproject.sh
   ```

### Running the Tool
1. **Navigate to the directory:**
   ```bash
   cd /path/to/Remotecontrolproject
   ```
   
2. **Run the script:**
   ```bash
   sudo ./Remotecontrolproject.sh
   ```
   Ensure you have root privileges, as the tool checks and exits if not run as root.

### Script Details
1. **Application Installation and Anonymity Check:**
   - The script installs necessary applications if they are not already installed.
   - It checks if Nipe is installed and installs it if not.
   - Nipe is started to enable anonymous browsing.
   - The script verifies if the network connection is anonymous. If not, it alerts the user and exits.

2. **Remote SSH Connection and Command Execution:**
   - The user is prompted to enter the remote IP address, username, and password for SSH connection.
   - The script connects to the remote server and displays details such as IP, country, and uptime.
   - The user specifies an IP address for scanning, and the script performs Whois and open port scans on the specified IP.

3. **Results Compilation:**
   - The Whois and Nmap data are saved into local files on the desktop.
   - The script deletes these files from the remote server to maintain anonymity.
   - A log is created for auditing data collection activities.

### Customization
- Users may need to modify paths within the script to match their environment.
- The script is designed to be flexible and can be adjusted according to specific needs or configurations.

### Conclusion
This tool simplifies the process of setting up a secure, anonymous environment for remote scanning and data collection. Users can customize the script to fit their environment and requirements, making it a versatile tool for cybersecurity operations.

By following these instructions, users can effectively utilize the Remote Control Project for their cybersecurity and data collection needs.

![script1](https://github.com/we-will-rock-you-933/Remote-Control-Project/assets/159085398/8f887eae-f142-4edc-ac73-a4af13c21d8e)

![script2](https://github.com/we-will-rock-you-933/Remote-Control-Project/assets/159085398/e4d31758-50e2-4fdb-acf8-8518f5d49f99)


Of course, each user may need to make small adjustments for the script to work well for them.
