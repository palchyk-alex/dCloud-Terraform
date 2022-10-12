# **dCloud** infrastructure

This repo contains terraform that deploys infrastructure for k3s cluster, and then applies **Ansible** that sets up k3s nodes.

Before deploying from scratch, you need to create passwordless SSH keys with name ```pm_id_rsa``` on Proxmox node (**pm_node_name** variable) 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 2.9.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.11 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.provision_ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [proxmox_vm_qemu.proxmox_vm_master](https://registry.terraform.io/providers/telmate/proxmox/2.9.11/docs/resources/vm_qemu) | resource |
| [proxmox_vm_qemu.proxmox_vm_workers](https://registry.terraform.io/providers/telmate/proxmox/2.9.11/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ansible_dir_name"></a> [ansible\_dir\_name](#input\_ansible\_dir\_name) | Directory where ansible is | `string` | `""` | no |
| <a name="input_ansible_git_repository"></a> [ansible\_git\_repository](#input\_ansible\_git\_repository) | Ansible repository to clone | `string` | `""` | no |
| <a name="input_ansible_hosts_file_path"></a> [ansible\_hosts\_file\_path](#input\_ansible\_hosts\_file\_path) | Path to hosts.ini file | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment of k3s cluster | `string` | `""` | no |
| <a name="input_gateway"></a> [gateway](#input\_gateway) | Default Gateway on created VMs | `string` | `""` | no |
| <a name="input_k3s_disable_components"></a> [k3s\_disable\_components](#input\_k3s\_disable\_components) | List of components to disable on k3s | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_networkrange"></a> [networkrange](#input\_networkrange) | CIDR block bits | `number` | `0` | no |
| <a name="input_node_master_cores"></a> [node\_master\_cores](#input\_node\_master\_cores) | Cores on master nodes | `number` | `0` | no |
| <a name="input_node_master_count"></a> [node\_master\_count](#input\_node\_master\_count) | Number of master nodes | `number` | `0` | no |
| <a name="input_node_master_disk_size"></a> [node\_master\_disk\_size](#input\_node\_master\_disk\_size) | Size of disks for masters VMs | `string` | `""` | no |
| <a name="input_node_master_disk_storage"></a> [node\_master\_disk\_storage](#input\_node\_master\_disk\_storage) | Proxmox storage to store masters VMs disks | `string` | `""` | no |
| <a name="input_node_master_disk_type"></a> [node\_master\_disk\_type](#input\_node\_master\_disk\_type) | Type of storage on master node | `string` | `""` | no |
| <a name="input_node_master_ips"></a> [node\_master\_ips](#input\_node\_master\_ips) | List of ip addresses for master nodes | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_node_master_memory"></a> [node\_master\_memory](#input\_node\_master\_memory) | RAM on master nodes | `string` | `""` | no |
| <a name="input_node_worker_cores"></a> [node\_worker\_cores](#input\_node\_worker\_cores) | Cores on worker nodes | `number` | `0` | no |
| <a name="input_node_worker_count"></a> [node\_worker\_count](#input\_node\_worker\_count) | Number of worker nodes | `number` | `0` | no |
| <a name="input_node_worker_disk_size"></a> [node\_worker\_disk\_size](#input\_node\_worker\_disk\_size) | Size of disks for workers VMs | `string` | `""` | no |
| <a name="input_node_worker_disk_storage"></a> [node\_worker\_disk\_storage](#input\_node\_worker\_disk\_storage) | Proxmox storage to store workers VMs disks | `string` | `""` | no |
| <a name="input_node_worker_disk_type"></a> [node\_worker\_disk\_type](#input\_node\_worker\_disk\_type) | Type of storage on worker node | `string` | `""` | no |
| <a name="input_node_worker_ips"></a> [node\_worker\_ips](#input\_node\_worker\_ips) | List of ip addresses for worker nodes | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_node_worker_memory"></a> [node\_worker\_memory](#input\_node\_worker\_memory) | RAM on worker nodes | `string` | `""` | no |
| <a name="input_pm_api_hostname"></a> [pm\_api\_hostname](#input\_pm\_api\_hostname) | IP or hostname for Proxmox API | `string` | `""` | no |
| <a name="input_pm_host"></a> [pm\_host](#input\_pm\_host) | The hostname or IP of the proxmox server | `string` | `""` | no |
| <a name="input_pm_node_name"></a> [pm\_node\_name](#input\_pm\_node\_name) | Name of the proxmox node to create the VMs on | `string` | `""` | no |
| <a name="input_pm_password"></a> [pm\_password](#input\_pm\_password) | The password for the proxmox user | `string` | `""` | no |
| <a name="input_pm_tls_insecure"></a> [pm\_tls\_insecure](#input\_pm\_tls\_insecure) | Set to true to ignore certificate errors | `bool` | `false` | no |
| <a name="input_pm_user"></a> [pm\_user](#input\_pm\_user) | The username for the proxmox user | `string` | `""` | no |
| <a name="input_pvt_key"></a> [pvt\_key](#input\_pvt\_key) | SSH private key for all nodes | `string` | `""` | no |
| <a name="input_pvt_key_path"></a> [pvt\_key\_path](#input\_pvt\_key\_path) | Path to SSH private key for all nodes | `string` | `""` | no |
| <a name="input_pvt_public_key"></a> [pvt\_public\_key](#input\_pvt\_public\_key) | SSH public key for all nodes | `string` | `""` | no |
| <a name="input_tamplate_vm_name"></a> [tamplate\_vm\_name](#input\_tamplate\_vm\_name) | Name of template from which to create nodes | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Master-IPS"></a> [Master-IPS](#output\_Master-IPS) | n/a |
| <a name="output_Worker-IPS"></a> [Worker-IPS](#output\_Worker-IPS) | n/a |
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 2.9.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.11 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.provision_ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [proxmox_vm_qemu.proxmox_vm_master](https://registry.terraform.io/providers/telmate/proxmox/2.9.11/docs/resources/vm_qemu) | resource |
| [proxmox_vm_qemu.proxmox_vm_workers](https://registry.terraform.io/providers/telmate/proxmox/2.9.11/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ansible_dir_name"></a> [ansible\_dir\_name](#input\_ansible\_dir\_name) | Directory where ansible is | `string` | `""` | no |
| <a name="input_ansible_git_repository"></a> [ansible\_git\_repository](#input\_ansible\_git\_repository) | Ansible repository to clone | `string` | `""` | no |
| <a name="input_ansible_hosts_file_path"></a> [ansible\_hosts\_file\_path](#input\_ansible\_hosts\_file\_path) | Path to hosts.ini file | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment of k3s cluster | `string` | `""` | no |
| <a name="input_gateway"></a> [gateway](#input\_gateway) | Default Gateway on created VMs | `string` | `""` | no |
| <a name="input_k3s_disable_components"></a> [k3s\_disable\_components](#input\_k3s\_disable\_components) | List of components to disable on k3s | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_networkrange"></a> [networkrange](#input\_networkrange) | CIDR block bits | `number` | `24` | no |
| <a name="input_node_master_cores"></a> [node\_master\_cores](#input\_node\_master\_cores) | Cores on master nodes | `number` | `4` | no |
| <a name="input_node_master_count"></a> [node\_master\_count](#input\_node\_master\_count) | Number of master nodes | `number` | `1` | no |
| <a name="input_node_master_disk_size"></a> [node\_master\_disk\_size](#input\_node\_master\_disk\_size) | Size of disks for masters VMs | `string` | `"20G"` | no |
| <a name="input_node_master_disk_storage"></a> [node\_master\_disk\_storage](#input\_node\_master\_disk\_storage) | Proxmox storage to store masters VMs disks | `string` | `""` | no |
| <a name="input_node_master_disk_type"></a> [node\_master\_disk\_type](#input\_node\_master\_disk\_type) | Type of storage on master node | `string` | `"scsi"` | no |
| <a name="input_node_master_ips"></a> [node\_master\_ips](#input\_node\_master\_ips) | List of ip addresses for master nodes | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_node_master_memory"></a> [node\_master\_memory](#input\_node\_master\_memory) | RAM on master nodes | `string` | `"4096"` | no |
| <a name="input_node_master_vmid"></a> [node\_master\_vmid](#input\_node\_master\_vmid) | ID of the node | `number` | `0` | no |
| <a name="input_node_sshkeys"></a> [node\_sshkeys](#input\_node\_sshkeys) | Newline delimited list of SSH public keys to add to authorized keys file for the cloud-init user | `string` | `""` | no |
| <a name="input_node_worker_cores"></a> [node\_worker\_cores](#input\_node\_worker\_cores) | Cores on worker nodes | `number` | `4` | no |
| <a name="input_node_worker_count"></a> [node\_worker\_count](#input\_node\_worker\_count) | Number of worker nodes | `number` | `4` | no |
| <a name="input_node_worker_disk_size"></a> [node\_worker\_disk\_size](#input\_node\_worker\_disk\_size) | Size of disks for workers VMs | `string` | `"20G"` | no |
| <a name="input_node_worker_disk_storage"></a> [node\_worker\_disk\_storage](#input\_node\_worker\_disk\_storage) | Proxmox storage to store workers VMs disks | `string` | `""` | no |
| <a name="input_node_worker_disk_type"></a> [node\_worker\_disk\_type](#input\_node\_worker\_disk\_type) | Type of storage on worker node | `string` | `"scsi"` | no |
| <a name="input_node_worker_ips"></a> [node\_worker\_ips](#input\_node\_worker\_ips) | List of ip addresses for worker nodes | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_node_worker_memory"></a> [node\_worker\_memory](#input\_node\_worker\_memory) | RAM on worker nodes | `string` | `"4096"` | no |
| <a name="input_node_worker_vmid"></a> [node\_worker\_vmid](#input\_node\_worker\_vmid) | ID of the node | `number` | `0` | no |
| <a name="input_pm_api_hostname"></a> [pm\_api\_hostname](#input\_pm\_api\_hostname) | IP or hostname for Proxmox API | `string` | `""` | no |
| <a name="input_pm_host"></a> [pm\_host](#input\_pm\_host) | The hostname or IP of the proxmox server | `string` | `""` | no |
| <a name="input_pm_node_name"></a> [pm\_node\_name](#input\_pm\_node\_name) | Name of the proxmox node to create the VMs on | `string` | `""` | no |
| <a name="input_pm_password"></a> [pm\_password](#input\_pm\_password) | The password for the proxmox user | `string` | `""` | no |
| <a name="input_pm_tls_insecure"></a> [pm\_tls\_insecure](#input\_pm\_tls\_insecure) | Set to true to ignore certificate errors | `bool` | `true` | no |
| <a name="input_pm_user"></a> [pm\_user](#input\_pm\_user) | The username for the proxmox user | `string` | `""` | no |
| <a name="input_tamplate_vm_name"></a> [tamplate\_vm\_name](#input\_tamplate\_vm\_name) | Name of template from which to create nodes | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Master-IPS"></a> [Master-IPS](#output\_Master-IPS) | n/a |
| <a name="output_Worker-IPS"></a> [Worker-IPS](#output\_Worker-IPS) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
