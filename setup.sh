#!/bin/bash

# ------------------------------------
# Install updates:
# ------------------------------------

sudo apt update && sudo apt dist-upgrade -y


# ------------------------------------
# Install dev tools and some themes:
# ------------------------------------

sudo apt install -y \
python3-minimal \
build-essential \
apt-transport-https \
ca-certificates \
curl \
software-properties-common \
apache2-utils \
make \
unzip \
chromium-browser \
gnome-tweaks \
gnome-shell-extensions \
python3-pip \
libgconf-2-4 \
arc-theme \
tilix


# ------------------------------------
# Add Flathub.org as a Flatpak repo
# ------------------------------------

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


# ------------------------------------
# Install Visual Studio Code
# ------------------------------------

sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code


# ------------------------------------
# Install Azure Storage Explorer
# ------------------------------------

# flatpak install flathub com.microsoft.AzureStorageExplorer


# ------------------------------------
# Install Eclipse for Java Developers
# ------------------------------------

# flatpak install flathub org.eclipse.Java


# ------------------------------------
# Install JetBrains Products
# ------------------------------------

# flatpak install flathub com.jetbrains.Rider
# flatpak install flathub com.jetbrains.GoLand
# flatpak install flathub com.jetbrains.PyCharm-Professional
# flatpak install flathub com.jetbrains.IntelliJ-IDEA-Ultimate


# ------------------------------------
# Install Terraform:
# ------------------------------------

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform


# ------------------------------------
# Install NodeJS:
# ------------------------------------

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
echo "fs.inotify.max_user_watches=10000000" | sudo tee -a /etc/sysctl.conf
node --version


# ------------------------------------
# Install .NET Core and turn off .NET Core telemetry:
# ------------------------------------

echo "export DOTNET_CLI_TELEMETRY_OPTOUT=true" >> ~/.profile
sudo apt update && sudo apt install dotnet-sdk-8.0 -y
dotnet --version


# ------------------------------------
# Install Postman:
# ------------------------------------

sudo flatpak install flathub com.getpostman.Postman


# ------------------------------------
# Install GoLang 1.23.0:
# ------------------------------------

curl -OL https://golang.org/dl/go1.23.0.linux-amd64.tar.gz
sha256sum go1.23.0.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz
echo "export PATH=$PATH:$(go env GOPATH)/bin:/usr/local/go/bin" >> ~/.profile
source ~/.profile


# ------------------------------------
# Install Helm
# ------------------------------------

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


# ------------------------------------
# Install Azure CLI tools
# ------------------------------------

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash


# ------------------------------------
# Install AWS CLI tools
# ------------------------------------

sudo apt install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install


# ------------------------------------
# Install GitHub CLI tools:
# ------------------------------------

type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y


# ------------------------------------
# Install VLC:
# ------------------------------------

sudo apt install -y vlc
sudo apt install -y libavcodec-extra libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg