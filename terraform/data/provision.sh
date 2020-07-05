#!/bin/bash

sudo apt-get update -qq
sudo apt-get -y upgrade

wget -O plex.deb https://downloads.plex.tv/plex-media-server-new/1.19.4.2935-79e214ead/debian/plexmediaserver_1.19.4.2935-79e214ead_amd64.deb
sudo dpkg -i plex.deb
curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash
