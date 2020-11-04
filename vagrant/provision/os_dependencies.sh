#!/bin/bash
#Peter Mikaczo - Script to install OS dependencies

#Install
if [ "$(cat /etc/*release | grep Amazon)" ]; then
    yum install vim git -y
    yum install python-pip -y
    pip install ansible
else
    yum install epel-release -y
    yum install vim git nmap-ncat ansible -y
fi  
