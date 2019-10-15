# dotfiles

Good Unix tools are configured by files written by the user, so-called dotfiles.
Bad tools are configured by databases and GUIs.
This repository tries to apply my preferred settings to both of them.

## What's configured

* [bash](http://tiswww.case.edu/php/chet/bash/bashtop.html) environment (basic stuff only, I'm mostly using fish)
* [fish](https://fishshell.com/) environment and abbreviations
* [Git](https://git-scm.com/)
* [Karabiner-Elements](https://github.com/tekezo/Karabiner-Elements)
* keyboard layout on macOS (manually)
* [OpenSSH](https://www.openssh.com/)
* Terminal.app (manually)
* [Termux](https://termux.com/)
* [tmux](https://tmux.github.io/)
* [unicompose](https://github.com/scy/unicompose)
* [Vim](https://www.vim.org/) (needs to be fleshed out further)
* [Visual Studio Code](https://code.visualstudio.com/)

## Status

This is currently replacing [dotscy](https://github.com/scy/dotscy) in order to have a fresh start.
The old repo contained a lot of configs for tools that I no longer use, even fonts and binaries that I don't want anymore, but still had in the history.

These settings have been in use on macOS and Debian (in WSL and standalone); they should run on other Unixes as well.

## Setting up

Instead of symlinking lots of files into your home directory, this repository is supposed to **be** your home directory.
This has the added benefit of you being aware (via `git status`) of new config files that some tool might generate.

The setup procedure will clone the repo into a subdir of your home, then moving everything in it (including `.git`) directly into your home dir.
Files/directories that would be overwritten will be backed up to `~/.orig_home`.

### Termux

Install required (and my favorite) packages, setup storage access and change the default shell.

```sh
pkg install curl fish git neovim perl rsync termux-api &&
termux-setup-storage                                   &&
chsh -s fish
```

Then, continue as described below in the "Unix" section.

### Debian

Install required packages and change the default shell.

```sh
apt update                 &&
apt install fish git rsync &&
chsh -s $(which fish)
```

Then, continue as described below in the "Unix" section.

### Windows

Install [Git for Windows](https://git-scm.com/download/win).
Then, in a command prompt at your home directory, run

```sh
git clone --recurse-submodules https://github.com/scy/dotfiles.git
```

Afterwards, symlink VS Code's `settings.json` [as described in it](.config/Code/User/settings.json).

### Unix

```sh
which rsync > /dev/null                        &&
umask 0022 && cd                               &&
test ! -e .orig_home                           &&
git clone https://github.com/scy/dotfiles.git  &&
rsync -avb --backup-dir=.orig_home dotfiles/ . &&
rm -rf dotfiles
```

## Manual configuration

Although I'm aiming to automate as much as possible with this repo, for some things it's currently too complicated, at least at the moment.
Maybe I'll add automation scripts in the future, but right now it's not worth the effort.

### On a Mac

* Install [Karabiner-Elements](https://github.com/tekezo/Karabiner-Elements).
* Change the **keyboard layout** to US English. Not US International, because this results in dead keys which massively disturb my programming flow.
* In **Terminal.app:**
  * on startup, new window with **Pro**
  * change default profile to **Pro**
  * in the **Window** tab of the profile, change the default size to **160x40**
  * in the **Shell** tab of the profile, change the setting to **close the window when the shell exits without error**

### On Windows

* The default Windows console doesn't provide a visual bell, but the audible one is annoying. Therefore, mash Backspace in a bash for a few times to produce an audible bell. Then, right-click on the volume symbol in the task bar, choose "Open Volume Mixer" and mute "Console Window Host".
* See [`settings.json`](.config/Code/User/settings.json) for instructions on how to symlink the VS Code settings from this repo into `%APPDATA%`.
