# drifter
Pipe dream to create a utility to sync my linux environment between machines. This includes syncing settings for KDE Plasma, bash etc.

Written in bash this should run on any OS that can execute them. Additionally with the right override files in place be able to support most Linux and Unix based systems. Apps can write their backup logic in any language as long as it can be executed from the app's ./sync.sh file.

The concept of platforms is a foundational piece of drifter. Platform overrides allow any drifter plugin to work on a specific platform. For example, you can configure drifter to support your current distro, fallback to the distro root and then to snap. Only the most specific script will be applied. This also allows drifter to support packages for OSs such as Windows and OSX. If there is no script for your platform, drifter can move along to the next app without issue.
This also allows settings from VS Code installed on Arch to be applied to VS Code running on KDE Neon or even OSX. This means drifter will run the vscode/sync-osx.sh file for the app while on your MacBook and the vscode/sync-arch.sh while on your Manjaro desktop.

Let's say you decided to try out the new distro everyone is ranting about in their videos. You already know that there are no install scripts for your distro. However, since your distro derives from ubuntu-18.04 you can disable platform detection and force drifter to use the ubuntu scripts.

Since platform.fallbacks is an array of arbitrary strings, you can also do things like `[ubuntu-19.04,ubuntu,debian-9]`. This would look for a specific `sync-ubuntu-19.04.sh`, then a generic `sync-ubuntu.sh` before finally looking for a `sync-debian9.sh`.

Maybe you are on your primary dev box and you need a stable environment? No problem, turn off platform fallbacks and force drifter to only use scripts built specifically for debian-9. When platform.enforce=true if there is no script matching your uname, nothing is executed for that app.

# CLI

```
drifter init - prompts to configure remote and downloads drifter settings from the configured remote
drifter config - get and set drifter settings
```

```
drifter pull [name] - pull remote changes to hub's staging area
drifter push [name] - push local staging to remote hub 
drifter sync [name] - syncs all the things
```

```
drifter remote add [name] [hub]
drifter remote remove [name] [hub]
drifter remote configure [name] - run ./drifter/hubs/[hub]/configure.sh to configure the hub for the remote
```

```
drifter app add [name] - add app to list of syncs
drifter app remove [name]
drifter app sync [name] - runs [app]/sync.sh if exists or defaults to ./drifter/apps/sync.sh
drifter app configure [name] - runs [app]/configure.sh to enable optional for app specific settings
```

*TODO: replaced with remote, might refactor drifter hub to support plugins, or remove completely*

```
drifter hub add [name] - add hub to list of enabled hubs
drifter hub remove [name] - remove hub from list of enabled hubs
drifter hub configure [name] - run ./drifter/hubs/[name]/configure.sh to configure the hub
drifter hub pull [name] - pull remote changes to hub's staging area
drifter hub copy local [name] [glob] - copy local changes to hub's staging area
drifter hub copy remote [name] [glob] - copy remote changes from staging to local folder
drifter hub push [name] - push local staging to remote hub 
```

*testing only, will remove*
```
drifter glob add [glob] - supports globs under $HOME
drifter glob remove [glob]
drifter glob sync [glob] - syncs all globs or specify a single glob
```


# Roadmap

## 0.1.0
* basic support for adding globs to sync
* one available hub, tar location setting
* glob will be removed after 0.1.0. Meant for early testing
* may consider creating glob app instead

## 0.2.0
* support "apps" to bundle sync scripts for given applications
* sync app settings for a list of selected apps
* support `drifter configure` to select the available app packages, then runs `drifter configure app` for each selected app

## 0.3.0
* support "hubs" to enable different locations to store settings
* add private github repo hub -- 
* will only support conflict-startegy=overwrite flag. no "true git" support initially
    * eventually support overwrite, keep, merge

## 0.4.0
* allow ./install.sh files for apps and enable them with auto-install=true flag. 
* support uname override files to allow apps to support installing on multiple platforms
  
  
# Drifter Config
~/.drifter/drifter.config
```
auto-install: false
apps: [kde,ssh,bash]
hubs: [tar]
platform:
    fallbacks: [ubuntu-18.04,debian-9]
```

platform.fallbacks is used to locate override files. drifter will first look at `uname` then fallback to the signatures in this array. If no scripts are found, it executes the default platform agnostic script.

# Variables and functions available to apps
Here are available variables in drifter scripts and their default values.

* DRIFTER_CONFIG = ~/.config/drifter

* DRIFTER_HUB_STAGING = ~/.drifter-staging/
* DRIFTER_HUB_LOCAL = ~/

* DRIFTER_BIN = ~/.bin/drifter
* DRIFTER_HUB_BIN = ~/.bin/drifter/hubs
* DRIFTER_APP_BIN = ~/.bin/drifter/apps

# Apps

Apps can include the following files:

## Files
* $DRIFTER_APP_BIN/[name]/.config - main configuration for app. See notes.

### .config

Contains the main configuration for the app. If the app is simple and only needs to copy globs to staging then `.confg` could look like this.

**Example apps/ssh/.config**
```
globs:
    settings: .ssh/**/*.*
```

This tells drifter to copy all files to and from `$DRIFTER_HUB_LOCAL/.ssh` to `$DRIFTER_HUB_STAGING/.ssh`.


## Optional Files
* $DRIFTER_APP_BIN/[name]/sync.sh - Overrides the default drifter sync script.
* $DRIFTER_APP_BIN/[name]/configure.sh - Prompts to help update `.config`.
* $DRIFTER_APP_BIN/[name]/install.sh - 0.4.0 - supports installing the application. 


### configure.sh

Runs the user through prompts and updates the .config file for the app.

### sync.sh
Provides a script that allows custom syncing logic for the app. This is helpful when the app requires more than simple glob copying. If this file does not exist the default `$DRIFTER_APP_BIN/sync.sh` script is ran using the apps `.config` file.

### install.sh

Main entry script to install the application on the local machine. Also supports override scripts such as: `install-manjaro.sh`, `install-ubuntu.sh`, `install-snap.sh` . These files provide a way to customize the setup based on distro etc. 


# Hubs

Hubs should support two folders. One folder is relative to $HOME and one is relative to /.
Each hub knows how to pull/push files from/to it's local temporary folder.

## Scripts

* $DRIFTER_HUB_BIN/[name]/configure.sh - runs script to configure hub
* $DRIFTER_HUB_BIN/[name]/download.sh - downloads drifter settings from hub
* $DRIFTER_HUB_BIN/[name]/pull.sh - pull latest changes from hub into local staging
* $DRIFTER_HUB_BIN/[name]/push.sh - pushes local staging to remote hub

## Optionial Files

* hubs/[name]/copy-local.sh - custom logic to copy local settings to staging
* hubs/[name]/copy-remote.sh - custom logic to copy staged settings to local dir
* .config - default settings for the hub. Overriden by `$DRIFTER_CONFIG/hubs/[name]/.config`

If these do not exist, drifter fallsback to the default scripts.

## Configuration

Each hub can provide it's own config file. It will be located in `$DRIFTER_CONFIG/hubs/[name]/.config` and will be used to hub specific settings.

$DRIFTER_CONFIG/hubs - contains local hub settings that are not synced to hubs for security


### Examples

~/.drifter/hubs/tar/.config 
* target=~/Documents/drifter.tar.gz

~/.drifter/hubs/github/.config
* overwrite-local=true
* private-key=xyz
