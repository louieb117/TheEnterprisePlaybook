terraform {
  required_providers {
    xenorchestra = {
      source  = "terra-farm/xenorchestra"
      version = "0.26.1"
    }
  }
}

provider "xenorchestra" {
  url      = "ws://192.168.5.19"
  username = "terraformer01"
  password = "1qaz2wsx!QAZ@WSX"
  insecure = true
}

# Content of the terraform files
data "xenorchestra_pool" "pool" {
    name_label = "PotentiaMaxima"
}

data "xenorchestra_template" "template" {
    name_label = "Debian 12 template"
}

data "xenorchestra_network" "net" {
  name_label = "Pool-wide network associated with eth0"
}

variable "vm_config" {
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

resource "xenorchestra_vm" "dev_vms" {
  count        = length(var.vm_config)
  name_label   = var.vm_config[count.index].name
  memory_max   = var.vm_config[count.index].memory
  cpus         = var.vm_config[count.index].cpu
  template     = data.xenorchestra_template.template.id

  # Prefer to run the VM on the primary pool instance
  affinity_host = data.xenorchestra_pool.pool.master
  network {
    network_id = data.xenorchestra_network.net.id
  }

  disk {
    name_label = var.vm_config[count.index].name
    sr_id      = "31ddfd7e-16e5-9075-0519-0148be53ec26"
    size       = var.vm_config[count.index].disk
  } 
}

  # value = xenorchestra_vm.dev_vms[*].ip_address
output "vm_ips" {
  value = [for vm in xenorchestra_vm.dev_vms : vm.network[0].ipv4_addresses]
}

