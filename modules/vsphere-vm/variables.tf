# Infrastructure - vCenter / vSPhere environment

variable "vsphere_datacenter" {
  description = "The vSphere datacenter in which the virtual machine will be deployed."
}

variable "vsphere_host" {
  description = "The vSphere host FQDN or IP"
}

variable "vsphere_compute_cluster" {
  description = "The vSPhere cluster in which the virtual machine will be deployed."
}

variable "vsphere_datastore" {
  description = "The Datastore in which the virtual machine will be deployed."
}

variable "vsphere_network" {
  description = "The Portgroup to which the virtual machine will be connected."
}

# VM

variable "name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "domain" {
  description = "The domain name for this machine."
  default     = ""
  type        = string
}

variable "template_name" {
  description = "The name of the source virtual machine or template."
  type        = string
}

variable "guest_id" {
  description = "The guest ID for the operating system type."
  default     = "windows2019srvNext_64Guest"
  type        = string
}

variable "firmware" {
  description = "The firmware for the virtual machine."
  type        = string
  default     = "efi"
}

variable "ip" {
  description = "The IPv4 address assigned to the network adapter."
  type        = string
}

variable "netmask" {
  description = "The IPv4 subnet mask, in bits."
  type        = string
}

variable "gateway" {
  description = "The IPv4 default gateway."
  type        = string
}

variable "dns_servers" {
  description = "The list of DNS servers to configure on the virtual machine."
  type        = list(string)
}

variable "cpu" {
  description = "The total number of virtual processor cores to assign to the virtual machine."
  type        = number
  default     = 1
}

variable "memory" {
  description = "The memory size to assign to the virtual machine, in MB."
  type        = number
  default     = 4096
}

variable "disks" {
  description = "A specification for a virtual disk device on the virtual machine."
  type        = list(map(string))
  default     = [{ "id" : 0, "sizeGB" : 50 }]
}

variable "scsi_type" {
  description = "The common type of all SCSI controllers on this virtual machine"
  type        = string
  default     = "pvscsi"
}
