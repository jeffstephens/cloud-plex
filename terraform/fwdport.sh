#!/bin/bash

ssh root@$(terraform output -json | jq -r .droplet_ip.value) -L 8888:localhost:32400

