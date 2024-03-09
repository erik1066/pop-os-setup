#!/bin/bash

# ------------------------------------
# Install updates:
# ------------------------------------

sudo apt update && sudo apt dist-upgrade -y


# ------------------------------------
# Install dev tools and some themes:
# ------------------------------------

sudo apt install -y \
openjdk-8-jdk-headless \
openjdk-11-jdk-headless \
openjdk-17-jdk-headless \
maven \
python3-minimal \
build-essential \
apt-transport-https \
ca-certificates \
curl \
software-properties-common \
apache2-utils \
make \
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
# Install GoLang 1.22.1:
# ------------------------------------

curl -OL https://golang.org/dl/go1.22.1.linux-amd64.tar.gz
sha256sum go1.22.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile


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