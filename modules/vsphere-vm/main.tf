# Data sources

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_host" "hosts" {
  name          = var.vsphere_host
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "compute_cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Resource
resource "vsphere_virtual_machine" "vm" {

  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
  guest_id         = var.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  name = var.name

  num_cpus = var.cpu
  memory   = var.memory
  firmware = var.firmware

  scsi_type = var.scsi_type


  dynamic "disk" {
    for_each = [for disk in var.disks : disk]

    content {
      label       = "disk${disk.value.id}"
      unit_number = disk.value.id
      size        = disk.value.sizeGB
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      dynamic "windows_options" {
        for_each = var.guest_id == "windows2019srvNext_64Guest" ? [1] : []
        content {
          computer_name = var.name
        }
      }

      dynamic "linux_options" {
        for_each = var.guest_id == "ubuntu64Guest" ? [1] : []
        content {
          host_name = var.name
          domain    = var.domain
        }
      }

      network_interface {
        ipv4_address    = var.ip
        ipv4_netmask    = var.netmask
        dns_server_list = var.dns_servers
      }
      ipv4_gateway = var.gateway
    }
  }
}