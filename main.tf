resource "random_password" "k3s-server-token" {
  length           = 32
  special          = false
  override_special = "_%@"
}

resource "proxmox_vm_qemu" "proxmox_vm_master" {
  count       = var.node_master_count
  name        = "${var.environment}-k3s-master-${count.index}"
  target_node = var.pm_node_name
  clone       = var.tamplate_vm_name
  os_type     = "cloud-init"
  agent       = 1
  memory      = var.node_master_memory
  cores       = var.node_master_cores

  ipconfig0 = "ip=${var.node_master_ips[count.index]}/${var.networkrange},gw=${var.gateway}"

  ssh_user        = "root"
  ssh_private_key = var.pvt_key
  sshkeys         = var.pvt_public_key

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

  provisioner "remote-exec" {
    inline = [
      templatefile("./scripts/install-k3s-server.sh.tftpl", {
        mode         = "server"
        tokens       = [random_password.k3s-server-token.result]
        alt_names    = var.pm_api_hostname
        disable      = var.k3s_disable_components
      })
    ]
  }
}

resource "proxmox_vm_qemu" "proxmox_vm_workers" {
  depends_on = [
    proxmox_vm_qemu.proxmox_vm_master,
  ]

  count       = var.node_worker_count
  name        = "${var.environment}-k3s-worker-${count.index}"
  target_node = var.pm_node_name
  clone       = var.tamplate_vm_name
  os_type     = "cloud-init"
  agent       = 1
  memory      = var.node_worker_memory
  cores       = var.node_worker_cores

  ipconfig0 = "ip=${var.node_worker_ips[count.index]}/${var.networkrange},gw=${var.gateway}"

  ssh_user        = "root"
  ssh_private_key = var.pvt_key
  sshkeys         = var.pvt_public_key


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

  provisioner "remote-exec" {
    inline = [
      templatefile("./scripts/install-k3s-server.sh.tftpl", {
        mode         = "agent"
        tokens       = [random_password.k3s-server-token.result]
        alt_names    = ""
        disable      = []
      })
    ]
  }
}

