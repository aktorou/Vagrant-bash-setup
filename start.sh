#!/bin/bash/expect -f

source provisions/bash_settings.sh

clear

# Make Code Directory
printf "${BLUE}Setting up 'Code' & 'logs' shared directorys\n${NC}"
mkdir Code
mkdir logs

# Settup Vagrant Box
printf "${BLUE}Starting Vagrant\n\n${NC}"
vagrant up

# Install and setup Zurb Foundation
printf "\n\n${BLUE}Installing Zurb Foundation\n${NC}"
printf "${YELLOW}Project name?\n"
read PROJECT_NAME 
printf "${NC}"
foundation new $PROJECT_NAME
expect "? What are you building today?" { send "\r" }
expect "? What's the project called? (no spaces)" { send "${PROJECT_NAME}\r" }
expect "? Which template would you like to use? (Use arrow keys)" { send "\c[[B\r" }