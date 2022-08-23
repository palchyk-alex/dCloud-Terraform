resource "proxmox_vm_qemu" "proxmox_vm_master" {
  count       = var.node_master_count
  name        = "k3s-master-${count.index}"
  target_node = var.pm_node_name
  clone       = var.tamplate_vm_name
  os_type     = "cloud-init"
  agent       = 1
  memory      = var.node_master_memory
  cores       = var.node_master_cores

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
}

resource "proxmox_vm_qemu" "proxmox_vm_workers" {
  count       = var.node_worker_count
  name        = "k3s-worker-${count.index}"
  target_node = var.pm_node_name
  clone       = var.tamplate_vm_name
  os_type     = "cloud-init"
  agent       = 1
  memory      = var.node_worker_memory
  cores       = var.node_worker_cores

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
}

data "template_file" "k8s" {
  template = file("./templates/k8s.tpl")
  vars = {
    k3s_master_ip = "${join("\n", [for instance in proxmox_vm_qemu.proxmox_vm_master : join("", [instance.default_ipv4_address, " ansible_ssh_private_key_file=", var.pvt_key])])}"
    k3s_node_ip   = "${join("\n", [for instance in proxmox_vm_qemu.proxmox_vm_workers : join("", [instance.default_ipv4_address, " ansible_ssh_private_key_file=", var.pvt_key])])}"
  }
}

resource "local_file" "k8s_file" {
  content  = data.template_file.k8s.rendered
  filename = "./inventory/hosts.ini"
}

