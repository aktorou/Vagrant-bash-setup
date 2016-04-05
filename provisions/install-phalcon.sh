#!/bin/bash

# Install phalcon
echo "----- Provision: Installing Phalcon..."
apt-get install -y software-properties-common
apt-add-repository ppa:phalcon/stable
apt-get update
apt-get install -y php5-phalcon