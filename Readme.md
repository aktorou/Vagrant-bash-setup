# Vagrant bash script setup

Thought I'd try my hand at a bash script to automate the setup of a vagrant box using Ubuntu 14.04 (trusty64).
The script installs the following:

- Apache 2
- MySQL
- PHP
- phpMyAdmin
- Phalcon
- Zurb Foundation


To use the script you will have to clone this git and run the start.sh script. In order to do this open up terminal and type the following commands.
```Shell
git clone https://github.com/aktorou/Vagrant-bash-setup.git your-project-name
```

Jump into your project directory:
```Shell
cd your-project-name
```

Run the bash script using:
```Shell
bash start-sh
```

It also creates a link between the vagrant shared files and the web root (var/www/). This allows easy editing from the host computer.

For easier debugging it also makes the log files accessable from the "vagrant/logs" folder on the host computer.


