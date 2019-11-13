#!/bin/bash

#update location setting
read -p "Enter the folder to save the tar file" location
echo $location
echo "location: $location" >> $DRIFTER_CONFIG/remotes/$name/.config