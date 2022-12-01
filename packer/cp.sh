#!/bin/bash

set -e
version="7.3"

echo "Using var version ${version}"

echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
sudo apt-get upgrade -y
sudo apt-get update -y
sudo apt-get install -y wget
sudo apt-get install -y apt-transport-https
sudo apt-get install -y gnupg2
wget -qO - https://packages.confluent.io/deb/${version}/archive.key | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/${version} stable main"
sudo add-apt-repository "deb https://packages.confluent.io/clients/deb $(lsb_release -cs) main"
sudo apt-get -y update
sudo sudo apt -y install default-jdk
sudo apt-get install -y confluent-platform
sudo apt-get install -y confluent-security
sleep 10
