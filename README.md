# Pop!_OS 18.04 Setup for Microservice and Web App Developers

Instructions to make [Pop!_OS](https://system76.com/pop) setup fast and efficient for developing microservices in C# (.NET Core), Java, Python, and NodeJS, as well as web front-ends in React. These instructions should also work for Ubuntu and most Ubuntu-based Linux distributions.

## Update the OS and install common tools

The first thing you should do is get the latest security updates:

```bash
sudo apt update && sudo dist-upgrade -y
```

Next, install some common tools you'll need later:

```bash
sudo apt install \
openjdk-8-jdk-headless \
maven \
build-essential \
apt-transport-https \
ca-certificates \
curl \
software-properties-common \
apache2-utils \
make \
chromium-browser \
gnome-tweak-tool
```

## Enable Dark Mode and Improve Font Rendering

I'm not a fan of the default font rendering in Pop!_OS. I also happen to enjoy using the OS's dark mode. However, Gnome's OS settings app doesn't include options for themes and fonts. For that you must install the Gnome Tweak Tool. You can install it from the Pop!_Shop or from a terminal as shown below:

1. Run `sudo apt install gnome-tweak-tool`
1. Run `gnome-tweaks`
1. **Appearance** > **Themes** > **Applications** : Set to "Pop-dark" or "Adwaita-dark"
1. **Fonts** > **Hinting** > Set to "Full"
1. **Fonts** > **Antialiasing** > Set to "Subpixel (for LCD screens)"

## Increase the inotify watch count

When working with Dropbox, React, and NodeJS, you may run into this error: "User limit of inotify watches reached". The default limit for file watchers is 8,192. Increase this limit to something more reasonable:

1. Run `sudo gedit /etc/sysctl.conf`
1. Add `fs.inotify.max_user_watches=100000` to the bottom of the file
1. Run `sudo sysctl -p` (or restart the OS)

## Spring Tool Suite (STS) 4:

1. Visit https://spring.io/tools
1. Download the "STS4" Linux package to the "Downloads" folder
1. Run `cd ~/Downloads`
1. Run `sudo tar -xvf spring-tool-suite-4-4.0.1.RELEASE-e4.9.0-linux.gtk.x86_64.tar.gz` (replace the filename shown here with the one you downloaded, if newer)
1. Run `sudo nano /usr/share/applications/STS.desktop`
1. Type the following, replacing `Exec=` with the actual location of STS:

```ini
[Desktop Entry]
Name=Spring Tool Suite
Comment=Spring Tool Suite
Exec=/home/yourusername/Downloads/sts-4.0.1.RELEASE/SpringToolSuite4
Icon=/home/yourusername/Downloads/sts-4.0.1.RELEASE/icon.xpm
StartupNotify=true
Terminal=false
Type=Application
Keywords=Java,Eclipse,Spring,IDE,Development
Categories=Development;IDE;Java;
```

7. Press `CTRL`+`X` to exit Nano and save when prompted
1. Navigate to **Activities** on the main PopOS desktop and select **Show Applications**
1. Right-click on **Spring Tool Suite** and select **Add to favorites**
1. Open Spring Tool Suite
1. **Window** > **Preferences** > **General** > Set the theme to "Dark"
1. **Window** > **Preferences** > **Maven** > Select "Download repository index updates on startup"
1. Select **Apply and Close**

## Visual Studio Code:

1. From the desktop, select **Activities** (top-left corner of your monitor) > **Pop!_Shop**
1. Search for "Visual Studio Code" and install it
1. Launch Visual Studio Code
1. Disable Microsoft's telemetry by navigating to **File** > **Preferences** > **Settings** and typing "telemetry", then de-selecting "Enable Crash Reporter" and de-selecting "Enable Telemetry"
1. Optional: While still in **Settings**, change the **Titlebar** setting to "Custom" if not done so already
1. Optional: While still in **Settings**, change the following to "False":
    1. **Enable Natural Language Search**
    1. **Enable Experiments**
    1. **Enable Windows Background Updates**
1. Optional: While Visual Studio Code is open, select **Activities**, right-click the Visual Studio Code icon on the dock, and select **Add to favorites**.

The following VS Code extensions are handy:
1. [C#](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) - syntax highlighting, debugging, test runner support, and intellisense for C#
1. [C# XML documentation](https://marketplace.visualstudio.com/items?itemName=k--kato.docomment) - auto-generates C# XML documentation
1. [Java Extension Pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack) - syntax highlighting, debugging, and intellisense for Java, plus unit testing support
1. [Spring Boot Extension Pack](https://marketplace.visualstudio.com/items?itemName=Pivotal.vscode-boot-dev-pack) - specific enhancements for working with Spring Boot
1. [VS Live Share](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare) - allows simultaneous editing of code files by multiple authors, like Google Docs
1. [Docker](https://marketplace.visualstudio.com/items?itemName=PeterJausovec.vscode-docker)
1. [JavaScript Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)
1. [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
1. [Go](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Go)

There are some excellent dark theme alternatives to the VS Code default theme:

1. [One Monokai Theme](https://marketplace.visualstudio.com/items?itemName=azemoh.one-monokai)
1. [Atom One Dark Theme](https://marketplace.visualstudio.com/items?itemName=akamud.vscode-theme-onedark)
1. [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme)


## Postman

1. Visit https://www.getpostman.com/downloads/
1. Download the 64-bit Linux package to the "Downloads" folder
1. Extract the contents of the package to a `Postman` directory underneath `Downloads`
1. Run `sudo nano /usr/share/applications/Postman.desktop`
1. Type the following, replacing `Exec=` with the actual location of Postman:

```ini
[Desktop Entry]
Name=Postman
Comment=Postman
Exec=/home/yourusername/Downloads/Postman/Postman
StartupNotify=true
Terminal=false
Type=Application
Keywords=Development
Categories=Development
```

6. Press `CTRL`+`X` to exit Nano and save when prompted
1. Navigate to **Activities** on the main PopOS desktop and select **Show Applications**
1. Right-click on **Postman** and select **Add to favorites**

### Alternative: Use Snap

Ubuntu Snap can also be used to install Postman on Pop!_OS 18.04. However, Postman won't respect your theme selection when installed via Snap.

```bash
sudo apt install snapd
snap install postman
```

The command `/snap/bin/postman` will start Postman. To add Postman to `PATH`, run `nano ~/.profile`, add `export PATH=$PATH:/snap/bin` at the bottom of the file, save, and log out and in again. You can then run `postman` from the command prompt.

## Java and Maven

```bash
sudo apt install openjdk-8-jdk-headless maven
```

Run `javac -version` and look for `javac 1.8.0_191` (or newer) to verify success

## Go

```bash
sudo apt install golang-go
```

Run `go version` and look for `go version go1.10.4 linux/amd64` (or newer) to verify success

## Python 

```bash
sudo apt install python3-minimal
```

Run `python3 -V` and look for `Python 3.7.1` (or newer) to verify success

To install Anaconda Python instead, see https://linuxhint.com/install_anaconda_python_ubuntu_1804/.

## NodeJS

```bash
sudo apt install build-essential
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install nodejs
```

Run `npm --version` and look for `6.7.0` (or newer) to verify success

Periodically, you will want to update NPM to the latest available version. Do so by running:

```bash
sudo npm install -g npm
```

## .NET Core

```bash
sudo apt install apt-transport-https ca-certificates
cd ~/Downloads
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update && sudo apt install dotnet-sdk-2.2 -y
rm -f packages-microsoft-prod.deb
```

Run `dotnet --version` and look for `2.2.104` (or newer) to verify success

### Optional: Disable .NET Core telemetry

1. Run `gedit ~/.profile`
1. Type `export DOTNET_CLI_TELEMETRY_OPTOUT=true` at the bottom of the file
1. Type `export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true` at the bottom of the file
1. Save and exit
1. Log out and log in again

> Setting `DOTNET_SKIP_FIRST_TIME_EXPERIENCE` to `true` doesn't affect telemtry. It's a fix for the following warning that may appear during .NET Core compilation: "Permission denied to modify the '/usr/share/dotnet/sdk/NuGetFallbackFolder' folder."

## Docker and Docker Compose

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# Running "sudo apt-key fingerprint 0EBFCD88" should display:

# pub   rsa4096 2017-02-22 [SCEA]
#       9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
# uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
# sub   rsa4096 2017-02-22 [S]

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce
docker --version

# Running "docker --version" should display "Docker version 18.09.2, build 6247962" or similar

sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Running "docker-compose --version" should display "docker-compose version 1.23.2, build 1110ad01" or similar

sudo usermod -aG docker $USER

# Restart the machine
```

After restarting the machine, run `docker run hello-world` and look for a "Hello from Docker!" message.

## Git configuration

```bash
git config --global user.name "Your Name"
git config --global user.email yourname@yourdomain.com
```

See [Customizing Git Configuration](https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration) for more details. You can edit the global Git config file by running `gedit ~/.gitconfig` in a terminal window. 

## SSH Keys for GitHub/GitLab

1. Run `ssh-keygen -o -t rsa -b 4096 -C "your comment goes here"`
1. Enter a passphrase
1. Run `cat ~/.ssh/id_rsa.pub`
1. Copy the output from `cat` and paste it into GitLab and GitHub's SSH key sections for your profile
1. Run `ssh -T git@gitlab.com` to verify the key is recognized and working with GitLab
1. Run `ssh -T git@github.com` to verify the key is recognized and working with GitHub.com

## GPG Keys for signing commits

Taken from https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/index.html. 

1. Run `gpg --full-gen-key`
1. Choose "RSA and RSA (default)"
1. Choose 4096 bits
1. Choose 2y (or a timeframe of your choosing)
1. Provide the other required inputs
1. Run `gpg --list-secret-keys --keyid-format LONG mr@robot.sh` (replace `mr@robot.sh` with the email you used previously)
1. Copy the GPG key ID that starts with `sec`. E.g. in `sec   rsa4096/30F2B65B9246B6CA 2017-08-18 [SC]`, the key ID is `30F2B65B9246B6CA`
1. Run `gpg --armor --export 30F2B65B9246B6CA`
1. Run `git config --global user.signingkey 30F2B65B9246B6CA`
1. [Add the key to your GitHub account](https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account/)

To sign commits, the only difference is the addition of the `-S` flag:

```bash
git commit -S -m "My commit msg"
```

## Other Items in Pop!_Store to consider installing:

1. Dropbox
1. Slack
1. Spotify
1. VirtualBox
1. VLC - for playing media files
1. Peek - for recording your screen and producing animated GIFs
1. Htop

## VirtualBox

1. From the desktop, select **Activities** (top-left corner of your monitor) > **Pop!_Shop**
1. Search for "VirtualBox" and install it

To allow USB pass-through to a guest OS in VirtualBox:

1. Run `sudo adduser $USER vboxusers`
1. Log out and in again

## Firefox

1. Install the [React Developer Tools](https://addons.mozilla.org/en-US/firefox/addon/react-devtools/) addon
1. **Preferences** > **Search** > Change the search engine to "[DuckDuckGo](https://duckduckgo.com/)" (or your preferred engine)
1. **Preferences** > **Privacy** > Change tracking and protection settings as-needed

## Chromium

1. From the desktop, select **Activities** (top-left corner of your monitor) > **Pop!_Shop**
1. Search for "Chromium Browser" and install it
1. Navigate to https://chrome.google.com/webstore/category/extensions and search for "React Developer Tools"
1. Add the [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi) to Chromium

### Optional: Change Chromium's privacy settings

1. In Chromium, press the "..." button at the top-right corner of the Chromium window to bring up the options menu
1. **Settings** > **Search Engine** > Set to "Duck Duck Go" (or your preferred engine)
1. **Settings** > **Advanced** > **Privacy & Security** > 
    1. **Allow Chromium sign-in** > Disable
    1. **Use a prediction service to help complete searches and URLs typed in the address bar** > Disable
    1. **Use a web service to help resolve navigation errors** > Disable
    1. **Send a "Do Not Track" request with your browsing traffic** > Enable
    1. **Allow sites to check if you have payment methods saved** > Disable
    1. **Content Settings** > 
        1. **Cookies** > **Block third-party cookies** > Enable
        1. **Location** > Block
        1. **Microphone** > Block
        1. **Camera** > Block
        1. **Flash** > Set to "Block sites from running Flash"
        1. **Clipboard** > Set to "Do not allow sites to see text and images copied to the clipboard"
        1. **Payment Handlers** > Set to "Do not allow any site to install payment handlers"

### FYI: How to configure VS Code for **Chromium** JavaScript debugging

Visual Studio Code can [launch Google Chrome in JavaScript debug mode](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial#_configure-the-chrome-debugger) so developers can do useful things like set breakpoints and inspect JavaScript variables at runtime. However, [Microsoft's official guidance on how to configure the Chrome Debugger](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial#_configure-the-chrome-debugger) only works with _Chrome_ and not _Chromium_.

Google Chrome is a commercial, closed-source product. It's based on the open source Chromium project. If you'd like to use Chromium for JavaScript debugging instead of Chrome, you can still follow Microsoft's guide. You'll just need to add a `runtimeExecutable` property to the `launch.json` file in your web app's `.vscode` directory. Just make sure it points to where `chromium-browser` is installed. If you installed Chromium from the Pop!_Store then it should be located at `/usr/bin/chromium-browser`. 

The `launch.json` file will automatically be created if you follow along with [Microsoft's how-to guide](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial#_configure-the-chrome-debugger). 

The `launch.json` file needed to debug using Chromium is shown below:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "chrome",
            "request": "launch",
            "name": "Launch Chrome against localhost",
            "url": "http://localhost:3000",
            "webRoot": "${workspaceFolder}",
            "runtimeExecutable": "/usr/bin/chromium-browser"
        }
    ]
}
```