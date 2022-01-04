!#/bin/bash

## INSTALL TOOLS ##

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
echo 'source ~/.kubectl_aliases' >> /home/$USER/.zshrc

### install visual studio code ###
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https -y
sudo apt update -y
sudo apt install code -y

### install vagrant ####
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && sudo apt-get install vagrant -y

echo "Tools have been installed successful"



