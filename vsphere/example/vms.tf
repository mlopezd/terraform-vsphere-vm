locals {

  vsphere_datacenter      = "DATACENTER"
  vsphere_host            = "host1.company.local"
  vsphere_compute_cluster = "CLUSTER1"
  vsphere_datastore       = "LUN1"
  vsphere_network         = "Network1"

}

module "example_windows1" {
  source = "../../modules/vsphere-vm"

  vsphere_datacenter      = local.vsphere_datacenter
  vsphere_host            = local.vsphere_host
  vsphere_compute_cluster = local.vsphere_compute_cluster
  vsphere_datastore       = local.vsphere_datastore
  vsphere_network         = local.vsphere_network

  name = "EXAMPLE-WINDOWS1"

  template_name = "Win 2022 Datacenter"
  guest_id = "windows2019srvNext_64Guest"

  ip          = "192.168.1.10"
  netmask     = "32"
  gateway     = "192.168.1.1"
  dns_servers = ["192.168.1.1"]

  cpu    = "1"
  memory = "4096"

  disks = [
    { "id" : 0, "sizeGB" : 50 },
    { "id" : 1, "sizeGB" : 250 }
  ]
}

module "example_ubuntu1" {
  source = "../../modules/vsphere-vm"

  vsphere_datacenter      = local.vsphere_datacenter
  vsphere_host            = local.vsphere_host
  vsphere_compute_cluster = local.vsphere_compute_cluster
  vsphere_datastore       = local.vsphere_datastore
  vsphere_network         = local.vsphere_network

  name = "EXAMPLE-UBUNTU1"

  template_name = "Ubuntu-Server-22.04.3"
  guest_id      = "ubuntu64Guest"

  ip          = "192.168.1.20"
  netmask     = "32"
  gateway     = "192.168.1.1"
  dns_servers = ["192.168.1.1"]

  cpu    = "2"
  memory = "4096"

  disks = [
    { "id" : 0, "sizeGB" : 250 },
  ]
}