# Pop!\_OS 20.04 Setup for Web Developers

This repository contains instructions to set up [Pop!\_OS](https://system76.com/pop) for developing software in Go, Rust, C# (.NET Core), Java, Python, and NodeJS, as well as web front-ends in React. The steps below should also work for Ubuntu and most Ubuntu-based Linux distributions.

![Pop!_OS desktop screenshot with Tilix, Visual Studio Code, and Gnome Tweak Tool, displayed and the Arc Dark theme](images/screenshot01.png "Pop!_OS desktop screenshot with Tilix, Visual Studio Code, and Gnome Tweak Tool, displayed and the Arc Dark theme")

## Update the OS and install common tools

The first thing you should do is get the latest security updates:

```bash
sudo apt update && sudo apt dist-upgrade -y
```

Next, install common development tools:

```bash
sudo apt install \
openjdk-8-jdk-headless \
openjdk-11-jdk-headless \
maven \
build-essential \
apt-transport-https \
ca-certificates \
curl \
software-properties-common \
apache2-utils \
make \
chromium-browser \
gnome-tweak-tool \
gnome-shell-extensions \
python3-pip \
dconf-editor \
libgconf-2-4
```

Cleanup:

```bash
sudo apt autoremove -y
sudo apt autoclean -y
```

Check for firmware updates:

```bash
sudo fwupdmgr get-devices
sudo fwupdmgr get-updates
sudo fwupdmgr update
```

Reboot before proceeding any further:

```bash
sudo reboot now
```

## Improve Font Rendering

The default font rendering in Pop!\_OS may appear blurry on LCD monitors. Gnome's OS settings application lacks the ability to change font rendering. You must install the Gnome Tweak Tool to adjust these settings. Gnome Tweak Tool can be installed from the Pop!\_Shop or from a terminal as shown below:

1. Run `sudo apt install gnome-tweak-tool`
1. Run `gnome-tweaks`
1. **Fonts** > **Hinting** > Set to "Full"
1. **Fonts** > **Antialiasing** > Set to "Subpixel (for LCD screens)"

## Install Microsoft fonts

If you need to work with documents that are built using Microsoft fonts:

```bash
sudo apt install -y mscorefonts-installer
sudo fc-cache -f -v
```

## Increase the inotify watch count

When working with Dropbox, React, and NodeJS, you may run into the following error: "User limit of inotify watches reached". The default limit for file watchers is 8,192. Increase this limit to something more reasonable:

1. Run `sudo gedit /etc/sysctl.conf`
1. Add `fs.inotify.max_user_watches=10000000` to the bottom of the file
1. Run `sudo sysctl -p` (or restart the OS)

## Tilix

Tilix may be preferable to the default Gnome terminal:

```bash
sudo apt install tilix
```

## Z Shell (ZSH)

[ZSH](https://en.wikipedia.org/wiki/Z_shell) can be installed by running:

```bash
sudo apt install zsh
```

Run `zsh --version` and look for `zsh 5.8 (x86_64-ubuntu-linux-gnu)` (or newer) to verify success

### Optional: Install Oh-My-ZSH for ZSH configuration management
[Oh-My-ZSH](https://github.com/ohmyzsh/ohmyzsh) is an excellent tool for managing your ZSH configuration. Install it using the following command:

```bash
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/
install.sh -O -)"
```

An "Oh My Zsh!... is now installed" message should appear in the terminal output. You may be prompted to set ZSH as your default shell.

### Optional: Enable ZSH syntax highlighting
Install syntax highlighting for ZSH by running:

```bash
sudo apt install zsh-syntax-highlighting
```

Now run:

```bash
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
```

The changes will be applied to new terminal windows.

### Optional: Change ZSH theme using Oh-My-ZSH

Oh-My-ZSH is installed with [several themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes). Let's change the default theme to `blinks` by first opening the `.zshrc` file:

```bash
sudo gedit ~/.zshrc
```

Find the line `ZSH_THEME="robbyrussell"` and change it to `ZSH_THEME="blinks"` and save. The new theme will be applied to new terminal windows.

### Optional: Enable ZSH plugins

Plugins add functionality to ZSH. Let's enable some [pre-installed plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) for a few programming languages. First, open the `.zshrc` file:

```bash
sudo gedit ~/.zshrc
```

Find the line `plugins=(git)` and change it to include your preferred plugins. An example:

```
plugins=(git dotnet rust rustup golang mvn npm terraform aws gradle)
```

Save the file. The plugins will be applied to new terminal windows.

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

7. Press <kbd>CTRL</kbd>+<kbd>X</kbd> to exit Nano and save when prompted
1. Navigate to **Activities** on the main PopOS desktop and select **Show Applications**
1. Right-click on **Spring Tool Suite** and select **Add to favorites**
1. Open Spring Tool Suite
1. **Window** > **Preferences** > **General** > Set the theme to "Dark"
1. **Window** > **Preferences** > **Maven** > Select "Download repository index updates on startup"
1. Select **Apply and Close**

## Visual Studio Code:

1. From the desktop, select **Activities** (top-left corner of your monitor) > **Pop!\_Shop**
1. Search for "Visual Studio Code" and install it
1. Launch Visual Studio Code
1. Disable Microsoft's telemetry by navigating to **File** > **Preferences** > **Settings** and typing "telemetry", then de-selecting "Enable Crash Reporter" and de-selecting "Enable Telemetry"
1. Optional: While still in **Settings**, change the **Titlebar** setting to "Custom" if not done so already
1. Optional: While still in **Settings**, change the following to "False":
   1. **Enable Natural Language Search**
   1. **Enable Experiments**
   1. **Enable Windows Background Updates**
1. Optional: While still in **Settings**, enable **Editor: Format on Save**. Turning this setting on is the same as running the **Format Document** command each time you save a file.
1. Optional: While Visual Studio Code is open, select **Activities**, right-click the Visual Studio Code icon on the dock, and select **Add to favorites**.

The following VS Code extensions are handy:

1. [C#](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) - syntax highlighting, debugging, test runner support, and intellisense for C#
1. [C# XML documentation](https://marketplace.visualstudio.com/items?itemName=k--kato.docomment) - auto-generates C# XML documentation
1. [Rust (rls)](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust) - Rust language server
1. [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb) - for debugging Rust code on Ubuntu
1. [Java Extension Pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack) - syntax highlighting, debugging, and intellisense for Java, plus unit testing support
1. [Spring Boot Extension Pack](https://marketplace.visualstudio.com/items?itemName=Pivotal.vscode-boot-dev-pack) - specific enhancements for working with Spring Boot
1. [VS Live Share](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare) - allows simultaneous editing of code files by multiple authors, like Google Docs
1. [Docker](https://marketplace.visualstudio.com/items?itemName=PeterJausovec.vscode-docker)
1. [JavaScript Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)
1. [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
1. [Go](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Go)
1. [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
1. [TSLint](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-typescript-tslint-plugin)
1. [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
1. [AWS Toolkit](https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.aws-toolkit-vscode)

There are some excellent dark theme alternatives to the VS Code default theme:

1. [One Monokai Theme](https://marketplace.visualstudio.com/items?itemName=azemoh.one-monokai)
1. [Atom One Dark Theme](https://marketplace.visualstudio.com/items?itemName=akamud.vscode-theme-onedark)
1. [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme)
1. [Blueberry Dark Theme](https://marketplace.visualstudio.com/items?itemName=peymanslh.blueberry-dark-theme)
1. [Arc+ Theme](https://marketplace.visualstudio.com/items?itemName=ph-hawkins.arc-plus)

## Postman

Postman can be installed in one of three ways. The easiest is to open the **Pop!_Shop** and install Postman using the GUI. 

> Installing Postman from **Pop!_Shop** installs from Flathub. 

### Alternative: Install Postman from flathub using the terminal

You may alternatively install Postman from Flathub using a terminal session. However, in Pop!_OS 20.04, you must first add the Flathub remote repository. Both commands are shown below:

```bash
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.getpostman.Postman
```

### Alternative: Install Postman from .tar.gz using the terminal

```bash
sudo apt install libgconf-2-4
cd ~/Downloads
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
sudo tar -xzf postman.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman

cat > ~/.local/share/applications/postman.desktop <<EOL
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOL
```

Be sure to pin Postman by adding it to your favorites:

1. Navigate to **Activities** on the main Pop_OS! desktop and select **Show Applications**
1. Right-click on **Postman** and select **Add to favorites** 

## Java and Maven

```bash
sudo apt install openjdk-11-jdk-headless maven
```

Run `javac -version` and look for the following output to verify success:

```
openjdk version "11.0.10" 2021-01-19
OpenJDK Runtime Environment (build 11.0.10+9-Ubuntu-0ubuntu1.20.04)
OpenJDK 64-Bit Server VM (build 11.0.10+9-Ubuntu-0ubuntu1.20.04, mixed mode, sharing)
```

## Go

```bash
sudo apt install golang-go
```

Run `go version` and look for `go version go1.10.4 linux/amd64` (or newer) to verify success

## Rust

```bash
curl https://sh.rustup.rs -sSf | sh
```

Restart your terminal session, run `rustc --version`, and look for `rustc 1.46.0 (04488afe3 2020-08-24)` (or newer) to verify success.

> Alternatively, you may run `sudo apt install cargo`.

You will want to periodically update Rust to the latest version. Do so by running:

```bash
rustup update
```

## Python

```bash
sudo apt install python3-minimal
```

Run `python3 --version` and look for `Python 3.6.9` (or newer) to verify success

To install Anaconda Python instead, see https://linuxhint.com/install_anaconda_python_ubuntu_1804/.

## NodeJS

```bash
sudo apt install build-essential
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install nodejs
```

Run `npm --version` and look for `7.5.4` (or newer) to verify success

You will want to periodically update NPM to the latest version. Do so by running:

```bash
sudo npm install -g npm
```

### Removing NodeJS

The way in which NodeJS is installed means a few extra steps are needed to remove it:

```bash
sudo apt-get remove nodejs
sudo apt-get remove npm
sudo rm /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
which node
which nodejs
which npm
```

The three `which` commands should all display nothing, indicating Node's successful removal.

## .NET Core

```bash
sudo apt install apt-transport-https ca-certificates
cd ~/Downloads
wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update && sudo apt install -y dotnet-sdk-2.1 dotnet-sdk-3.1 dotnet-sdk-5.0
rm -f packages-microsoft-prod.deb
```

Run `dotnet --list-sdks` and look for the following output to verify success:

```
2.1.814 [/usr/share/dotnet/sdk]
3.1.407 [/usr/share/dotnet/sdk]
5.0.201 [/usr/share/dotnet/sdk]
```

### Optional: Disable .NET Core telemetry

1. Run `gedit ~/.profile`
1. Type `export DOTNET_CLI_TELEMETRY_OPTOUT=true` at the bottom of the file
1. Save and exit
1. Log out and log in again

> You can also set `DOTNET_SKIP_FIRST_TIME_EXPERIENCE` to `true` when editing `.profile` to fix the following warning that may appear during .NET Core compiles: "Permission denied to modify the '/usr/share/dotnet/sdk/NuGetFallbackFolder' folder."

### Optional: Installing .NET Core preview releases

Preview releases of .NET Core are unavailable from `packages.microsoft.com` and must be installed manually. The script below assumes you've downloaded a preview release with a filename of `dotnet-sdk-3.0.100-preview8-013656-linux-x64.tar.gz`.

```
mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-3.0.100-preview8-013656-linux-x64.tar.gz -C $HOME/dotnet
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet
```

> If you've installed a stable .NET Core release from `packages.microsoft.com`, then you will need to use a different command to update PATH. Otherwise only the stable version of .NET Core will be found at the command line. To make sure the preview release is used when running `dotnet`, instead execute `export PATH=$HOME/dotnet:$PATH`.

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

# Running "docker --version" should display "Docker version 19.03.12, build 48a66213fe" or newer

sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Running "docker-compose --version" should display "docker-compose version 1.28.2, build 67630359"

sudo usermod -aG docker $USER

# Restart the machine
```

After restarting the machine, run `docker run hello-world` and look for a "Hello from Docker!" message.

## Azure CLI tools

```bash
# Get packages needed for the install process:
sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg

# Download and install the Microsoft signing key:
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

# Add the Azure CLI software repository:
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

# Update repository information and install the azure-cli package:
sudo apt-get update
sudo apt-get install azure-cli
```

Verify success by running `az --version` and checking that `azure-cli 2.21.0` (or newer) appears somewhere in the output. Additionally, the output should indicate that `Your CLI is up-to-date`.

> See [Install Azure CLI with apt](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest) for further information.

## Azure Storage Explorer

Azure's desktop app for interacting with Azure Storage is cross-platform. Installing it on an Ubuntu-based distribution can be done as follows:

```bash
sudo apt update && sudo apt install -y dotnet-sdk-2.1 build-essential libsecret-1-0 libgconf-2-4
wget https://download.microsoft.com/download/A/E/3/AE32C485-B62B-4437-92F7-8B6B2C48CB40/StorageExplorer-linux-x64.tar.gz -O ~/Downloads/StorageExplorer-linux-x64.tar.gz
cd ~/Downloads
mkdir -p ~/azure-storage-explorer
tar xvf StorageExplorer-linux-x64.tar.gz -C ~/azure-storage-explorer
cd ~/azure-storage-explorer
./StorageExplorer
```

Next, create an application icon, making sure that you replace `yourusername` with your actual user name:

```bash
cat > ~/.local/share/applications/azurestorageexplorer.desktop <<EOL
[Desktop Entry]
Encoding=UTF-8
Name=Azure Storage Explorer
Comment=Azure Storage Explorer
Exec=/home/yourusername/azure-storage-explorer/StorageExplorer
Icon=/home/yourusername/azure-storage-explorer/resources/app/out/app/icon.png
Terminal=false
Type=Application
Keywords=Azure,IDE,Development,Storage,Data
Categories=Development;IDE;
EOL
```

Azure Storage Explorer should now appear in your list of applications. If it doesn't appear after creating and saving the `.desktop` file, then you may need to log out and log in.

## AWS CLI tools

The following script installs v2 of the AWS CLI tools:

```bash
sudo apt install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo ./aws/install
```

Run `aws --version` and check for `aws-cli/2.1.34 Python/3.8.8 Linux/4.4.0-19041-Microsoft exe/x86_64.ubuntu.20 prompt/off` to verify success.

> See https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html for additional information.

## GitHub CLI tools

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh
```

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
1. Run `ssh -T git@github.com` to [verify the key is recognized and working with GitHub.com](https://help.github.com/en/github/authenticating-to-github/githubs-ssh-key-fingerprints)
1. Run `ssh -T git@gitlab.com` to verify the key is recognized and working with GitLab

## GPG Keys for signing commits

Taken from https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/index.html.

1. Run `gpg --full-gen-key`
1. Choose "RSA and RSA (default)"
1. Choose 4096 bits
1. Choose 2y (or a timeframe of your choosing)
1. Provide the other required inputs
1. Run `gpg --list-secret-keys --keyid-format LONG mr@robot.sh` (replace `mr@robot.sh` with the email you used previously)
1. Copy the GPG key ID that starts with `sec`. E.g. in `sec rsa4096/30F2B65B9246B6CA 2017-08-18 [SC]`, the key ID is `30F2B65B9246B6CA`
1. Run `gpg --armor --export 30F2B65B9246B6CA`
1. Run `git config --global user.signingkey 30F2B65B9246B6CA`
1. [Add the key to your GitHub account](https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account/)

To sign commits, the only difference is the addition of the `-S` flag:

```bash
git commit -S -m "My commit msg"
```

## VLC for media playback

```bash
sudo apt install -y vlc
sudo apt install -y libavcodec-extra libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg
```

## Other Items in Pop!\_Shop to consider installing:

1. Dropbox
1. Slack
1. Spotify
1. VirtualBox
1. Zoom
1. Microsoft Teams
1. VLC - for playing media files
1. Peek - for recording your screen and producing animated GIFs
1. GNU Image Manipulation Program
1. Htop
1. Bleachbit - for secure file erasure and general disk cleanup

## VirtualBox

1. From the desktop, select **Activities** (top-left corner of your monitor) > **Pop!\_Shop**
1. Search for "VirtualBox" and install it

To allow USB pass-through to a guest OS in VirtualBox:

1. Run `sudo adduser $USER vboxusers`
1. Log out and in again

## Firefox

1. Install the [React Developer Tools](https://addons.mozilla.org/en-US/firefox/addon/react-devtools/) addon
1. **Preferences** > **Search** > Change the search engine to "[DuckDuckGo](https://duckduckgo.com/)" (or your preferred engine)
1. **Preferences** > **Privacy** > Change tracking and protection settings as-needed

### Optional: Enable DNS over HTTPS

1. Navigate to **Edit** > **Preferences**
1. In the **General** tab, scroll down to **Network Settings** and press the **Settings** button
1. Select **Enable DNS over HTTPS** and select "Cloudflare" as the provider

### Optional: Force GPU rendering to smooth out page scrolling

Firefox in Gnome can experience screen tearing and other performance-inhibiting behavior. This may be adjustable by forcing GPU rendering, though it may impact power usage and stability. This has only been tested using NVIDIA GPUs.

1. Navigate to `about:config` in the Firefox URL bar
1. Select **Accept the Risk and Continue**
1. Copy and paste `layers.acceleration.force-enabled` into the search box and **Enable** it
1. Copy and paste `layers.force-active` into the search box and **Enable** it
1. Restart Firefox and observe smoother scrolling behavior

## Chromium

1. From the desktop, select **Activities** (top-left corner of your monitor) > **Pop!\_Shop**
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

Google Chrome is a commercial, closed-source product. It's based on the open source Chromium project. If you'd like to use Chromium for JavaScript debugging instead of Chrome, you can still follow Microsoft's guide. You'll just need to add a `runtimeExecutable` property to the `launch.json` file in your web app's `.vscode` directory. Just make sure it points to where `chromium-browser` is installed. If you installed Chromium from the Pop!\_Store then it should be located at `/usr/bin/chromium-browser`.

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

## Installing and Enabling Themes

Some themes are available in the central repos. For instance, to install the excellent Arc theme, simply run `sudo apt install arc-theme`. "Arc-Dark" is then available as a theme in **Gnome Tweak Tool**.

More themes are available for download on pling.com. For these, extra steps are required to install:

1. Create folders for the themes and icons:

```bash
mkdir ~/.themes
mkdir ~/.icons
```

2. Download a Gnome theme from Pling to your `Downloads` folder. (We'll use the [WhiteSur GTK theme](https://www.pling.com/p/1403328/))
1. Extract the contents of the `.tar.xz` to the `.themes` folder
1. Download a Gnome icon theme from Pling to your `Downloads` folder. (We'll use the [Big Sur Icon Theme](https://www.pling.com/p/1399044/))
1. Extract the contents of the `.tar.xz` to the `.icons` folder
1. Open the **Gnome Tweak Tool**
1. Navigate to the **Extensions** tab
1. Enable **User Themes**
1. Navigate to the **Apperance** tab
1. Select "White Sur-Dark" under **Themes** > **Applications**
1. Close **Gnome Tweak Tool**

## Installing Cairo Dock

The [Cairo Dock](https://github.com/Cairo-Dock/cairo-dock-core) adds a launcher and a taskbar to your desktop.

```bash
sudo apt install cairo-dock
```

Once installed, you will want to enable it as a startup application:

1. Open **Gnome Tweak Tools**
1. Navigate to **Startup Applications**
1. Press the **+** button to add a startup application
1. Select **Cairo Dock**

The Cairo Dock can be themed. Let's install the McOs BS theme to see how we can make Gnome look more like macOS Big Sur.

1. Visit https://www.pling.com/p/1401527/. 
1. Under **Files**, download the **mcOS-BS-Dark.tar.gz** file and save it to your **Downloads** folder.
1. Open **Cairo Dock** (if not already open) 
1. Right-click on the **Applications** icon. A context menu appears.
1. Select **Cairo Dock** > **Configure**. The Cairo Dock configuration window appears.
1. Navigate to the **Themes** tab
1. Select the **Import** button at the bottom-right corner of the window. A file dialog appears.
1. Select the "mcOS-BS-Dark.tar.gz" file in your **Downloads** folder and press the window's **OK** button.


## Installing Fonts

Install the **Font Manager** application:

```bash
sudo apt install font-manager
```

Let's install Red Hat's free Overpass font. It can be downloaded or cloned: https://github.com/RedHatOfficial/Overpass. 

Open **Font Manager** and press the **+** button to add a new font. Navigate to the extracted ZIP file (or cloned git repo) and import either the OTF or TTF files, whichever you prefer.

Open **Gnome Tweak Tool** and open the **Fonts** tab. Select "Overpass" from the **Interface Text** drop-down list. The changes should be visible immediately.

> Some custom fonts, including "Overpass", may look better with **Hinting** set to "None".
