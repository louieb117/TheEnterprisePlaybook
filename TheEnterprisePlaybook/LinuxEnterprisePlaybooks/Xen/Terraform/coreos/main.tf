terraform {
  required_providers {
    xenorchestra = {
      source  = "terra-farm/xenorchestra"
      version = "0.26.1"
    }
  }
}

provider "xenorchestra" {
  url      = var.xen_url
  username = var.xen_username
  password = var.xen_password
  insecure = true
}

# Content of the terraform files
data "xenorchestra_pool" "pool" {
    name_label = var.xen_pool
}

data "xenorchestra_template" "template" {
    name_label = var.xen_template
}

data "xenorchestra_network" "net" {
    name_label = var.xen_net
}

resource "xenorchestra_vm" "dev_vms" {
  name_label   = var.vm_name
  memory_max   = var.vm_memory
  cpus         = var.vm_cpu
  template     = data.xenorchestra_template.template.id

  # Prefer to run the VM on the primary pool instance
  affinity_host = data.xenorchestra_pool.pool.master
  network {
    network_id = data.xenorchestra_network.net.id
  }

  disk {
    name_label = var.vm_name
    sr_id      = var.xen_sr_id
    size       = var.vm_disk
  } 
}

  # value = xenorchestra_vm.dev_vms[*].ip_address
output "vm_ips" {
  value = xenorchestra_vm.dev_vms.network[0].ipv4_addresses
}