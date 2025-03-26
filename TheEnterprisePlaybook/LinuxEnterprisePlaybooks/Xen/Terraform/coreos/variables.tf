variable "xen_url" {
  type        = string
  description = "The URL of the Xen Orchestra instance"
  default = "ws://192.168.5.19"
}

variable "xen_username" {
  type        = string
  description = "The username of the Xen Orchestra instance"
  default     = "terraformer01"
}

variable "xen_password" {
  type        = string
  description = "The password of the Xen Orchestra instance"
  default     = "1qaz2wsx!QAZ@WSX"
}

variable "xen_pool" {
    type        = string
    description = "The name of the pool"
    default     = "PotentiaMaxima"
}

variable "xen_template" {
    type        = string
    description = "The name of the template"
    default     = "CoreOS template"
}

variable "xen_net" {
    type        = string
    description = "The name of the network"
    default     = "Pool-wide network associated with eth0"
}

variable "xen_sr_id" {
  type        = string
  description = "The ID of the storage repository"
  default     = "31ddfd7e-16e5-9075-0519-0148be53ec26"  
}

variable "vm_name" {
  type        = string
  description = "The name of the VM"
  default     = "UCoreOS"
}

variable "vm_memory" {
  type        = number
  description = "The amount of memory in bytes"
  default     = 4294967296
}

variable "vm_cpu" {
  type        = number
  description = "The number of CPUs"
  default     = 2
}

variable "vm_template" {
  type        = string
  description = "The name of the template"
  default     = "Ubuntu 24.04.1_Template"
}

variable "vm_disk" {
  type        = number
  description = "The size of the disk in bytes"
  default     = 20
}

