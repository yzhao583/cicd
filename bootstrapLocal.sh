#!/bin/bash

echo "Installing Ansible..."
apt-get install -y software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y ansible
apt-get install -y git
mkdir -p CICD
cd CICD
# git clone https://github.com/bulentcoskun/Todo.git
# ansible-playbook Todo/env/ansible/cd.yml -c local