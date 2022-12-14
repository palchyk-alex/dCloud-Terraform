# ========== Proxmox Variables
variable "environment" {
  description = "Environment of k3s cluster"
  type        = string
  default     = ""
}

variable "pm_api_hostname" {
  description = "IP or hostname for Proxmox API"
  type        = string
  sensitive   = false
  default     = ""
}

variable "pm_user" {
  description = "The username for the proxmox user"
  type        = string
  sensitive   = false
  default     = ""
}

variable "pm_password" {
  description = "The password for the proxmox user"
  type        = string
  sensitive   = true
  default     = ""
}

variable "pm_tls_insecure" {
  description = "Set to true to ignore certificate errors"
  type        = bool
  default     = true
}

variable "pm_host" {
  description = "The hostname or IP of the proxmox server"
  type        = string
  default     = ""
}

variable "pm_node_name" {
  description = "Name of the proxmox node to create the VMs on"
  type        = string
  default     = ""
}

# ========== Ansible Variables
variable "ansible_git_repository" {
  description = "Ansible repository to clone"
  type        = string
  default     = ""
}

variable "ansible_dir_name" {
  description = "Directory where ansible is"
  type        = string
  default     = ""
}

variable "ansible_hosts_file_path" {
  description = "Path to hosts.ini file"
  type        = string
  default     = ""
}


# ========== Nodes common variables
variable "gateway" {
  description = "Default Gateway on created VMs"
  type        = string
  default     = ""
}

variable "networkrange" {
  description = "CIDR block bits"
  type        = number
  default     = 24
}

variable "tamplate_vm_name" {
  description = "Name of template from which to create nodes"
  type        = string
  default     = ""
}

variable "node_sshkeys" {
  description = "Newline delimited list of SSH public keys to add to authorized keys file for the cloud-init user"
  type        = string
  default     = ""
}

# ========== Master nodes variables
variable "node_master_count" {
  description = "Number of master nodes"
  type        = number
  default     = 1
}

variable "node_master_memory" {
  description = "RAM on master nodes"
  type        = string
  default     = "4096"
}

variable "node_master_vmid" {
  description = "ID of the node"
  type        = number
  default     = 0
}

variable "node_master_cores" {
  description = "Cores on master nodes"
  type        = number
  default     = 4
}

variable "node_master_ips" {
  description = "List of ip addresses for master nodes"
  type        = list(string)
  default     = [""]
}

variable "node_master_disk_type" {
  description = "Type of storage on master node"
  type        = string
  default     = "scsi"
}

variable "node_master_disk_storage" {
  description = "Proxmox storage to store masters VMs disks"
  type        = string
  default     = ""
}

variable "node_master_disk_size" {
  description = "Size of disks for masters VMs"
  type        = string
  default     = "20G"
}

# ========== Worker nodes variables
variable "node_worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 4
}

variable "node_worker_memory" {
  description = "RAM on worker nodes"
  type        = string
  default     = "4096"
}

variable "node_worker_vmid" {
  description = "ID of the node"
  type        = number
  default     = 0
}

variable "node_worker_cores" {
  description = "Cores on worker nodes"
  type        = number
  default     = 4
}

variable "node_worker_ips" {
  description = "List of ip addresses for worker nodes"
  type        = list(string)
  default     = [""]
}

variable "node_worker_disk_type" {
  description = "Type of storage on worker node"
  type        = string
  default     = "scsi"
}

variable "node_worker_disk_storage" {
  description = "Proxmox storage to store workers VMs disks"
  type        = string
  default     = ""
}

variable "node_worker_disk_size" {
  description = "Size of disks for workers VMs"
  type        = string
  default     = "20G"
}

# ========== K3s variables
variable "k3s_disable_components" {
  description = "List of components to disable on k3s"
  type        = list(string)
  default     = [""]
}

