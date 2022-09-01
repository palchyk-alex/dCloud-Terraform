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
      "pip3 install --user pipenv",
      "rm -rf dCloud-Ansible",
      "git clone https://github.com/palchyk-alex/dCloud-Ansible.git",
      "cd dCloud-Ansible",
      "python3 -m pipenv install",
      "python3 -m pipenv run install",
      "python3 -m pipenv run deploy",
    ]
  }
}

