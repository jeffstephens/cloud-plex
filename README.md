# cloud-plex

Terraform configuration to set up a Plex server in the cloud that can support multiple concurrent streaming sessions.
Follow the configuration steps, then run `terraform apply`.

## Configuration

You'll need to define two Terraform variables to use this module. The easiest way is to add them to your .bash_profile
file or similar.

### API Token

[Generate a DigitalOcean API token](https://cloud.digitalocean.com/account/api/tokens) with read/write access, then add
it to your environment:

```bash
export TF_VAR_do_token=<DO API token>
```

### SSH Key

First, make sure you have an [SSH Key in DigitalOcean](https://cloud.digitalocean.com/account/security). Then, pass its name to the Terraform module:

```bash
# CLI option
terraform apply -var="cloud_plex_ssh_key_name=<SSH key name>"

# ENV option
export TF_VAR_cloud_plex_ssh_key_name=<SSH key name>
```

## Plex Setup

The output of `terraform apply` will include your new server's IP address. Note this, and run the following command to
get direct access to your new server:

```bash
ssh root@<new server IP> -L 8888:localhost:32400
```

Open [http://localhost:8888/web](http://localhost:8888/web) in a web browser and follow the setup steps. After
connecting to your Plex account, you can close the tunnel and use Plex as you normally do.

### Updating Plex

If the server is out of date, follow [these instructions](https://brianli.com/how-to-update-plex-media-server-on-ubuntu/) to install the latest
version of Plex via SSH.
