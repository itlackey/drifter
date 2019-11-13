#!/bin/bash

sh "$HOME/.config/drifter/.config"

echo "drifter 0.1.0"
DRIFTER_BIN="$HOME/.bin/drifter"
DRIFTER_APPS_BIN="$DRIFTER_BIN/apps"

#DRIFTER_CURRENT_HUB_BIN="$HOME/.bin/drifter/hubs/$hub/"
#echo "$DRIFTER_CURRENT_HUB_BIN"

case $1 in
"init")
    sh "$DRIFTER_BIN/init.sh"
    ;;

"config")
    sh "$DRIFTER_BIN/config.sh"
    ;;

"pull")
    sh "$DRIFTER_CURRENT_HUB_BIN/sync.sh"
    ;;

"pull")
    sh "$DRIFTER_CURRENT_HUB_BIN/pull.sh"
    ;;

"sync")
    sh "$DRIFTER_CURRENT_HUB_BIN/pull.sh"
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
