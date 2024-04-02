terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.4.3"
    }
  }
}

# Provider settings
# Remember to export VSPHERE_PASSWORD variable

provider "vsphere" {
  user                 = "administrator@vsphere.local"
  vsphere_server       = "192.168.0.100"
  allow_unverified_ssl = true
}