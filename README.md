# plex-cloud

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

### SSH Key ID

If you already have an SSH key in DigitalOcean, you can find its ID by running this command:

```bash
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $TF_VAR_do_token" "https://api.digitalocean.com/v2/account/keys" | jq
```

Find the numeric ID of the one you want to use on the new server, then add it to your environment:

```bash
export TF_VAR_cloud_plex_ssh_key=<SSH Key ID>
```

## Plex Setup

The output of `terraform apply` will include your new server's IP address. Note this, and run the following command to
get direct access to your new server:

```bash
ssh root@<new server IP> -L 8888:localhost:32400
```

Open [http://localhost:8888/web](http://localhost:8888/web) in a web browser and follow the setup steps. After
connecting to your Plex account, you can close the tunnel and use Plex as you normally do.
