resource "proxmox_vm_qemu" "proxmox_vm_master" {
  count       = var.node_master_count
  name        = "${var.environment}-k3s-master-${count.index}"
  vmid        = sum([var.node_master_vmid, count.index])
  target_node = var.pm_node_name
  clone       = var.tamplate_vm_name
  os_type     = "cloud-init"
  agent       = 1
  memory      = var.node_master_memory
  cores       = var.node_master_cores

  sshkeys = var.node_sshkeys

  ipconfig0 = "ip=${var.node_master_ips[count.index]}/${var.networkrange},gw=${var.gateway}"

  disk {
    type    = var.node_master_disk_type
    storage = var.node_master_disk_storage
    size    = var.node_master_disk_size
  }

  lifecycle {
    ignore_changes = [
      ciuser,
      sshkeys,
      disk,
      network
    ]
  }

  timeouts {
    create = "60m"
    delete = "2h"
  }
}

resource "proxmox_vm_qemu" "proxmox_vm_workers" {
  depends_on = [
    proxmox_vm_qemu.proxmox_vm_master,
  ]

  count       = var.node_worker_count
  name        = "${var.environment}-k3s-worker-${count.index}"
  vmid        = sum([var.node_worker_vmid, count.index])
  target_node = var.pm_node_name
  clone       = var.tamplate_vm_name
  os_type     = "cloud-init"
  agent       = 1
  memory      = var.node_worker_memory
  cores       = var.node_worker_cores

  sshkeys = var.node_sshkeys

  ipconfig0 = "ip=${var.node_worker_ips[count.index]}/${var.networkrange},gw=${var.gateway}"

  disk {
    type    = var.node_worker_disk_type
    storage = var.node_worker_disk_storage
    size    = var.node_worker_disk_size
  }

  lifecycle {
    ignore_changes = [
      ciuser,
      sshkeys,
      disk,
      network
    ]
  }

  timeouts {
    create = "20m"
    delete = "2h"
  }
}

resource "null_resource" "provision_ansible" {
  depends_on = [
    proxmox_vm_qemu.proxmox_vm_master,
    proxmox_vm_qemu.proxmox_vm_workers,
  ]
  connection {
    type     = "ssh"
    user     = "root"
    password = var.pm_password
    port     = 44022
    host     = var.pm_host
  }

  provisioner "remote-exec" {
    inline = [
      templatefile("scripts/run_ansible.sh.tftpl", {
        ansible_git_repository  = var.ansible_git_repository
        ansible_dir_name        = var.ansible_dir_name
        ansible_hosts_file_path = var.ansible_hosts_file_path
        master_ips              = var.node_master_ips
        worker_ips              = var.node_worker_ips
      })
    ]
  }
}

