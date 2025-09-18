variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "webservers"
}

###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  description = "Default zone for resources"
  type        = string
  default     = "ru-central1-b"
}

variable "subnet_cidr" {
  description = "CIDR blocks for subnet"
  type        = list(string)
}

variable "vm_web_image" {
  description = "VM image family"
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 2
}

variable "vm_resources" {
  description = "VM resources configuration"
  type = object({
    cpu           = number
    ram           = number
    disk          = number
    core_fraction = number
  })
}

variable "platform_id" {
  description = "Platform ID for VMs"
  type        = string
  default     = "standard-v1"
}

variable "preemptible" {
  description = "Use preemptible VMs"
  type        = bool
  default     = true
}

variable "enable_nat" {
  description = "Enable NAT for VMs"
  type        = bool
  default     = true
}

variable "serial_port_enable" {
  description = "Enable serial port"
  type        = number
  default     = 1
}

variable "ssh_public_key_path" {
  description = "~/.ssh/yandex-cloud/id_rsa"
  type        = string
}