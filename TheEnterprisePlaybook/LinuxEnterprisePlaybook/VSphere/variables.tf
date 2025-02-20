variable "vsphere_user" {
  description = "The username for vSphere authentication"
  type        = string
  default     = "value"
}

variable "vsphere_password" {
  description = "The password for vSphere authentication"
  type        = string
  sensitive   = true
  default     = "value"

}

variable "vsphere_server" {
  description = "The vSphere server address"
  type        = string
  default     = "value"
}

variable "vsphere_datacenter" {
  description = "The name of the vSphere datacenter"
  type        = string
  default     = "value"
}

variable "vsphere_datastore" {
  description = "The name of the vSphere datastore"
  type        = string
  default     = "value"
}

variable "vsphere_compute_cluster" {
  description = "The name of the vSphere compute cluster"
  type        = string
  default     = "value"
}

variable "vsphere_resource_pool" {
  description = "The name of the vSphere resource pool"
  type        = string
  default     = "value"
}

variable "vsphere_network" {
  description = "The name of the vSphere network"
  type        = string
  default     = "value"
}

variable "vm_config" {
  description = "Configuration for the virtual machines"
  type = list(object({
    name     = string
    template = string
    cpu      = number
    memory   = number
    disk     = number
  }))
  default = [
    { name = "backend", template = "Ubuntu 24.04.1_Template", cpu = 2, memory = 4294967296, disk = 20 },
    { name = "frontend", template = "Ubuntu 24.04.1_Template", cpu = 2, memory = 4294967296, disk = 20 }
  ]
}