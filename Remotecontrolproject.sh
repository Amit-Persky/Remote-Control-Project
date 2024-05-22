#!/bin/bash



echo -e "\e[33m"
echo "╔══════════════════════════════╗"
echo "║         Welcome!!!           ║"
echo "╚══════════════════════════════╝"
echo -e "\e[0m"
sleep 3


# 1. App installations and anonymity check

# 1.1 Installing things we need...
 
# 1.2 If the applications are installed already , we dont installing them.

REMOTE_REQUIREMENTS=( "curl" "figlet" "sshpass" "cpanminus" "cowsay" "git" "nmap" "whois" "geoip-bin")

function INSTALL_DEPENDENCIES(){
    for package_name in "${REMOTE_REQUIREMENTS[@]}"; do
        dpkg -s "$package_name" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "[*] Installing $package_name..."
            sudo -S apt-get install "$package_name" -y >/dev/null 2>&1
            if [ $? -eq 0 ]; then
                echo "[#] $package_name installed on your machine."
            else
                echo "[-] Failed to install $package_name."
            fi
        else
            echo "[#] $package_name is already installed on your machine."
        fi
    done
}

#  Checking if Nipe is installed, and if not let's install it.

function NIPE_CHECK(){
	
    if [ ! -d /home/kali/Desktop/nipe ]
    then
        INSTALL_NIPE
    fi
}

function INSTALL_NIPE(){

    cd /home/kali/Desktop/
    git clone https://github.com/htrgouvea/nipe >/dev/null 2>&1 && cd nipe
    cpanm --installdeps . >/dev/null 2>&1 
    sudo perl nipe.pl install >/dev/null 2>&1
    echo "[#] nipe installed on your machine."
}

#  Nipe is starting his job.

function NIPE_ON(){

	cd /home/kali/Desktop/nipe/
	sudo perl nipe.pl restart 
	sleep 2
	sudo perl nipe.pl restart 
    sleep 2
	echo "Local host is going anonymous:"
}

# 1.3 anonymous check, if we are good we are going on.. if we dont ok we are alerting and going out...

IP=$(curl -s ipv4.wtfismyip.com/text)

function ANON(){
	
  if [ "$(geoiplookup $IP | grep IL)" ]
  then
      echo -e "\e[31m[-] You Are Not Anonymous! exiting...\e[0m"
      exit
      
  else 
     echo -e "\e[1;32m[+] You Are Anonymous...\e[0m"
  fi   
}    


INSTALL_DEPENDENCIES
NIPE_CHECK
NIPE_ON





# 1.4 Now that we are in anonymous mode we want to check which country we are from now..

	
    COUNTRY=$(geoiplookup $IP | awk -F ', ' '{print $2}')
ANON
    echo "remote host spoofed country is: $COUNTRY"
    
sleep 2


# 1.5 Allow the user to specify the address to scan via remote server + save into varible.

function RMT (){

	
# 2. Automatically Connect and exeute commands on the remote server via ssh

# 2.1 Display the detailsof the remote server (Whois,IP,Uptime)

# 2.2 Get the remote server to display the whois of the given address
	
	echo "Please input the Remote IP :"
	read IP
	
	echo "Please input the USER you want to connect to :"
	read USER
	
	echo "please input the password of the user :"
	read -s PASS
	
	
    echo -e "\e[1;32m[+] Connect Successful!!!\e[0m"
    
    
}    

function NIPE_RMT_ACTIVATION(){
	
	cd /home/kali/Desktop/nipe/
	sudo -S perl nipe.pl restart 
	sleep 1
	sudo -S perl nipe.pl restart
	sleep 1
	echo "Remote host is going anonymous:"
	
}



function RMT_SCANS(){
	
	RMT_IP=$(sshpass -p $PASS ssh -o StrictHostKeyChecking=no $USER@$IP ifconfig | grep broadcast | awk '{print $2}')
    echo "Remote host IP: $RMT_IP"
    
	SPOOFED_IP=$(sudo perl nipe.pl status | grep Ip: | cut -d ":" -f 2)
    
    RMT_COUNTRY=$(sshpass -p $PASS ssh -o StrictHostKeyChecking=no $USER@$IP whois $IP | grep -i country | awk '{print $2}')
    echo "Remote host country: $RMT_COUNTRY"
    
    RMT_UPTIME=$(sshpass -p $PASS ssh -o StrictHostKeyChecking=no $USER@$IP uptime | awk '{print $1 $2 $3 $4}' | sed 's/:/:/; s/up/ up /')
    echo "Remote host uptime: $RMT_UPTIME"
    
    SPOOFED_COUNTRY=$(sshpass -p $PASS ssh -o StrictHostKeyChecking=no $USER@$IP whois $SPOOFED_IP| grep -m 1 "country:" | awk '{print $2}')
    
    
    sleep 3
    echo "Remote host spoofed ip: $SPOOFED_IP"
    echo "Remote host spoofed country: $SPOOFED_COUNTRY"
   
  
	echo "Please specify the IP address you would like to scan:"
    read SCANNED_IP
    
    echo -e "\e[93mNmap starts scanning for you as you requested...\e[0m"
    
    sshpass -p $PASS ssh -o StrictHostKeyChecking=no $USER@$IP "whois $SCANNED_IP > /home/$USER/Desktop/whois.txt" >/dev/null 2>&1
    
# 2.3 Get the remote server to scan for open ports on the given address.
    
    sshpass -p $PASS ssh -o StrictHostKeyChecking=no $USER@$IP "nmap $SCANNED_IP -sV -oG /home/$USER/Desktop/nmap.txt" >/dev/null 2>&1
    
# 3. Results.

# 3.1 Save the Whois and Nmap data into files on the local computer.

	sshpass -p $PASS scp $USER@$IP:/home/$USER/Desktop/nmap.txt /home/kali/Desktop/
	sshpass -p $PASS scp $USER@$IP:/home/$USER/Desktop/whois.txt /home/kali/Desktop/


echo "NMAP and WHOIS data of: $SCANNED_IP , has been Transferd To local host"
echo "[!!!] Deleting Nmap & Whois files from remote server ..."
sshpass -p $PASS ssh -o StrictHostKeyChecking=no $USER@$IP "rm -r /home/$USER/Desktop/nmap.txt /home/$USER/Desktop/whois.txt"
}

RMT
NIPE_RMT_ACTIVATION
RMT_SCANS


# 3.2 Create a log and audit your data collecting

sshpass -p $PASS ssh -o StrictHostKeyChecking=no $USER@$IP "sshpass -p kali sudo rm -r /var/log/auth.log >/dev/null 2>&1"

sleep 2

echo "[!!!] auth.log file has been Deleted From remote host [-] "

sleep 2

cowsay "good job!!" && sleep 5 && figlet -t -l -f big "BYE BYE" | sed 's/^\(.*\)$/\o033[33m\1\o033[0m/'
