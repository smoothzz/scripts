!#/bin/bash

### KUBECTL ####
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

### HELM ###
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

### TERRAFORM ###
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

### ULAUNCHER ###
add-apt-repository ppa:agornostal/ulauncher -y

### install kubectx ###
cd /tmp
curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx_v0.9.4_linux_x86_64.tar.gz
tar -zxvf kubectx_v0.9.4_linux_x86_64.tar.gz
chmod +x kubectx
mv kubectx /usr/local/bin

### install kubens ###
curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens_v0.9.4_linux_x86_64.tar.gz
tar -zxvf kubens_v0.9.4_linux_x86_64.tar.gz
chmod +x kubens
mv kubens /usr/local/bin

# ### install k8s aliases ###
# wget -P /home/$USER https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
# echo 'source ~/.kubectl_aliases' >> /home/$USER/.zshrc

### VISUAL CODE ###
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add –
add-apt-repository “deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main”

### install vagrant ####
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

## INSTALL TOOLS ##
apt update
apt install -y apt-transport-https ca-certificates gnupg software-properties-common curl git tilix vim flameshot zsh kubectl helm terraform ulauncher vagrant code

### OhMyZSH
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Tools have been installed successful"