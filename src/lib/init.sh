
if [ ! -e "$DRIFTER_DATA_HOME" ]; then
    echo "Creating home folder: $DRIFTER_DATA_HOME"
    mkdir -p "$DRIFTER_DATA_HOME"
fi

if [ ! -e "$DRIFTER_CONFIG_HOME" ]; then
    echo "Creating default configuration"
    mkdir -p "$DRIFTER_CONFIG_HOME"
    git config --file "$DRIFTER_CONFIG_HOME/.config" --add drifter.version "0.1.0"
fi

if [ ! -e "$DRIFTER_REPO_LOCAL" ]; then
    echo "Creating local repo folder: $DRIFTER_REPO_LOCAL"
    mkdir -p "$DRIFTER_REPO_LOCAL"
fi

if [ ! -e "$DRIFTER_REPO_REMOTE" ]; then
    echo "Creating remote repo folder: $DRIFTER_REPO_REMOTE"
    mkdir -p "$DRIFTER_REPO_REMOTE"
    loc=$PWD
    cd "$DRIFTER_REPO_REMOTE"
    git init
    cd "$loc"
fi

echo "Enter the remote repo url:"
read REMOTE_URL
sh "$DRIFTER_GLOBAL_BIN/remote/add.sh" $REMOTE_URL