variable "do_token" {
  type = string
}

variable "cloud_plex_ssh_key_name" {
  type = string
}

variable "transmission_password" {
  type    = string
  default = "cloud-plex"
}

variable "server_size" {
  type = string
  # CPU-optimized $80/mo
  default = "c-4"
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "server_key" {
  name = var.cloud_plex_ssh_key_name
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "template_file" "init" {
  template = file("./data/provision.sh.tpl")

  vars = {
    home_ip = chomp(data.http.myip.body)
    rpc_password = chomp(var.transmission_password)
  }
}

resource "digitalocean_droplet" "plex_server" {
  image     = "ubuntu-18-04-x64"
  name      = "plex-server"
  region    = "sfo2"
  size      = var.server_size
  user_data = data.template_file.init.rendered

  # see README for instructions
  ssh_keys = [data.digitalocean_ssh_key.server_key.id]
}

output "droplet_ip" {
  value = digitalocean_droplet.plex_server.ipv4_address
}

output "transmission_url" {
  value = "http://${digitalocean_droplet.plex_server.ipv4_address}:9091/transmission"
}
