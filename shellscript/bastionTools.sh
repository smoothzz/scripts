!#/bin/bash

## INSTALL TOOLS ##

### install docker ###
curl -fsSL https://get.docker.io | sh
usermod -aG docker thiago

### install unzip and make ###
apt install unzip make jq python3-pip -y
pip3 install giturlparse

### install teleport ###
curl https://deb.releases.teleport.dev/teleport-pubkey.asc | sudo apt-key add -
add-apt-repository 'deb https://deb.releases.teleport.dev/ stable main'
apt-get update
apt install teleport -y

### install kubectl ####
cd /tmp
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/bin

### install helm ###
cd /tmp
curl -LO https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz
tar -zxvf helm-v3.2.1-linux-amd64.tar.gz
chmod +x linux-amd64/helm
mv linux-amd64/helm /usr/bin

### install kubectx ###
cd /tmp
curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx_v0.9.4_linux_x86_64.tar.gz
tar -zxvf kubectx_v0.9.4_linux_x86_64.tar.gz
chmod +x kubectx
mv kubectx /usr/bin

### install kubens ###
curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens_v0.9.4_linux_x86_64.tar.gz
tar -zxvf kubens_v0.9.4_linux_x86_64.tar.gz
chmod +x kubens
mv kubens /usr/bin

### install terraform ###
wget https://releases.hashicorp.com/terraform/1.1.2/terraform_1.1.2_linux_amd64.zip
unzip terraform_1.1.2_linux_amd64.zip
mv terraform /usr/bin

### install k8s aliases ###
wget -P /home/$USER https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
echo 'source ~/.kubectl_aliases' >> /home/.bashrc

### clean up ###
cd /tmp
rm -rf kubens_v0.9.4_linux_x86_64.tar.gz kubectx_v0.9.4_linux_x86_64.tar.gz helm-v3.2.1-linux-amd64.tar.gz linux-amd64/ terraform_1.1.2_linux_amd64.zip LICENSE