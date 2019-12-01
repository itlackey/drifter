#!/bin/bash

echo "drifter 0.1.0"


#source "$HOME/.local/lib/drifter/.env"

#LOCALTESTING
source "$PWD/lib/.env"
DRIFTER_GLOBAL_BIN="$PWD/lib"

echo "drifter environment loaded"


if [ ! -e "$DRIFTER_CONFIG_HOME" ]; then
    echo "no configuration found, running init"
    sh "$DRIFTER_GLOBAL_BIN/init.sh"
fi

# if [ ! -e "$DRIFTER_DATA_HOME" ]; then
#     echo "Creating home folder: $DRIFTER_DATA_HOME"
#     mkdir -p "$DRIFTER_DATA_HOME"
# fi

# if [ ! -e "$DRIFTER_CONFIG_HOME" ]; then
#     echo "Creating default configuration"
#     mkdir -p "$DRIFTER_CONFIG_HOME"
#     git config --file "$DRIFTER_CONFIG_HOME/.config" --add drifter.version "0.1.0"
# fi

#https://www.devdungeon.com/content/taking-command-line-arguments-bash

case $1 in
"init")
    sh "$DRIFTER_GLOBAL_BIN/init.sh"
    ;;

"config")
    sh "$DRIFTER_GLOBAL_BIN/config.sh"
    ;;

"remote")
    sh "$DRIFTER_GLOBAL_BIN/remote/$2.sh" $@
    ;;

"push")
    sh "$DRIFTER_GLOBAL_BIN/push.sh"
    ;;

"pull")
    sh "$DRIFTER_GLOBAL_BIN/pull.sh"
    ;;

"sync")
    sh "$DRIFTER_GLOBAL_BIN/sync.sh"
    ;;

"bindle")
    sh "$DRIFTER_GLOBAL_BIN/bindle/$2.sh"
    ;;

*)
    sh "$DRIFTER_GLOBAL_BIN/help.sh"
    ;;
esac

#if [ $1="configure" ]; then
#    sh $DRIFTER_BIN/configure.sh
#fi
