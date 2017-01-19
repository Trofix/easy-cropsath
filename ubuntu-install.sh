#!/bin/bash 

# THIS FILE IS PART OF EASY-CROPSATH
# MADE BY MORICZGERGO
# THIS FILE HASN'T BEEN TESTED

# Init 
FILE="/tmp/out.$$" 
GREP="/bin/grep" 
# Make sure only root can run our script 
if [[ $EUID -ne 0 ]]; then 
   echo "This script must be run as root" 1>&2 
   exit 1 
fi

read -p "DANGER: This script will delete all of your files in /var/www/html/. Are you sure to proceed?[Y/n]  " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Install git if needed
    apt-get install git
    
    # Install apache2 if needed
    apt-get install apache2
    
    # Install PHP and libapache PHP
    apt-get install php5
    apt-get install libapache2-mod-php
    
    # Restart apache2
    service apache2 restart
    
    # Install MYSQL if needed
    apt-get install mysql-server mysql-client
    
    # Stop apache2
    service apache2 stop
    
    # Delete /var/www/html/
    rm -rf /var/www/html/
    
    # Clone cropsath
    git clone https://github.com/moriczgergo/cropsath/ /var/www/html/
    
    # Start apache2
    service apache2 start
fi

echo "The script has finished."
exit 0
