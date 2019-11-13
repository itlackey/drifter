#! /bin/bash
DRIFTER_APPS_BIN=$HOME/code/github/itlackey/drifter/src/.bin/drifter/apps/
#apt install unison

if [ ! -d ~/.cache/drifter ]; then
    git clone git@github.com:itlackey/my-drifter.git ~/.cache/drifter
fi

#VSCODE_HOME=$HOME/.config/Code
mkdir ~/.cache/drifter/.config
mkdir ~/.cache/drifter/.config/Code

#rsync --progress -r -u ~/.vscode ~/.cache/drifter

rsync -rutv ~/.cache/drifter/.config/Code ~/.config #--delete-after
rsync -rutv ~/.config/Code ~/.cache/drifter/.config --delete-before --exclude-from "$DRIFTER_APPS_BIN/vscode/.drifterignore"

cd ~/.cache/drifter || exit
git add .
git commit -m "$(uname -n) updated settings"
git push
