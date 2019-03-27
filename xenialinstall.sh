#!/bin/bash

#Zabbix Installation for Ubuntu 16.04

#Download and unpackage Xenial (Ubuntu 16.04) Zabbix Package
wget https://github.com/mistermint/Zabbix-Installer/releases/download/1/zabbix-xenial.deb
sudo dpkg -i zabbix-xenial.deb
sudo apt-get update
sudo apt-get install zabbix-agent -y
sudo sh -c "openssl rand -hex 32 > /etc/zabbix/zabbix_agentd.psk"

#Ask User What To Call This Agent
echo "What do you want to call this agent?"
read agentName

#Write Required Zabbix Info into agentd.conf
cat > /etc/zabbix/zabbix_agentd.conf << EOL
Server=65.50.230.94
TLSConnect=psk
TLSAccept=psk
TLSPSKIdentity=$agentName
TLSPSKFile=/etc/zabbix/zabbix_agentd.psk
EOL

#Start the Agent
sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent

#Zabbix Agent Installed. Providing PSK string to copy
cat /etc/zabbix/zabbix_agentd.psk
echo $agentName
read -p "Copy down PSK string and press enter to continue..."
sleep 10

#Verify Agent is Running
sudo systemctl status zabbix-agent
read -p "If Zabbix Agent is running. Press enter to end installation"
