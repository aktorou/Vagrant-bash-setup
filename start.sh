#!/bin/bash

source provisions/bash_settings.sh

clear



printf "${YELLOW}Enter an IP address to use to access your project? ${LGRAY}(eg: 10.0.0.10) ${NC}"
read IPADD

export Vagrant_IP=$IPADD


echo $Vagrant_IP 


printf "${YELLOW}Do you want to install zurb foundation? ${LGRAY}(y/n) ${NC}"
read INSTALL_ZURB 

if [ "$INSTALL_ZURB" == "y" ]
then
  printf "${YELLOW}This action will remove any previous zurb files within this project directory, do you want to continue? ${LGRAY}(y/n) ${NC}"
  read START_ZURB 

  if [ "$START_ZURB" == "y" ]
  then  
    
    rm -rf -- zurb_* # remove previous zurb projects

    printf "${YELLOW}Enter project name? ${LGRAY}(no spaces) ${NC}"
    read PROJECT_NAME
    PROJECT_NAME="zurb_"$PROJECT_NAME

  else
    printf "Okay, moving on...\n\n"
  fi
else
  printf "Okay, moving on...\n\n"
fi




# Make Code Directory
printf "${BLUE}Setting up 'Code' & 'logs' shared directorys\n${NC}"
mkdir Code
mkdir logs

# Settup Vagrant Box
printf "${BLUE}Starting Vagrant\n\n${NC}"
vagrant up



if [ "$INSTALL_ZURB" == "y" ] && [ "$PROJECT_NAME" != "" ]
then
  # Install and setup Zurb Foundation
  printf "\n\n${BLUE}Installing Zurb Foundation\n${NC}"
  echo -en "A website (Foundation for Sites)\r$PROJECT_NAME\rZURB Template: includes Handlebars templates and Sass/JS compilers\r" | foundation new
fi


# # Install and setup Zurb Foundation
# printf "\n\n${BLUE}Installing Zurb Foundation\n${NC}"
# printf "${YELLOW}Project name?\n"
# read PROJECT_NAME 
# printf "${NC}"
# foundation new $PROJECT_NAME
# expect "? What are you building today?" { send "\r" }
# expect "? What's the project called? (no spaces)" { send "${PROJECT_NAME}\r" }
# expect "? Which template would you like to use? (Use arrow keys)" { send "\c[[B\r" }