# Pop!\_OS 22.04 Setup for Software Engineers

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
dconf-editor
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

1. Run `sudo apt install gnome-tweaks`
1. Run `gnome-tweaks`
1. **Fonts** > **Hinting** > Set to "Full"
1. **Fonts** > **Antialiasing** > Set to "Subpixel (for LCD screens)"

> The Pop!_OS defaults are: "Slight" for Hinting and "Standard" for Antialiasing, in case you want to switch back.

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

**Instructions derived from https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH on 2024-02-18**

[ZSH](https://en.wikipedia.org/wiki/Z_shell) can be installed by running:

```bash
sudo apt install zsh
```

Run `zsh --version` and look for `zsh 5.8.1 (x86_64-ubuntu-linux-gnu)` (or newer) to verify success

To set `zsh` as the default shell, run:

```bash
chsh -s $(which zsh)
```

Start a new session. ZSH is now your default shell.

### Optional: Install Oh-My-ZSH for ZSH configuration management
[Oh-My-ZSH](https://github.com/ohmyzsh/ohmyzsh) is an excellent tool for managing your ZSH configuration. Install it using the following command:

```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

An "Oh My Zsh!... is now installed!" message should appear in the terminal output. 

> You may be prompted to set ZSH as your default shell.

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
plugins=(git dotnet rust golang mvn npm terraform aws gradle)
```

Save the file. The plugins will be applied to new terminal windows.

## Install Eclipse for Java Developers

1. From the desktop, select **Activities** (top-left corner of your monitor) > **Pop!\_Shop**
1. Search for "Eclipse" and install "Eclipse for Java Developers"
1. Launch Eclipse

Alternatively, run the following command to install Eclipse from a terminal:

```bash
flatpak install flathub org.eclipse.Java
```

## Install JetBrains products (Rider, GoLand, IntelliJ IDEA Ultimate, etc)

**The instructions for installing JetBrains products are derived from https://www.jetbrains.com/help/idea/installation-guide.html#toolbox and are current as of 2024-03-09**

1. Visit https://www.jetbrains.com/toolbox/app/ and download the JetBrains Toolbox app.
1. Run the following commands, replacing the file name in the example with the file name you downloaded:

```bash
sudo tar -xzf jetbrains-toolbox-2.2.2.20062.tar.gz -C /opt
cd /opt/jetbrains-toolbox-2.2.2.20062
./jetbrains-toolbox
```

3. Select the product that you want to install.

## Install Postman

Postman is a complete toolchain for API developers. It can be installed in one of three ways. The easiest is to open the **Pop!_Shop** and install Postman using the GUI. 

> Installing Postman from **Pop!_Shop** installs from Flathub. 

You may alternatively install Postman from Flathub using a terminal session. 

```bash
flatpak install flathub com.getpostman.Postman
```

## Install Visual Studio Code

**The instructions for installing Visual Studio Code are derived from https://code.visualstudio.com/docs/setup/linux and are current as of 2024-02-19**

1. Run the following commands:

```bash
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
```

2. Launch Visual Studio Code
1. Navigate **File** > **Preferences** > **Settings** and then type "telemetry"
1. Select "off" for the **Telemetry Level** 
1. Disable the "Dotnet Acquisition Extension: Enable Telemetry" option
1. Optional: While still in **Settings**, change the following to "False":
   1. **Enable Natural Language Search**
   1. **Enable Experiments**
1. Optional: While still in **Settings**, enable **Editor: Format on Save**. Turning this setting on is the same as running the **Format Document** command each time you save a file.
1. Optional: While Visual Studio Code is open, select **Activities**, right-click the Visual Studio Code icon on the dock, and select **Add to favorites**.

> While you can install Visual Studio Code from flathub via the Pop!_Shop, doing so will result in problems finding development tools like the .NET SDK. The `.deb` package in Pop!_Shop is also many versions out-of-date. The process outlined above resolves both issues.




The following VS Code extensions are handy:

1. [C# Dev Kit](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit) - syntax highlighting, debugging, test runner support, and intellisense for C#
1. [Rust (rls)](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust) - Rust language server
1. [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb) - for debugging Rust code on Ubuntu
1. [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack) - syntax highlighting, debugging, and intellisense for Java, plus unit testing support
1. [Spring Boot Extension Pack](https://marketplace.visualstudio.com/items?itemName=Pivotal.vscode-boot-dev-pack) - specific enhancements for working with Spring Boot
1. [VS Live Share](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare) - allows simultaneous editing of code files by multiple authors, like Google Docs
1. [Docker](https://marketplace.visualstudio.com/items?itemName=PeterJausovec.vscode-docker)
1. [JavaScript Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)
1. [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
1. [Go](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Go)
1. [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
1. [TSLint](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-typescript-tslint-plugin)
1. [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)

There are some excellent dark theme alternatives to the VS Code default theme:

1. [One Monokai Theme](https://marketplace.visualstudio.com/items?itemName=azemoh.one-monokai)
1. [Atom One Dark Theme](https://marketplace.visualstudio.com/items?itemName=akamud.vscode-theme-onedark)
1. [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme)
1. [Blueberry Dark Theme](https://marketplace.visualstudio.com/items?itemName=peymanslh.blueberry-dark-theme)
1. [Arc+ Theme](https://marketplace.visualstudio.com/items?itemName=ph-hawkins.arc-plus)
1. [Arc Darker Theme](https://marketplace.visualstudio.com/items?itemName=alvesvaren.arc-dark)



## Java and Maven

```bash
sudo apt install openjdk-17-jdk-headless maven
```

Run `javac -version` and look for the following output to verify success:

```
openjdk version "11.0.10" 2021-01-19
OpenJDK Runtime Environment (build 11.0.10+9-Ubuntu-0ubuntu1.20.04)
OpenJDK 64-Bit Server VM (build 11.0.10+9-Ubuntu-0ubuntu1.20.04, mixed mode, sharing)
```

## Go

**Instructions for installing Go taken from https://go.dev/doc/install on 2024-06-22**

While you _can_ install Go via `apt`, doing so installs an oudated version. Run the following commands instead, ensuring you replace the version number in the commands below with the version number you want to install. These are also the same commands you will use to update Go to a newer version.

```bash
curl -OL https://golang.org/dl/go1.22.4.linux-amd64.tar.gz
sha256sum go1.22.4.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz
```

Run the following command to verify success:

```bash
go version
``` 

Look for `go version go1.22.4 linux/amd64` (or newer) to verify success.

Set the following environment variables if this is the first time you're installing Go. _You do not need to repeat this step if you're upgrading Go._

```bash
echo "export PATH=$PATH:$(go env GOPATH)/bin:/usr/local/go/bin" >> ~/.profile
source ~/.profile
```

[Delve](https://github.com/go-delve/delve) is a debugger for Go. You can install it by running the following command:

```bash
go install github.com/go-delve/delve/cmd/dlv@v1.22.1
```

Run the following command to check that `dlv` is installed and you're on an up-to-date version:

```bash
dlv version
```

You should see the following after running `dlv version`:

```
Delve Debugger
Version: 1.22.1
Build: $Id: 0c3470054da6feac5f6dcf3e3e5144a64f7a9a48
```


## Rust

**Instructions for installing Rust taken from https://www.rust-lang.org/tools/install on 2024-02-18**

```bash
curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs | sh
```

Restart your terminal session, or run `source "$HOME/.cargo/env"`, and then run `rustc --version`. Look for `rustc 1.76.0 (07dca489a 2024-02-04)` (or newer) to verify success.

To update Rust: 

```bash
rustup update
```

## Python

```bash
sudo apt install python3-minimal
```

Run `python3 --version` and look for `Python 3.8.5` (or newer) to verify success

To install Anaconda Python instead, see https://linuxhint.com/install_anaconda_python_ubuntu_1804/.

## NodeJS

The quick way to install NodeJS 20 (LTS):

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
```

Run `node --version`  to verify success.

## .NET Core

```bash
sudo apt install dotnet-sdk-8.0
```

Run `dotnet --list-sdks` and look for the following output to verify success:

```
8.0.102 [/usr/lib/dotnet/sdk]
```

### Optional: Disable .NET Core telemetry

1. Run `gedit ~/.profile`
1. Type `export DOTNET_CLI_TELEMETRY_OPTOUT=true` at the bottom of the file
1. Save and exit
1. Log out and log in again

## Podman

**The instructions for installing Podman are derived from https://podman-desktop.io/downloads and are current as of 2024-06-22**

Podman is an open source alternative to Docker Desktop. To install Podman Desktop client:

```
flatpak install flathub io.podman_desktop.PodmanDesktop
```

To install Podman itself:

```
sudo apt-get update
sudo apt-get -y install podman
```

Podman commands are similar to Docker commands. Example: `podman compose up` instead of `docker-compose up` and `podman ps` instead of `docker ps`. Podman also installs `kubectl` if you select the Kubernetes extension on initial setup.

Run `podman version` and look for the following:

```
Version:      3.4.4
API Version:  3.4.4
Go Version:   go1.18.1
Built:        Wed Dec 31 19:00:00 1969
OS/Arch:      linux/amd64
```

A Podman tutorial is available at https://github.com/containers/podman/blob/main/docs/tutorials/podman_tutorial.md.

## Docker Desktop

**The instructions for installing Docker Desktop are derived from https://docs.docker.com/desktop/install/linux-install/ and are current as of 2024-02-18**

As an alternative to Podman Desktop, Docker Desktop can now be installed on Linux. It provides the same functionality as Docker Desktop on macOS and Windows and includes a single-node Kubernetes cluster. It is recommended to either install Docker Desktop _or_ install Docker on Linux, but not both (though both can be present simultaneously).

This guide has been updated to focus on installing Docker Desktop. 

> You may **not** want to install Docker Desktop if you are running Pop!_OS in a virtual machine, as Docker Desktop installs its own virtual machine; this would be virtualization-within-virtualization and may cause problems. You'd alternatively want to consider installing Docker on Linux directly without "Docker Desktop". This is the traditional way Docker has been installed on Linux. Older versions of this guide describe how this can be done. See [/older-versions](/older-versions).

There is no repository for installing Docker Desktop. 

1. Download the `.deb` package from https://docs.docker.com/desktop/install/ubuntu/.
1. Run `sudo apt-get install ./docker-desktop-<version>-<arch>.deb`
1. Either open the **Docker Desktop** app that was installed, or run `systemctl --user start docker-desktop`

Verify success by running `docker --version`. You should see something like the following:

```
Docker version 25.0.3, build 4debf41
```

## Azure CLI tools

```bash
# Get packages needed for the install process:
sudo apt update
sudo apt install ca-certificates curl apt-transport-https lsb-release gnupg -y

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

Azure's desktop app for interacting with Azure Storage is cross-platform. It is available in the **Pop!\_Shop** via FlatHub. Installing it on an Ubuntu-based distribution can also be done in the terminal as follows:

```bash
flatpak install flathub com.microsoft.AzureStorageExplorer
```

## AWS CLI tools

The following script installs v2 of the AWS CLI tools:

```bash
sudo apt install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo ./aws/install
```

Run `aws --version` and check for `aws-cli/2.1.34 Python/3.8.8 Linux/4.4.0-19041-Microsoft exe/x86_64.ubuntu.20 prompt/off` to verify success.

> See https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html for additional information.

## Kubernetes CLI tools (`kubectl`)

**Instructions derived from https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/ on 2024-02-18**

You may not need to follow these commands to install `kubectl` if you installed Docker Desktop. Run `kubectl version` to see if it's already installed. If not, follow the commands below:

```bash
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl
# If the folder `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubectl
```

Run `kubectl version` to verify success.


## GitHub CLI tools

**The instructions for installing GitHub CLI tools are derived from https://github.com/cli/cli/blob/trunk/docs/install_linux.md and are current as of 2024-02-18**

```bash
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

## Git configuration

```bash
git config --global user.name "Your Name"
git config --global user.email yourname@yourdomain.com
```

See [Customizing Git Configuration](https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration) for more details. You can edit the global Git config file by running `gedit ~/.gitconfig` in a terminal window.

> Tip: Remember that you can include a longer commit message by using a second `-m` in your command. Example: `git commit -m "The short message, best ~50 characters" -m "The extended description that can go on however long you want."`

## SSH Keys for GitHub/GitLab

**The instructions for generating SSH keys is derived from https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent. Instructions for adding an SSH key to GitHub is derived from https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account. Both are current as of 2024-02-18**

1. Run `ssh-keygen -t ed25519 -C "your_email@example.com"`
1. Enter a passphrase
1. Run `ssh-add ~/.ssh/id_ed25519`
1. Run `cat ~/.ssh/id_ed25519.pub`
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

## Firefox

1. Install the [React Developer Tools](https://addons.mozilla.org/en-US/firefox/addon/react-devtools/) addon
1. **Preferences** > **Search** > Change the search engine to "[DuckDuckGo](https://duckduckgo.com/)" (or your preferred engine)
1. **Preferences** > **Privacy** > Change tracking and protection settings as-needed

### Optional: Enable DNS over HTTPS

1. Navigate to **Edit** > **Settings**
1. In the **Privacy & Security** tab, scroll down to **Enable DNS over HTTPS** and select **Max Protection**
1. Select "Cloudflare" as the provider

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


## Installing Fonts

Install the **Font Manager** application:

```bash
sudo apt install font-manager
```

Let's install Red Hat's free Overpass font. It can be downloaded or cloned: https://github.com/RedHatOfficial/Overpass. 

Open **Font Manager** and press the **+** button to add a new font. Navigate to the extracted ZIP file (or cloned git repo) and import either the OTF or TTF files, whichever you prefer.

Open **Gnome Tweak Tool** and open the **Fonts** tab. Select "Overpass" from the **Interface Text** drop-down list. The changes should be visible immediately.

> Some custom fonts, including "Overpass", may look better with **Hinting** set to "None".

## VirtualBox

1. From the desktop, select **Activities** (top-left corner of your monitor) > **Pop!\_Shop**
1. Search for "VirtualBox" and install it

To allow USB pass-through to a guest OS in VirtualBox:

1. Run `sudo adduser $USER vboxusers`
1. Log out and in again


## KVM + QEMU + VirtManager

**Instructions derived from https://ubuntu.com/blog/kvm-hyphervisor?ref=itsfoss.com and https://www.youtube.com/watch?v=BgZHbCDFODk**

An alternative to VirtualBox is to use Linux's built-in Kernel Virtual Machine (KVM) plus QEMU and VirtManager for a GUI front-end.

```bash
sudo apt -y install bridge-utils cpu-checker libvirt-clients libvirt-daemon qemu qemu-kvm virt-manager
```

Check that your processor supports virtualization:

```bash
kvm-ok
```

Look for:

```
INFO: /dev/kvm exists
KVM acceleration can be used
```

Add the current user to the kvm group, being sure to replace `yourusername` with your actual user name:

```bash
sudo usermod -aG libvirt yourusername
sudo usermod -aG kvm yourusername
```

Restart your system and then run these commands:

```bash
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
```

### Create a new VM using `virt-manager`
1. Download a [Pop!_OS ISO](https://pop.system76.com/) or the ISO of your choice
1. Place the `.iso` file into the `/var/lib/libvirt/images` folder
1. Open the **Virtual Machine Manager** (aka `virt-manager`)
1. Add a new virtual machine. Note that if you get a connection error, you should reboot your machine.
1. Select **Local install media** and then **Forward**. Step 2 of 5 appears.
1. Select **Browse**. The ISO you copied into the `/var/lib/libvirt/images` folder should appear.
1. Select the ISO and choose **Choose Volume**
1. You  may need to select an operating system. if Virtual Machine Manager couldn't auto-detect one based on the ISO. In our case, if using Pop!_OS 22.04, select "Ubuntu 22.04 LTS"
1. Select **Forward**
1. Choose at least "8192" for memory and 2 CPUs and then select **Forward**
1. Choose at least 25 GB of disk storage and select **Forward**
1. Use a distinctive name for the VM, such as "K3s-pop-os" and select **Finish**
1. The VM should start automatically. Go through the VM setup process.

Run `sudo apt update && sudo apt upgrade -y` after OS configuration.

### Taking VM snapshots in `virt-manager`

Snapshots can be taken in `virt-manager` just like in Virtual Box. You must navigate into the VM window (not the Virtual Machine Manager window) and select the **Manage VM Snapshots** icon at the far right of the toolbar.

# Set up and connect to MySQL Server running in Docker

**Instructions derived from https://hub.docker.com/_/mysql using MySQL 8.3.0 and are current as of 2024-03-11**

One can run MySQL Server in a Docker container rather than installing MySQL locally. Start a MySQL Docker container by running the following two commands:

```bash
docker network create -d bridge my-bridge-network
docker run --network my-bridge-network -p 3306:3306 --name go-test-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest
```

> The `-p 3306:3306` is what allows you to connect to this MySQL container from the host system, such as what you might do when developing an app.

Next, start a _second_ MySQL container that connects to the first:

```bash
docker run -it --network my-bridge-network --rm mysql mysql -hgo-test-mysql -uroot -pmy-secret-pw
```

You should now see a `mysql>` prompt. Type `exit` to return to the terminal. Exiting destroys this second container, so to get another MySQL prompt you will need to re-run the above command. This is a nice way to query the MySQL database without needing to install MySQL command line tools.

An empty database server is probably not that handy. To load a `.sql` database into the first MySQL container, named `go-test-mysql` in the commands above, you can issue the command below. Replace the `/home/your-username/databases/data.sql` path with an actual path to a `.sql` file on your file system.

```bash
docker exec -i go-test-mysql sh -c 'exec mysql -uroot -p"my-secret-pw"' < /home/your-username/databases/data.sql
```

Now run the second Docker container again using the same command as before:

```bash
docker run -it --network my-bridge-network --rm mysql mysql -hgo-test-mysql -uroot -pmy-secret-pw
```

You should once again see a `mysql>` prompt. 

1. Enter `SELECT DATABASE();` to see what database(s) are in your server. 
1. Enter `use yourdatabasename` to open a database from the list, replacing `yourdatabasename` with the name of one of the databases listed in the output of the previous step.
1. Enter `SHOW TABLES();` to see what tables exist in this database.

You can now run `SELECT` and other queries against the database. Be sure to end all of your commands with a `;`.

Here's an example of how you can connect to this database and test the connection in a simple GoLang app:

```golang
package main

import (
	"database/sql"
	"fmt"
	"log"

	"github.com/go-sql-driver/mysql"
)

var db *sql.DB

func main() {
	dsn := mysql.Config{
		User:   "root",
		Passwd: "my-secret-pw",
		Net:    "tcp",
		Addr:   "127.0.0.1:3306",
		DBName: "yourdatabasename",
	}

	var err error
	db, err = sql.Open("mysql", dsn.FormatDSN())
	if err != nil {
		log.Fatal(err)
	}

	defer db.Close()

	pingErr := db.Ping()
	if pingErr != nil {
		log.Fatal(pingErr)
	} else {
		fmt.Println("Connected!")
	}
}
```

# Set up and connect to MariaDB Server running in Docker

**Instructions derived from https://hub.docker.com/_/mariadb using MariaDB 11.4.1 and are current as of 2024-03-11**

One can run MariaDB in a Docker container rather than installing MariaDB locally. Start a Maria Docker container by running the following two commands:

```bash
docker network inspect my-bridge-network >/dev/null 2>&1 || docker network create --driver bridge my-bridge-network
docker run --detach --name some-mariadb --network my-bridge-network -p 3306:3306 --env MARIADB_ROOT_PASSWORD=my-secret-pw  mariadb:latest
```

> The `-p 3306:3306` is what allows you to connect to this MariaDB container from the host system, such as what you might do when developing an app.

Next, start a _second_ MariaDB container that connects to the first:

```bash
docker run -it --network my-bridge-network --rm mariadb mariadb -hsome-mariadb -uroot -pmy-secret-pw
```

You should now see a `MariaDB [(none)]>` prompt. Type `\s` and press **Enter** to verify success. Type `exit` to return to the terminal.

