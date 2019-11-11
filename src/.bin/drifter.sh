#!/bin/bash

echo "drifter 0.1.0"
DRIFTER_BIN="$HOME/.bin/drifter"
#echo $DRIFTER_BIN

case $1 in
    "configure")
        sh $DRIFTER_BIN/configure.sh
    ;;

    "sync")
        sh $DRIFTER_BIN/sync.sh
    ;;

    *)
        sh $DRIFTER_BIN/help.sh
    ;;
esac

#if [ $1="configure" ]; then
#    sh $DRIFTER_BIN/configure.sh
#fi