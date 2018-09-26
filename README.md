# dotfiles

Good Unix tools are configured by files written by the user, so-called dotfiles. 
Bad tools are configured by databases and GUIs. 
This repository tries to apply my preferred settings to both of them.

## What's configured

* [bash](http://tiswww.case.edu/php/chet/bash/bashtop.html) environment (basic stuff only, I'm mostly using fish)
* [fish](https://fishshell.com/) environment and abbreviations
* [Git](https://git-scm.com/)
* keyboard layout on macOS (manually)
* Terminal.app (manually)
* [Vim](https://www.vim.org/) (needs to be fleshed out further)

## Status

This is supposed to replace [dotscy](https://github.com/scy/dotscy) as soon as possible in order to have a fresh start. 
The old repo contained a lot of configs for tools that I no longer use, even fonts and binaries that I don't want anymore, but still had in the history.

Currently, this has only been tested on macOS, but should run on other Unixes as well. 
I also plan to add instructions for usage on Windows.

## Setting up

Instead of symlinking lots of files into your home directory, this repository is supposed to **be** your home directory. 
This has the added benefit of you being aware (via `git status`) of new config files that some tool might generate.

The setup procedure will clone the repo into a subdir of your home, then moving everything in it (including `.git`) directly into your home dir. 
Files/directories that would be overwritten will be backed up to `~/.orig_home`. 

The copy-paste snippet below requires _rsync_ to be available on the system.

### Unix

```sh
cd                                             &&
git clone https://github.com/scy/dotfiles.git  &&
rsync -avb --backup-dir=.orig_home dotfiles/ . &&
rm -rf dotfiles                                &&
bin/apply-scy-config
```

## Manual configuration

Although I'm aiming to automate as much as possible with this repo, for some things it's currently too complicated, at least at the moment. 
Maybe I'll add automation scripts in the future, but right now it's not worth the effort.

### On a Mac

* Change the **keyboard layout** to US English. Not US International, because this results in dead keys which massively disturb my programming flow.
* In **Terminal.app:**
  * on startup, new window with **Pro**
  * change default profile to **Pro**
  * in the **Window** tab of the profile, change the default size to **160x40**
  * in the **Shell** tab of the profile, change the setting to **close the window when the shell exits without error**
