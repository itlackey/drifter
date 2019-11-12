
```
drifter install [package] - install hub or app into the current install of drifter
drifter uninstall [package] - uninstall package from current drifter installation
drifter search [keyword] - searches available drifter packages
```

```
add-drifter-repository [git|folder|remote]
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