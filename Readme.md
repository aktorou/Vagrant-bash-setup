# Vagrant bash script

## Whats the script installs/does

Thought I'd make a script that automates the setup of a vagrant box using Ubuntu 14.04 (trusty64).
The script installs the following:

- Apache 2
- MySQL
- PHP
- phpMyAdmin
- Phalcon
- Zurb Foundation

It also creates a link between the vagrant shared files and the web root (var/www/). This allows easy editing from the host computer.

For easier debugging it also makes the log files accessable from the "vagrant/logs" folder on the host computer.

Make sure you check the **Pre setup checks** and the **How to use** section.

## Pre setup checks

Before you run anything you will need to make sure you have installed nodejs, npm and vagrant. You may need to logout and log back in in order to start using vagrant commands in terminal.

This setup uses a vagrant box named "trusty64" so you will need to go ahead and grab that as well. If you not sure if you have it or not, type the following into terminal and it should appear in the list:
```Shell
vagrant box list
```

If it doesn't– no matter just run this command:

```Shell
vagrant box add trusty64 https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box
```

Now you're free at start running the bash script to get everything setup for you. I can take upto 15 minutes depending on your internet connection.


## How to use

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
bash start.sh
```


