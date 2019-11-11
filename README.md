# drifter
Pipe dream to create a utility to sync my linux environment between machines. This includes syncing settings for KDE Plasma, bash etc.


# CLI

```
drifter sync - syncs all the things
drifter configure - prompts to configure the app settings
```

```
drifter glob add [glob] - supports globs under $HOME
drifter glob remove [glob]
drifter glob sync [glob] - syncs all globs or specify a single glob
```

```
drifter app add [name] - add app to list of syncs
drifter app remove [name]
drifter app sync [name]
drifter app configure [name] - runs apps ./configure.sh to allow for app specific settings
```

```
drifter hub add [name]
drifter hub remove [name]
drifter hub configure [name]
drifter hub download [name] - download drifter settings from a configured hub
```


# Roadmap

## 0.1.0
* basic support for adding globs to sync
* one available hub, tar location setting

## 0.2.0
* support "apps" to bundle sync scripts for given applications
* sync app settings for a list of selected apps
* support `drifter configure` to select the available app packages, then runs `drifter configure app` for each selected app

## 0.3.0
* support "hubs" to enable different locations to store settings
* add private github repo hub -- only support overwrite-local=true flag. no "true git" support initially

## 0.4.0
* allow ./install.sh files for apps and enable them with auto-install=true flag. 
* support uname override files to allow apps to support installing on multiple platforms
  
  
