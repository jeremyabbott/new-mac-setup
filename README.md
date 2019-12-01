# new-mac-setup

Scripts and notes regarding tools/apps I install when I get a new laptop. In general, I want to be able to build/run a [SAFE Stack Application](https://safe-stack.github.io/) when setup is finished. To accomplish this I'll need

1. .NET Core
2. Node
3. (Optional) Yarn
4. (Optional) Docker (this could also be the first step if you only need/want to work in a .devcontainer)

Before we get into installing our developer tools though, we'll need to do some housekeeping.

## Remove Crap from the Dock

On a clean macOS install there's going to be a bunch of stuff on the dock that you probably don't want. Get rid of it 😉!

![Alt text](https://github.com/jeremyabbott/new-mac-setup/raw/master/images/removefromdock.png "Remove crap from dock")

## Install OS Updates

This is especially worthwhile with macOS Catalina being so new and lamentably buggy. It's especially important if you (like me 💪🏼) treated yourself to the new 16" MacBook Pro. Applying updates ASAP will ensure you have the latest drivers installed.

## Password Manager

Get your password manager installed. [I use 1Password, and I installed it from the App Store](https://apps.apple.com/us/app/1password-7-password-manager/id1333542190?mt=12).

## Content Blockers

I generally use [Firefox Developer Edition](https://www.mozilla.org/en-US/firefox/developer/) for standard browsing. However, when I'm shopping online I use Safari if the site I'm using supports Apple Pay. I use [Better Blocker](https://apps.apple.com/us/app/better-blocker/id1121192229?mt=12) in that case.

## Homebrew

Install [homebrew](https://brew.sh/). 

1. Open up your terminal 
2. Run this: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

After getting homebrew installed I installed the following

```
brew install mkcert
brew cask install docker
brew cask install visual-studio-code
brew cask install dropbox
```

**After you install VS Code you're going to have to do some permission tweaking.**

### Homebrew or App Store?

At least 1Password can be installed via Homebrew as well as available in the App Store. Which way should you do it? My best guess is honestly personal preference. For things that I just need to work no matter what (like password access), I think something from the App Store has a better change of working correctly after a major OS upgrade. I don't have any evidence this to back this up though, so let's go with personal preference. 🤷🏽‍♂️

Other apps I installed via the App Store

* [One Note](https://apps.apple.com/us/app/microsoft-onenote/id784801555?mt=12)
* [Slack](https://apps.apple.com/us/app/slack/id803453959?mt=12)

## Antigen

With macOS Catalina, macOS uses zsh as the default terminal instead of bash. From the little bit I've interacted with it, I haven't noticed a difference. I came across Antigen while looking for the best way to install [`nvm`](https://github.com/nvm-sh). While perusing the readme I came across this

> Homebrew installation is not supported. If you have issues with homebrew-installed nvm, please brew uninstall it, and install it using the instructions below, before filing an issue.

Well 💩.

However, I also saw this tidbit

> **Note:** If you're using zsh you can easily install nvm as a zsh plugin. Install [zsh-nvm](https://github.com/lukechilds/zsh-nvm) and run nvm upgrade to upgrade.

Cool... Looking at the [`zsh-nvm`](https://github.com/lukechilds/zsh-nvm#installation) installation instructions, it lists [Antigen](https://github.com/zsh-users/antigen) first. Well that doesn't sound scary at all.

Antigen manages plugins for zsh. Before this little adventure, I didn't even know there were plugins for zsh. As it turns out, we can install antigen via homebrew

```zsh
brew install antigen
```

After antigen is installed, do the following:

```zsh
cd $HOME
touch .zshrc #creates the file if it doesn't exist
```

Then add this to .zshrc

```
source /usr/local/share/antigen/antigen.zsh

antigen bundle lukechilds/zsh-nvm

antigen apply
```

Plot twist: you can also install antigen first, and then setup Homebrew as an Antigen bundle. I'm not sure which step is better.


With `nvm` finally installed

```
nvm install --lts
nvm use --lts
```

## Installing .NET Core

Unfortunately, we don't (yet) have a cool tool like `nvm` for managing .NET Core SDK installations. You *could* install .NET Core via homebrew, but that's only going to get you one version. That might be enough for you. Reality is never that simple though. As I'm writing this .NET Core 2.1 is LTS, .NET Core 2.2 and 3.0 are supported, and 3.1 preview 3 is supported in production by Microsoft with 3.1 releasing next week (2019/12/2). 3.1 will be an LTS release. So you will probably want the latest 2.1 SDK, in addition to a 2.2 and 3.0 SDK. You *could* manually intall the `pkg`s from the .NET site. I'd like to be able to install from the command line though. Enter [`dotnet-install.sh`](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script)

[Download the script](https://dot.net/v1/dotnet-install.sh). I did it through the documentation link since I was already there. You'll probably want to move it to wherever you keep your scripts (`$HOME/code` for me).

Then run

```
chmod u+x dotnet-install.sh
./dotnet-install.sh -c Current # 3.0
./dotnet-install.sh -c LTS # 2.1
./dotnet-install.sh -c 2.2 
```

Unless you specify an install directory, the `dotnet` executable is going to get intalled to `$HOME/.dotnet`, which you'll need to add to your path by adding the following to `.zshrc`

```
if [ -d "$HOME/.dotnet" ] ; then
    export PATH="$PATH:$HOME/.dotnet" # Add the directory where the dotnet executable lives
fi

if [ -d "$HOME/.dotnet/tools" ] ; then
    export PATH="$PATH:$HOME/.dotnet/tools" # Add the directory where dotnet global tools are going to be saved
fi
```

### Install my Favorite .NET Core Templates

```
dotnet new -i "MiniScaffold::*" # MiniScaffold is the bomb https://github.com/TheAngryByrd/MiniScaffold
dotnet new -i SAFE.Template # you should be using the safe stack https://safe-stack.github.io/
```

I literally went through all that work (above) to get `nvm` installed so that I could build `SAFE Stack` apps.

## Wrapping Up

This post was in part inspired by John Papa's [The First 10 macOS Apps I Install in 2019 ](https://dev.to/azure/the-first-10-macos-apps-i-install-in-2019-2bba). However, I wanted to emphasize what it feels like setting up developer tooling on macOS 10.15, and what my experience was using zsh for the first time.

A copy of my current `.zshrc` can be found [here](https://github.com/jeremyabbott/new-mac-setup/blob/master/.zshrc).

One thing I haven't done yet is installed a zsh theme. Do you have any you like? Do you have a more automated way of getting your developer setup just right?

