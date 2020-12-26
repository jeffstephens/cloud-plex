#!/bin/bash

sudo apt-get update -qq
sudo apt-get -y upgrade

wget -O plex.deb https://downloads.plex.tv/plex-media-server-new/1.21.1.3830-6c22540d5/debian/plexmediaserver_1.21.1.3830-6c22540d5_amd64.deb
sudo dpkg -i plex.deb
curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash
