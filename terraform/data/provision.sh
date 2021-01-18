#!/bin/bash

sudo apt-get update -qq
sudo apt-get -y upgrade

# install transmission for easy file transfer
sudo apt-get -y install transmission-daemon transmission-common

# install Plex server
# get the latest url here: https://www.plex.tv/media-server-downloads/
plexUrl="https://downloads.plex.tv/plex-media-server-new/1.21.1.3830-6c22540d5/debian/plexmediaserver_1.21.1.3830-6c22540d5_amd64.deb"
wget -O plex.deb "$plexUrl"
sudo dpkg -i plex.deb

# install DigitalOcean advanced monitoring
curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash

# set up media directories
mkdir /plex-media /plex-media/movies /plex-media/tv /plex-media/music
