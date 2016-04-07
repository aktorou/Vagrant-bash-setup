# Vagrant bash script setup

Thought I'd try my hand at a bash script to automate the setup of a vagrant box using Ubuntu 14.04 trusty64.
The script installs the following:

- Apache 2
- MySQL
- PHP
- phpMyAdmin
- Phalcon
- Zurb Foundation


To use the script pull this git to your project file then run **bash start.sh** in terminal.

It also creates a link between the vagrant shared files and the web root (var/www/). This allows easy editing from the host computer.

For easier debugging it also makes the log files accessable from the "vagrant/logs" folder on the host computer.


