# drifter

Pipe dream to create a utility to sync my linux environment between machines. This includes syncing settings for KDE Plasma, bash etc.

Written in bash this should run on any OS that can execute them. Additionally with the right override files in place be able to support most Linux and Unix based systems. Apps can write their backup logic in any language as long as it can be executed from the app's ./sync.sh file.

The concept of platforms is a foundational piece of drifter. Platform overrides allow any drifter plugin to work on a specific platform. For example, you can configure drifter to support your current distro, fallback to the distro root and then to snap. Only the most specific script will be applied. This also allows drifter to support packages for OSs such as Windows and OSX. If there is no script for your platform, drifter can move along to the next app without issue.
This also allows settings from VS Code installed on Arch to be applied to VS Code running on KDE Neon or even OSX. This means drifter will run the vscode/sync-osx.sh file for the app while on your MacBook and the vscode/sync-arch.sh while on your Manjaro desktop.

Let's say you decided to try out the new distro everyone is ranting about in their videos. You already know that there are no install scripts for your distro. However, since your distro derives from ubuntu-18.04 you can disable platform detection and force drifter to use the ubuntu scripts.

Since platform.fallbacks is an array of arbitrary strings, you can also do things like `[ubuntu-19.04,ubuntu,debian-9]`. This would look for a specific `sync-ubuntu-19.04.sh`, then a generic `sync-ubuntu.sh` before finally looking for a `sync-debian9.sh`.

Maybe you are on your primary dev box and you need a stable environment? No problem, turn off platform fallbacks and force drifter to only use scripts built specifically for debian-9. When platform.enforce=true if there is no script matching your uname, nothing is executed for that app.

## CLI

```sh
drifter init - prompts to configure remote and downloads drifter settings from the configured remote
drifter config - get and set drifter settings
```

```sh
drifter pull [name] - pull remote changes to hub's staging area
drifter push [name] - push local staging to remote hub
drifter sync [name] - syncs all the things
```

```sh
drifter remote add [name] [hub] - adds a new remote of the using the hub type
drifter remote remove [name] - removes the remote and its config for the hub
drifter remote configure [name] - run ./drifter/hubs/[hub]/configure.sh to configure the hub for the remote
```

```sh
drifter app add [name] - add to the list of apps to sync
drifter app remove [name] - remove from the list of apps to sync
drifter app sync [name] - runs [app]/sync.sh if exists or defaults to ./drifter/apps/sync.sh
drifter app configure [name] - runs [app]/configure.sh to enable optional for app specific settings
```

## Roadmap

Please see our page in the Wiki
  