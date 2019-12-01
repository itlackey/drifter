if [ ! -e "$DRIFTER_REPO_LOCAL" ]; then
    echo "Creating local repo folder"
    mkdir $DRIFTER_REPO_LOCAL
fi
if [ ! -e "$DRIFTER_REPO_REMOTE" ]; then
    echo "Creating remote repo folder"
    mkdir $DRIFTER_REPO_REMOTE
fi

cd $DRIFTER_REPO_REMOTE
git pull

#TODO: run mod scripts