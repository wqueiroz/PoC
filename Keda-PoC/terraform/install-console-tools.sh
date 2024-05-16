#!/bin/bash
sudo apt update && sudo apt install -y python3-pip ansible
sleep 5
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sleep 5
curl -LO https://get.helm.sh/helm-v3.10.0-linux-amd64.tar.gz
sleep 5
tar zxf helm-v3.10.0-linux-amd64.tar.gz
sleep 2
sudo cp kubectl /usr/bin/
sudo cp linux-amd64/helm /usr/bin/
sudo chmod 755 /usr/bin/kubectl
sudo chmod 755 /usr/bin/helm
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
ansible-galaxy collection install kubernetes.core
sudo python3 -m pip install kubernetes
