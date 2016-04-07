#!/bin/bash

source provisions/bash_settings.sh

clear

# echo -en "A website (Foundation for Sites)\rpoop\rZURB Template: includes Handlebars templates and Sass/JS compilers\r" | foundation new



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








if [ "$INSTALL_ZURB" == "y" ] && [ "$PROJECT_NAME" != "" ]
then
  echo -en "A website (Foundation for Sites)\r$PROJECT_NAME\rZURB Template: includes Handlebars templates and Sass/JS compilers\r" | foundation new
fi




printf "${YELLOW}Do you want to install zurb foundation? ${LGRAY}(y/n) ${NC}"
read INSTALL_ZURB 

if [ "$INSTALL_ZURB" == "y" ]
then
  printf "${YELLOW}This action will remove any previous zurb files within this project directory, do you want to continue? ${LGRAY}(y/n) ${NC}"
  read START_ZURB 

  if [ "$START_ZURB" == "y" ]
  then  
    # remove previous zurb projects
    rm -rf -- zurb_*

    printf "${YELLOW}Enter project name? ${LGRAY}(no spaces) ${NC}"
    read PROJECT_NAME
    PROJECT_NAME="zurb_"$PROJECT_NAME

    if [ "$INSTALL_ZURB" == "y" ] && [ "$PROJECT_NAME" != "" ]
    then
      echo -en "A website (Foundation for Sites)\r$PROJECT_NAME\rZURB Template: includes Handlebars templates and Sass/JS compilers\r" | foundation new
    fi
  else
    printf "Okay, moving on...\n\n"
  fi

  
else
  printf "Okay, moving on...\n\n"
fi




# # Install and setup Zurb Foundation
# printf "\n\n${BLUE}Installing Zurb Foundation\n${NC}"
# printf "${YELLOW}Project name?\n"
# read PROJECT_NAME 
# printf "${NC}"


# echo -en "\ntest\nZURB Template: includes Handlebars templates and Sass/JS compilers\n" | foundation new

# echo -en "\ntest\nZURB Template: includes Handlebars templates and Sass/JS compilers\n" | foundation new
 # <<<< "\c[[B\r"


# expect -c "
# spawn foundation new test

# expect \"Hello\"
# send \"World\"



# "


# TMPFILE=$(mktemp)

# dialog --menu "Choose one:" 10 30 3 \
#     1 Red \
#     2 Green \
#     3 Blue 2

# RESULT=$(cat $TMPFILE)

# case $RESULT in
#     1) echo "Red";;
#     2) echo "Green";;
#     3) echo "Blue";;
#     *) echo "Unknown color";;
# esac

# rm $TMPFILE


