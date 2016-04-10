#!/bin/bash

source provisions/bash_settings.sh

clear


# Select project IP Address
printf "${YELLOW}Enter an IP address to use to access your project? ${LGRAY}(eg: 10.0.0.10) ${NC}"
read IPADD
export Vagrant_IP=$IPADD
printf "IP Address to access project: $Vagrant_IP"

# Install phalcon template
printf "\n${YELLOW}Do you want to install a basic phalcon template? ${LGRAY}(y/n) ${NC}"
read PHALCON_TEMPLATE

if [ "$PHALCON_TEMPLATE" == "y" ]
then

  # Template use volt
  printf "${YELLOW}Do you want the template to use .volt template language? ${LGRAY}(y/n) ${NC}"
  read PHALCON_VOLT

fi


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




if [ "$PHALCON_TEMPLATE" == "y" ]
then
  if [ "$PHALCON_VOLT" == "y" ]
  then
    # Create phalcon directorys in zurb project src folder
    cd $PROJECT_NAME/src
    mkdir app
    mkdir app/controllers
    mkdir app/models
    mkdir app/views
    mkdir public
    mkdir public/assets
    mv assets/* public/assets/
    cp ../../provisions/phalcon_outer_htaccess .
    cp ../../provisions/phalcon_inner_htaccess public/
    cp ../../provisions/phalcon_public_index.php public/
    mv phalcon_outer_htaccess .htaccess
    mv public/{phalcon_inner_htaccess,.htaccess}
    mv public/{phalcon_public_index.php,index.php}

    # remove old folders created by Zurb
    rm -rf -- data layouts pages partials styleguide assets

    # Install es6 promise pollyfill
    npm install -y es6-promise
  else
    # Create phalcon directorys in zurb project src folder
    cd $PROJECT_NAME/src
    # mkdir app
    # mkdir app/controllers
    # mkdir app/models
    # mkdir app/views
    # mkdir public
    # mkdir public/assets


    # cp ../../provisions/phalcon-phtml.zip .
    unzip ../../provisions/phalcon-phtml.zip -d .
    mkdir -p public/assets/; mv assets/* $_
    yes | cp -rf ../../provisions/gulpfile.babel.js ../
    # mv assets/* public/assets/
    # cp ../../provisions/phalcon_outer_htaccess .
    # cp ../../provisions/phalcon_inner_htaccess public/
    # cp ../../provisions/phalcon_public_index.php public/
    # mv phalcon_outer_htaccess .htaccess
    # mv public/{phalcon_inner_htaccess,.htaccess}
    # mv public/{phalcon_public_index.php,index.php}

    # remove old folders created by Zurb
    rm -rf -- data layouts pages partials styleguide assets

    # Install es6 promise pollyfill
    npm install -y es6-promise
  fi
fi


