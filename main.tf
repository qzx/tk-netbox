terraform {
  required_providers {
    netbox = {
      source  = "e-breuninger/netbox"
      version = "~> 3.5.1"
    }
  }
  cloud {
//    organization = "simple"
//    hostname     = "8080-azbuilder-terrakube-w79dkeis3ge.ws-eu102.gitpod.io"
    hostname = "terrakube-api.sc.scm.is"
    organization = "Sensa"
    workspaces {
//      name = "simple_sample"
        name = "tk-netbox"
    }
  }
}

# example provider configuration for https://demo.netbox.dev
provider "netbox" {
  server_url = var.netbox_url
  api_token  = "ccf78c70a8087cfde0bc4b6933edf24da43e6d9b"
}

resource "netbox_tag" "staff" {
  name      = "role:staff"
  color_hex = "ff00ff"
}

resource "netbox_tag" "jira" {
  name      = "jira:ZKFG2"
  color_hex = "ff00ff"
}

resource "netbox_tenant_group" "staff" {
  name = "Sensa Staff2"

}

resource "netbox_tenant" "this" {
  name        = "ZKFG2 - Freyr Gudjonsson"
  description = "Starfsmadur: freyr.gudjonsson@sensa.is"
  group_id    = netbox_tenant_group.staff.id
  tags = [
    netbox_tag.staff.name,
    netbox_tag.jira.name
  ]
}

output "sensa_tenant" {
  value = netbox_tenant.this.id
}
