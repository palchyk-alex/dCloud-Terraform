output "Master-IPS" {
  value = ["${proxmox_vm_qemu.proxmox_vm_master.*.default_ipv4_address}"]
}

output "Worker-IPS" {
  value = ["${proxmox_vm_qemu.proxmox_vm_workers.*.default_ipv4_address}"]
}

#output "k3s_kubeconfig" {
#  value     = replace(base64decode(replace(data.external.kubeconfig.result.kubeconfig, " ", "")), "server: https://127.0.0.1:6443", "server: https://${var.pm_api_hostname}:44023")
#  sensitive = true
#}
