#!/bin/bash

sh "$HOME/.config/drifter/.config"

echo "drifter 0.1.0"
DRIFTER_HOME="$HOME/.drifter"
DRIFTER_REPO_HOME="$HOME/.drifter/repo"

DRIFTER_BIN="$HOME/.bin/drifter"
DRIFTER_APPS_BIN="$DRIFTER_BIN/apps"

#DRIFTER_CURRENT_HUB_BIN="$HOME/.bin/drifter/hubs/$hub/"
#echo "$DRIFTER_CURRENT_HUB_BIN"

if [ ! -e "$DRIFTER_HOME" ]; then
    echo "Creating home folder"
    mkdir $DRIFTER_HOME
fi
if [ ! -e "$DRIFTER_REPO_HOME" ]; then
    echo "Creating repo folder"
    mkdir $DRIFTER_REPO_HOME
fi

#https://www.devdungeon.com/content/taking-command-line-arguments-bash
DRIFTER_BIN="$(pwd)/drifter"

case $1 in
"init")
    sh "$DRIFTER_BIN/init.sh"
    ;;

"config")
    sh "$DRIFTER_BIN/config.sh"
    ;;

"remote")
    sh $DRIFTER_BIN/remote/$2.sh $@
    ;;

"push")
    sh $DRIFTER_CURRENT_HUB_BIN/push.sh
    ;;

"pull")
    sh "$DRIFTER_CURRENT_HUB_BIN/pull.sh"
    ;;

"sync")
    sh $DRIFTER_CURRENT_HUB_BIN/sync.sh
    ;;

"app")
    sh "$DRIFTER_APPS_BIN/$2.sh"
    ;;

*)
    "sh $DRIFTER_BIN/help.sh"
    ;;
esac

#if [ $1="configure" ]; then
#    sh $DRIFTER_BIN/configure.sh
#fi
