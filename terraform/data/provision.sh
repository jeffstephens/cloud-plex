#!/bin/bash

sudo apt-get update -qq
sudo apt-get -y upgrade

wget -O plex.deb https://downloads.plex.tv/plex-media-server-new/1.20.3.3421-54b6523bd/debian/plexmediaserver_1.20.3.3421-54b6523bd_amd64.deb
sudo dpkg -i plex.deb
curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash
