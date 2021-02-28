#!/bin/bash

configure_transmission() {
  transmissionConfig=/etc/transmission-daemon/settings.json

  # give things a second to come up and stabilize
  sleep 30
  mkdir /transmission-autoload
  chmod -R 777 /transmission-autoload

  # transmission-daemon writes the config file when it starts AND stops, so stop it before making changes
  service transmission-daemon stop

  # open web access only to the IP of the provisioner machine (template rendered by Terraform)
  cat $transmissionConfig \
    | jq '."download-dir" = "/plex-media/movies"' \
    | jq '."rpc-whitelist" = "127.0.0.1,${home_ip}"' \
    | jq '."rpc-password" = "${rpc_password}"' \
    | jq '."watch-dir-enabled" = "true"' \
    | jq '."watch-dir" = "/transmission-autoload"' \
    | jq '."encryption" = "2"' \
    > /tmp/new-config.json
  mv /tmp/new-config.json $transmissionConfig

  # fire it back up with the new config in place
  service transmission-daemon start
}

sudo apt-get update -qq
sudo apt-get -y upgrade

# install transmission for easy file transfer
sudo apt-get -y install \
  jq \
  transmission-daemon \
  transmission-common

# install Plex server
# get the latest url here: https://www.plex.tv/media-server-downloads/
plexUrl="https://downloads.plex.tv/plex-media-server-new/1.21.4.4079-1b7748a7b/debian/plexmediaserver_1.21.4.4079-1b7748a7b_amd64.deb"
wget -O plex.deb "$plexUrl"
sudo dpkg -i plex.deb

# install DigitalOcean advanced monitoring
curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash

# set up media directories
mkdir /plex-media /plex-media/movies /plex-media/tv /plex-media/music
chmod -R 777 /plex-media

# wait, then configure transmission
configure_transmission &

