packer {
    required_plugins {
        xenserver = {
            version = " >= v0.7.0 "
            source  = "github.com/ddelnano/xenserver"
        }
    }
}

variable "remote_host" {
  type        = string
  description = "The IP or FQDN of your XCP-ng. It must be the master"
  sensitive   = true
  default     = "192.168.5.27"
}

variable "remote_username" {
  type        = string
  description = "The username used to interact with your XCP-ng"
  sensitive   = true
  default     = "root"
}

variable "remote_password" {
  type        = string
  description = "The password used to interact with your XCP-ng"
  sensitive   = true
  default     = "Trin121201"
}

variable "sr_iso_name" {
  type        = string
  description = "The ISO-SR packer will use"
  default     = "ISO"
}

variable "sr_name" {
  type        = string
  description = "The name of the SR packer will use"
  default     = "XENX Storage"
}

source "xenserver-iso" "coreos" {
  iso_url        = "https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/41.20250130.3.0/x86_64/fedora-coreos-41.20250130.3.0-live.x86_64.iso"
  iso_checksum   = "f43780c2db3d03959e22c4f44d6facf47e892517c9e931339389672f8b6ce2f9"

  sr_iso_name    = var.sr_iso_name
  sr_name        = var.sr_name
  tools_iso_name = ""  // Specify the name of the ISO for Xen guest tools

  remote_host     = var.remote_host
  remote_password = var.remote_password
  remote_username = var.remote_username

  http_directory = "http"
  ip_getter      = "tools"

  boot_command = [
    "<wait><wait><wait><esc><wait><wait><wait>",
    "<wait><wait><wait><esc><wait><wait><wait>",
    "<wait><wait><wait><esc><wait><wait><wait>",
    "<wait><wait><wait><esc><wait><wait><wait>",
    "<enter><wait>",
    "coreos_inst_install_dev=/dev/xvda",
    "<enter><wait>",
    "coreos_inst_ignition_url=http://{{.HTTPIP}}:{{.HTTPPort}}/ignition.ign",
    "<enter><wait>",
    "sudo coreos-installer install $coreos_inst_install_dev --ignition-url=$coreos_inst_ignition_url ",
    "--insecure-ignition && sudo systemctl reboot -i",
    "<enter>"
  ]

  clone_template   = "CoreOS"
  vm_name          = "CoreOS template v2"
  vm_description   = "CoreOS template created with Packer"
  vcpus_max        = 2
  vcpus_atstartup  = 2
  vm_memory        = 2048 # MB
  disk_size        = 20480 # MB
  disk_name        = "coreos disk"
  vm_tags          = ["Generated by Packer"]

  ssh_username           = "core"
  ssh_password           = "core"
  ssh_wait_timeout       = "60000s"
  ssh_handshake_attempts = 10000

  output_directory = "packer-coreos"
  keep_vm          = "never"
  format           = "xva_compressed"
}

build {
  sources = ["xenserver-iso.coreos"]
}
