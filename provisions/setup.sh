#!/usr/bin/env bash

# Intended for Ubuntu 14.04 (Trusty)

# Print color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

pass='root' #preset password

# source ~/../../vagrant/bash_settings.sh

# Update Ubuntu
printf "\n\n${BLUE}----- Provision: Updating Ubuntu...${NC}\n\n"
apt-get update

# Adjust timezone to be Phoenix
# ln -sf /usr/share/zoneinfo/America/Phoenix /etc/localtime

# Apache
printf "\n\n${BLUE}----- Provision: Installing apache...${NC}\n\n"
sudo apt-get -f install 
apt-get install -y apache2 apache2-utils
echo "ServerName localhost" > "/etc/apache2/conf-available/fqdn.conf"
a2enconf fqdn
a2enmod rewrite
a2dissite 000-default.conf

# Link my shared folder to the web root
printf "\n\n${BLUE}----- Provision: Setup /var/www to point to /vagrant/Code ...${NC}\n\n"
rm -rf /var/www # empty web root
ln -fs /vagrant/Code /var/www # Link "Code" directory to webroot
sudo ln -s /var/log/*.log /vagrant/logs # Link server log to host log folder
sudo ln -s /var/log/apache2/*.log /vagrant/logs # Link server log to host log folder

# Apache / Virtual Host Setup
printf "\n\n${BLUE}----- Provision: Install Host File...${NC}\n\n"
cp /vagrant/provisions/hostfile /etc/apache2/sites-available/project.conf
a2ensite project.conf

# Cleanup
printf "\n\n${BLUE}----- Provision: Cleanup used install files...${NC}\n\n"
apt-get -y autoremove

# Restart Apache
printf "\n\n${BLUE}----- Provision: Restarting Apache...${NC}\n\n"
service apache2 restart

# Intall MySQL
printf "\n\n${BLUE}----- Provision: Installing MySQL\n\n${NC}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $pass"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $pass"
sudo apt-get -y install mysql-server

# Install libapache2 module for auth mysql
printf "\n\n${BLUE}----- Provision: Installing libapache2-mod-auth-mysql...\n\n${NC}"
sudo apt-get -y install libapache2-mod-auth-mysql

# Install PHP5-MySQL
printf "\n\n${BLUE}----- Provision: Installing php5-mysql...\n\n${NC}"
sudo apt-get -y install php5-mysql

# Setup MySQL DB
printf "\n\n${BLUE}----- Provision: Installing MySQL DB...\n\n${NC}"
sudo mysql_install_db

# Install PHP
printf "\n\n${BLUE}----- Provision: Installing PHP...\n\n${NC}"
sudo apt-get install -y php5 libapache2-mod-php5 php5-mcrypt

# Install phpMyAdmin
printf "\n\n${BLUE}----- Provision: Installing phpmyadmin...\n\n${NC}"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-user string root"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password root"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password root"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password root"
sudo apt-get install -y phpmyadmin

# Add line to apache conf file
printf "\n\n${BLUE}----- Provision: Append the include line for phpmyadmin into the apache configuration file...\n\n${NC}"
sudo -u root -H sh -c "sudo echo 'Include /etc/phpmyadmin/apache.conf' >> ~/../../etc/apache2/apache2.conf" 

# Add line to apache conf file
printf "\n\n${BLUE}----- Provision: Manualy enable mcrypt...\n\n${NC}"
sudo php5enmod mcrypt # Needs to be activated manually (that's an issue for Ubuntu 14.04)

# Restart Apache
printf "\n\n${BLUE}----- Provision: Time to restart apache...\n\n${NC}"
sudo service apache2 restart

# Install phalcon
printf "\n\n${BLUE}----- Provision: Installing Phalcon PHP Framework...\n\n${NC}"
sudo apt-get install -y software-properties-common
sudo apt-add-repository ppa:phalcon/stable
sudo apt-get update
sudo apt-get install -y php5-phalcon

# Restart Apache
printf "\n\n${BLUE}----- Provision: Time to restart apache...\n\n${NC}"
sudo service apache2 restart



